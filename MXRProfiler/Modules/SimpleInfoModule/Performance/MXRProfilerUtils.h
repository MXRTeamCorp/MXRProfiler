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

int64_t MXRProfiler_MemoryTotal(void);

int64_t MXRProfiler_MemoryUsed(void);

float MXRProfiler_MemoryUsedPercent(void);

float MXRProfiler_CpuUsedPercent(void);

int *getNetworkFlows(int networkFlows[]);

MXR_EXTERN_C_END
