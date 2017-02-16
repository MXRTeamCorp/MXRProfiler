//
//  MXRNetFlowInfo.h
//  easywayout
//
//  Created by weiqing.tang on 2017/2/15.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRNetFlowInfo : NSObject

/**
 请求的URL地址
 */
@property(nonatomic,copy)   NSString    *url;


/**
 当前页面的名字
 */
@property(nonatomic,copy)   NSString    *currentVCClassName;


/**
 请求消耗的流量
 */
@property(nonatomic,assign) NSUInteger  flowAmountRequest;


/**
 返回消耗的流量
 */
@property(nonatomic,assign) NSUInteger  flowAmountResponse;


/**
 发生的时间
 */
@property(nonatomic,assign)   NSTimeInterval happendTimeIntervalSince1970;


/**
 网络状态  蜂窝 Wifi
 */
@property(nonatomic,assign) NSUInteger  netStatus;


/**
 GET PUT DELETE
 */
@property(nonatomic,copy)   NSString    *HTTPMethod;



/**
 返回上传和下载的流量的之和
 */
@property(nonatomic,assign,readonly)    NSUInteger flowAmountTotal;

@end
