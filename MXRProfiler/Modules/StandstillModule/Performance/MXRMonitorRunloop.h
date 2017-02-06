//
//  MXRMonitorRunloop.h
//  easywayout
//
//  Created by Martin.Liu on 17/1/19.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRMonitorRunloop : NSObject

+ (instancetype)sharedInstance;

/**
 超过多少毫秒为一次卡顿，默认50毫秒，最小值为20毫秒
 When response time more than limitMillisecond , will increase one. default is 50, minum is 20.
 */
@property (nonatomic, assign) int limitMillisecond;     // 超过多少毫秒为一次卡顿

/**
 多少次卡顿纪录为一次有效，默认为5次，最小值为一次
 Accumulation is equal to standstillCount, indicate one valid standstill. default is 5 , minnum is 1.
 */
@property (nonatomic, assign) int standstillCount;         // 多少次卡顿纪录为一次有效卡顿

/**
 start monitor standstill
 */
- (void)startMonitor;

/**
 end monitor standstill
 */
- (void)endMonitor;


/**
 发生一次有效的卡顿回调函数
 invoke it when happend a valid standstill.
 */
@property (nonatomic, copy) void (^callbackWhenStandStill)();

@end
