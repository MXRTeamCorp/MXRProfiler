//
//  MXRProfilerUtils.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/17.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRProfilerMacro.h"

MXR_EXTERN_C_BEGIN


uint64_t MXRProfilerResidentMemoryInBytes(void);

/**
 Total physical memory in byte. (-1 when error occurs)
 */
int64_t MXRProfiler_MemoryTotal(void);

/**
  Used (active + inactive + wired) memory in byte. (-1 when error occurs)
 */
int64_t MXRProfiler_MemoryUsed(void);

float MXRProfiler_MemoryUsedPercent(void);

/**
 Current CPU usage percent 1.0 means 100%. (0.0 when error occurs)
 */
float MXRProfiler_CpuUsedPercent(void);

/**
 返回当前有关流量数据的数组。
 @param networkFlows 含有4个int的数组
 
 @return 含有4个int数组的指针，该数组组成如下
            第一个表示wifi下上传的数据总量，
            第二个表示wifi下下载的数据总量，
            第三个表示wwan下上传的数据总量，
            第四个表示wwan下下载的数据总量，
 */
int *getNetworkFlows(int networkFlows[]);

MXR_EXTERN_C_END
