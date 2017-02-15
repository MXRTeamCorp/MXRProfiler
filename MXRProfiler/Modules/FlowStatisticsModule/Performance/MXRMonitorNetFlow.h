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
 @param data 返回的数据
 @param error 错误信息
 */
-(void)analyze:(NSURLRequest*)urlRequest responseData:(NSData*)data error:(NSError*)error;


/**
 根据请求和返回值进行分析

 @param urlRequest 请求
 @param location 文件地址
 @param error 错误信息
 */
-(void)analyze:(NSURLRequest*)urlRequest location:(NSURL*)location error:(NSError*)error;


/**
 根据请求和返回值进行分析

 @param urlRequest 请求
 @param fileURL 上传文件的url
 @param data 返回的数据
 @param error 错误信息
 */
-(void)analyze:(NSURLRequest*)urlRequest requestFile:(NSURL *)fileURL responseData:(NSData*)data error:(NSError*)error;



/**
 根据请求和返回值进行分析

 @param urlRequest 请求
 @param requestData 上传的文件的data
 @param data 返回的数据
 @param error 错误信息
 */
-(void)analyze:(NSURLRequest*)urlRequest requestData:(NSData *)requestData responseData:(NSData*)data error:(NSError*)error;
@end
