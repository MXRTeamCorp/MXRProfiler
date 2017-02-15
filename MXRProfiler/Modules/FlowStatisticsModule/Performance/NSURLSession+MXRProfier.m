//
//  NSURLSession+MXRProfier.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/14.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "NSURLSession+MXRProfier.h"
#import "NSObject+MXRSwizz.h"
#import "MXRMonitorNetFlow.h"

@implementation NSURLSession(MXRProfier)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self mxr_swizzleSEL:@selector(dataTaskWithRequest:completionHandler:) withSEL:@selector(mxr_swizzle_dataTaskWithRequest:completionHandler:)];
        
        [self mxr_swizzleSEL:@selector(downloadTaskWithRequest:completionHandler:) withSEL:@selector(mxr_swizzle_downloadTaskWithRequest:completionHandler:)];
        
        [self mxr_swizzleSEL:@selector(uploadTaskWithRequest:fromData:completionHandler:) withSEL:@selector(mxr_swizzle_uploadTaskWithRequest:fromData:completionHandler:)];
        
        [self mxr_swizzleSEL:@selector(uploadTaskWithRequest:fromFile:completionHandler:) withSEL:@selector(mxr_swizzle_uploadTaskWithRequest:fromFile:completionHandler:)];
    });
}


- (NSURLSessionDataTask *)mxr_swizzle_dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    void (^hookCompletionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        [[MXRMonitorNetFlow sharedInstance] analyze:request responseData:data error:error];
        completionHandler(data,response,error);
    };
    return [self mxr_swizzle_dataTaskWithRequest:request completionHandler:hookCompletionHandler];;
}

- (NSURLSessionDataTask *)mxr_swizzle_downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    void (^hookCompletionHandler)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error){
        [[MXRMonitorNetFlow sharedInstance] analyze:request location:location error:error];
        completionHandler(location,response,error);
    };
    return [self mxr_swizzle_downloadTaskWithRequest:request completionHandler:hookCompletionHandler];
}


- (NSURLSessionDataTask *)mxr_swizzle_uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    void (^hookCompletionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        [[MXRMonitorNetFlow sharedInstance] analyze:request requestData:bodyData responseData:data error:error];
        completionHandler(data,response,error);
    };
    return [self mxr_swizzle_uploadTaskWithRequest:request fromData:bodyData completionHandler:hookCompletionHandler];
}


- (NSURLSessionDataTask *)mxr_swizzle_uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    void (^hookCompletionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        [[MXRMonitorNetFlow sharedInstance] analyze:request requestFile:fileURL responseData:data error:error];
        completionHandler(data,response,error);
    };
    return [self mxr_swizzle_uploadTaskWithRequest:request fromFile:fileURL completionHandler:hookCompletionHandler];
}


@end
