//
//  MXRMonitorNetFlow.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/7.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRMonitorNetFlow.h"

@interface MXRMonitorNetFlow()


/**
 控制是否开启流量监测
 */
@property(nonatomic,assign) BOOL isStart;
@end

@implementation MXRMonitorNetFlow

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static MXRMonitorNetFlow *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.isStart = NO;
    });
    return sharedInstance;
}

-(void)startMonitor{
    _isStart  =  YES;
}

-(void)endMonitor{
    _isStart = NO;
}

-(void)analyze:(NSURLRequest*)urlRequest data:(NSData*)data error:(NSError*)error{
    if(!_isStart)  return;
}


@end
