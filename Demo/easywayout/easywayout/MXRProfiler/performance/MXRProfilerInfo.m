//
//  MXRProfilerInfo.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerInfo.h"
#import "MXRProfilerMacro.h"

@implementation MXRProfilerInfo

+ (instancetype)sharedInstance
{
    SINGLE_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
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
