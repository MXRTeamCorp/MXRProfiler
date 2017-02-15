//
//  MXRMonitorNetFlow.h
//  easywayout
//
//  Created by weiqing.tang on 2017/2/7.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRMonitorNetFlow : NSObject


+ (instancetype)sharedInstance;



/**
 开始监听流量
 */
-(void)startMonitor;


/**
 结束监听流量
 */
-(void)endMonitor;



/**
 根据请求和返回值进行分析

 @param urlRequest 请求
 @param data 返回值
 */
-(void)analyze:(NSURLRequest*)urlRequest data:(NSData*)data error:(NSError*)error;
@end
