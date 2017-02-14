//
//  MXRMonitorRunloop.h
//  easywayout
//
//  Created by Martin.Liu on 17/1/19.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 原理：利用观察Runloop各种状态变化的持续时间来检测计算是否发生卡顿
 一次有效卡顿采用了“N次卡顿超过阈值T”的判定策略，即一个时间段内卡顿的次数累计大于N时才触发采集和上报：举例，卡顿阈值T=500ms、卡顿次数N=1，可以判定为单次耗时较长的一次有效卡顿；而卡顿阈值T=50ms、卡顿次数N=5，可以判定为频次较快的一次有效卡顿
 */
@interface MXRMonitorRunloop : NSObject

+ (instancetype)sharedInstance;

/**
 超过多少毫秒为一次卡顿，默认50毫秒，最小值为20毫秒
 When response time more than limitMillisecond , will increase one. default is 300, minum is 1.
    default num
 
                 ⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼
                │ machie type       │  millisecond  │     count     │
                │———————————————————│———————————————│———————————————│
                │    old machie     │      600      │       5       │
                │———————————————————│———————————————│———————————————│
                │  iPhone 5 series  │      500      │       5       │
                │———————————————————│———————————————│———————————————│
                │  iPhone 6 series  │      400      │       5       │
                │———————————————————│———————————————│———————————————│
                │  iPhone 7 series  │      500      │       5       │
                │———————————————————│———————————————│———————————————│
                │      ohters       │      300      │       5       │
                 ⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺
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
