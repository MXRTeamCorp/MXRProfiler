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
        [self mxr_swizzleSEL:@selector(dataTaskWithURL:completionHandler:) withSEL:@selector(mxr_swizzle_dataTaskWithURL:completionHandler:)];
        
        [self mxr_swizzleSEL:@selector(dataTaskWithRequest:completionHandler:) withSEL:@selector(mxr_swizzle_dataTaskWithRequest:completionHandler:)];
    });
}

- (NSURLSessionDataTask *)mxr_swizzle_dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    void (^hookCompletionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        [[MXRMonitorNetFlow sharedInstance] analyze:[NSURLRequest requestWithURL:url] data:data error:error];
        completionHandler(data,response,error);
    };
    return [self mxr_swizzle_dataTaskWithURL:url completionHandler:hookCompletionHandler];
}


- (NSURLSessionDataTask *)mxr_swizzle_dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    void (^hookCompletionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        [[MXRMonitorNetFlow sharedInstance] analyze:request data:data error:error];
        completionHandler(data,response,error);
    };
    return [self mxr_swizzle_dataTaskWithRequest:request completionHandler:hookCompletionHandler];;
}


@end
