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
 监听服务的请求和返回

 @param urlRequest 请求
 @param responseObject 返回结果
 */
-(void)startMonitor:(NSURLRequest*)urlRequest responseObject:(id)responseObject;


/**
 监听服务的请求和返回

 @param urlString 请求地址
 @param parameters 请求参数
 @param responseObject 返回结果
 */
-(void)startMonitor:(NSString*)urlString parameters:(id)parameters responseObject:(id)responseObject;
@end
