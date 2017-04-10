//
//  MXRMonitorNetFlow.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/7.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRMonitorNetFlow.h"
#import "MXRNetFlowInfo.h"
#import "MXRProfilerInfo.h"
#import "MXRUtility.h"
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

#pragma Public Method
-(void)startMonitor{
    _isStart  =  YES;
}

-(void)endMonitor{
    _isStart = NO;
}

-(void)analyze:(NSURLRequest*)urlRequest responseData:(NSData*)data error:(NSError*)error{
    if(!_isStart)  return;
    [self _analyze:urlRequest requestDatalength:0 responseData:data error:error];
}

-(void)analyze:(NSURLRequest*)urlRequest location:(NSURL*)location error:(NSError*)error{
    if(!_isStart)  return;
}

-(void)analyze:(NSURLRequest*)urlRequest requestFile:(NSURL *)fileURL responseData:(NSData*)data error:(NSError*)error{
    if(!_isStart)  return;
    [self _analyze:urlRequest requestDatalength:[self _fileSizeAtPath:[fileURL absoluteString]] responseData:data error:error];
}

-(void)analyze:(NSURLRequest*)urlRequest requestData:(NSData *)requestData responseData:(NSData*)data error:(NSError*)error{
    if(!_isStart)  return;
    NSUInteger requestDatalength = 0;
    if(data){
        NSString *dataString = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
        requestDatalength    = dataString.length;
    }
    
    [self _analyze:urlRequest requestDatalength:requestDatalength responseData:data error:error];
}


#pragma Private Method
- (long long)_fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

-(void)_analyze:(NSURLRequest*)urlRequest requestDatalength:(NSUInteger)len responseData:(NSData*)data error:(NSError*)error{
    NSString *url   = [[urlRequest URL] absoluteString];
    NSDictionary<NSString *, NSString *> *dict = urlRequest.allHTTPHeaderFields;
    NSUInteger requestAmount = 0;
    if(dict.count >0){
        for(NSString *key in dict.allKeys){
            requestAmount += key.length;
        }
        for(NSString *value in dict.allValues){
            requestAmount += value.length;
        }
    }
    
    if(urlRequest.HTTPBody){
        NSString *bodyString = [[NSString alloc] initWithData:urlRequest.HTTPBody encoding:NSUTF8StringEncoding];
        requestAmount += bodyString.length;
    }
    
    NSUInteger responseAmount = 0;
    if(!error && data){
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        responseAmount += responseString.length;
    }
    
    MXRNetFlowInfo *info = [[MXRNetFlowInfo alloc] init];
    info.url = url;
    info.currentVCClassName =  MXRPROFILERINFO.currentVCClassName;
    info.flowAmountRequest  = requestAmount + len;
    info.flowAmountResponse = responseAmount;
    info.HTTPMethod         = urlRequest.HTTPMethod;
    info.happendTimeIntervalSince1970   = [[NSDate new] timeIntervalSince1970];
    MXRInfoLog(@"%@",[info description]);
    [[MXRPROFILERINFO netFlowInfos] addObject:info];
    [[NSNotificationCenter defaultCenter] postNotificationName:MXRPROFILERNOTIFICATION_HAPPENSTANDSTILL object:nil];
    
}


@end
