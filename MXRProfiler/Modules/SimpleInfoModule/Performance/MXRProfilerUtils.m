//
//  MXRProfilerUtils.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/17.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerUtils.h"
#import <UIKit/UIKit.h>

#import <mach/mach.h>
#import <mach/mach_host.h>
#include <sys/sysctl.h>

#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

///****************************************************************************************************
/// memory
///****************************************************************************************************
uint64_t MXRProfilerResidentMemoryInBytes() {
    kern_return_t rval = 0;
    mach_port_t task = mach_task_self();
    
    struct task_basic_info info = {0};
    mach_msg_type_number_t tcnt = TASK_BASIC_INFO_COUNT;
    task_flavor_t flavor = TASK_BASIC_INFO;
    
    task_info_t tptr = (task_info_t) &info;
    
    if (tcnt > sizeof(info))
        return 0;
    
    rval = task_info(task, flavor, tptr, &tcnt);
    if (rval != KERN_SUCCESS) {
        return 0;
    }
    
    return info.resident_size;
}

int64_t MXRProfiler_MemoryTotal()
{
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    if (mem < -1) mem = -1;
    return mem;
}

int64_t MXRProfiler_MemoryUsed()
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return page_size * (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count);
}

float MXRProfiler_MemoryUsedPercent()
{
    return (float)MXRProfilerResidentMemoryInBytes()/MXRProfiler_MemoryTotal();
}

///****************************************************************************************************
/// cpu
///****************************************************************************************************
NSArray * MXRProfiler_cpuUsagePerProcessor(void);
float cpu_usage(void);

float MXRProfiler_CpuUsedPercent()
{
    return cpu_usage();
//    float cpu = 0;
//    NSArray *cpus = MXRProfiler_cpuUsagePerProcessor();
//    if (cpus.count == 0) return -1;
//    for (NSNumber *n in cpus) {
//        cpu += n.floatValue;
//    }
//    return cpu;
}

NSArray * MXRProfiler_cpuUsagePerProcessor()
{
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }

}

float cpu_usage()
{
    kern_return_t			kr = { 0 };
    task_info_data_t		tinfo = { 0 };
    mach_msg_type_number_t	task_info_count = TASK_INFO_MAX;
    
    kr = task_info( mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
    task_basic_info_t		basic_info = { 0 };
    thread_array_t			thread_list = { 0 };
    mach_msg_type_number_t	thread_count = { 0 };
    
    thread_info_data_t		thinfo = { 0 };
    thread_basic_info_t		basic_info_th = { 0 };
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads( mach_task_self(), &thread_list, &thread_count );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
    long	tot_sec = 0;
    long	tot_usec = 0;
    float	tot_cpu = 0;
    
    for ( int i = 0; i < thread_count; i++ )
    {
        mach_msg_type_number_t thread_info_count = THREAD_INFO_MAX;
        
        kr = thread_info( thread_list[i], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count );
        if ( KERN_SUCCESS != kr )
            return 0.0f;
        
        basic_info_th = (thread_basic_info_t)thinfo;
        if ( 0 == (basic_info_th->flags & TH_FLAGS_IDLE) )
        {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
    }
    
    kr = vm_deallocate( mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t) );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
    return tot_cpu;
}

///****************************************************************************************************
/// networkflow
///****************************************************************************************************
int* getNetworkFlows(int networkFlows[])
{
    BOOL   success;
    struct ifaddrs*addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    
    success = getifaddrs(&addrs) == 0;
    if(success)
    {
        cursor = addrs;
        while(cursor != NULL)
        {
            char *ifa_name = cursor->ifa_name;
            if(cursor->ifa_addr->sa_family == AF_LINK && ifa_name)
            {
                if(strstr(ifa_name, "en"))
                {
                    networkStatisc = (const struct if_data*) cursor->ifa_data;
                    WiFiSent += networkStatisc->ifi_obytes;
                    WiFiReceived += networkStatisc->ifi_ibytes;
                }
                if(strstr(ifa_name, "pdp_ip"))
                {
                    networkStatisc = (const struct if_data*) cursor->ifa_data;
                    WWANSent += networkStatisc->ifi_obytes;
                    WWANReceived += networkStatisc->ifi_ibytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    networkFlows[0] = WiFiSent;
    networkFlows[1] = WiFiReceived;
    networkFlows[2] = WWANSent;
    networkFlows[3] = WWANReceived;
    return networkFlows;
}
