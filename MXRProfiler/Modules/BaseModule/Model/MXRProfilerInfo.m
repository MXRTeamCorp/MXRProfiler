//
//  MXRProfilerInfo.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerInfo.h"

@implementation MXRProfilerInfo

+ (instancetype)sharedInstance
{
    SINGLE_INSTANCE_USING_BLOCK(^{
        MXRProfilerInfo *profilerInfo = [[self alloc] init];
        profilerInfo->_profilerModes = MXRProfilerModeALL;
        return profilerInfo;
        
    });
}

- (NSString *)currentVCClassName
{
    return _currentVCClassName ?: @"";
}

- (NSMutableArray *)standstaillInfos
{
    if (!_standstaillInfos) {
        _standstaillInfos = [NSMutableArray arrayWithCapacity:1 << 6];
    }
    return _standstaillInfos;
}

@end
