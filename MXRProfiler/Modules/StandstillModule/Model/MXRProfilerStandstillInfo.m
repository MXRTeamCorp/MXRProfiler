//
//  MXRProfilerStandstillInfo.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerStandstillInfo.h"
#import "MXRMonitorRunloop.h"

@implementation MXRProfilerStandstillInfo

- (instancetype)init
{
    if (self = [super init]) {
        self.limitMillisecond = [MXRMonitorRunloop sharedInstance].limitMillisecond;
        self.standstillCount = [MXRMonitorRunloop sharedInstance].standstillCount;
    }
    return self;
}

@end
