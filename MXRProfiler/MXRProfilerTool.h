//
//  MXRProfilerTool.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRProfilerPresentationModeDelegate.h"

typedef NS_OPTIONS(NSUInteger, MXRProfilerModes) {
    MXRProfilerModeALL          = 0xFFFFFFFF,
    MXRProfilerModeNone         = 0,
    
    MXRProfilerModeSimpleInfo   = 0x000000FF,
    MXRProfilerModeCpu          = 1 << 0,
    MXRProfilerModeFps          = 1 << 1,
    MXRProfilerModeMemory       = 1 << 2,
    MXRProfilerModeNetflowSpeed = 1 << 3,
    
    MXRProfilerModeStandstill   = 1 << 16,
    MXRProfilerModeMemoryLeak   = 1 << 17,
    
};

@interface MXRProfilerTool : NSObject

@property (nonatomic, assign, readonly) BOOL isAnalyzing;

- (void)setProfilerModes:(MXRProfilerModes)profilerModes;

/// 配置一次有效卡顿发生的条件。  limitMillisecond：超过多少毫秒为一次卡顿，standstillCount：多少次卡顿纪录为一次有效
- (void)setValidStandstillLimitMillisecond:(int)limitMillisecond count:(int)standstillCount;

- (void)startAnalyze;

- (void)endAnalyze;

@end
