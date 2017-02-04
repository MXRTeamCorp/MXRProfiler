//
//  MXRProfilerURLProtocol.m
//  easywayout
//
//  Created by mxr on 17/1/19.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerURLProtocol.h"
#import "MXRWeakProxy.h"
#import "MXRProfilerMacro.h"

NSString *const MXRPROfilerURLProkey = @"MXRPROfilerURLProkey";

@interface MXRProfilerURLProtocol() <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic,strong) NSURLConnection *connection;
@property (nonatomic,strong) MXRProfilerURLInfo *currrentUrlInfo;

@end

@implementation MXRProfilerURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    return [self canInitWithURLRequest:request];
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task
{
    return [self canInitWithURLRequest:task.currentRequest];
}

+ (BOOL)canInitWithURLRequest:(NSURLRequest*)request
{
    NSString *scheme = [[request URL] scheme];
    NSLog(@">> url prerequest: %@, %@", scheme, request.URL.absoluteString);
    if ( ([scheme caseInsensitiveCompare:@"http"]  == NSOrderedSame ||
          [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame ))
    {
        if ([NSURLProtocol propertyForKey:MXRPROfilerURLProkey inRequest:request]) {
            return NO;
        }
        NSLog(@">> url request: %@", request.URL.absoluteString);
        return YES;
    }
    return NO;
    
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}


+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (MXRProfilerURLInfo *)currrentUrlInfo
{
    if (!_currrentUrlInfo) {
        _currrentUrlInfo = [[MXRProfilerURLInfo alloc] init];
    }
    return _currrentUrlInfo;
}

- (NSString *)urlStrWithoutParamsWithUrlStr:(NSString *)url
{
    if ([url rangeOfString:@"?"].location != NSNotFound) {
        return [url componentsSeparatedByString:@"?"][0];
    }
    return url;
}

- (void)startLoading;
{
    //    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    //    self.task = [session dataTaskWithRequest:self.request];
    //    [self.task resume];
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //    //标示改request已经处理过了，防止无限循环
    [NSURLProtocol setProperty:@YES forKey:MXRPROfilerURLProkey inRequest:mutableReqeust];
    //    self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
    
    self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:[MXRWeakProxy proxyWithTarget:self]];
    NSLog(@">> url start: %@", self.request.URL);
    [self.currrentUrlInfo resetInfo];
    self.currrentUrlInfo.preURLString = [self urlStrWithoutParamsWithUrlStr:mutableReqeust.URL.absoluteString];
    self.currrentUrlInfo.absoluteURLString = mutableReqeust.URL.absoluteString;
    self.currrentUrlInfo.requestSize = mutableReqeust.HTTPBody.length;
    self.currrentUrlInfo.requestCount = 1;
    [MXRPROFILERVCURLMANAGER addURLInfo:self.currrentUrlInfo];
    
}

- (void)stopLoading
{
    if (self.connection) {
        [self.connection cancel];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.client URLProtocolDidFinishLoading:self];
    
    if (connection.originalRequest) {
        NSLog(@"self : %p, self.connection : %p , connection : %p, endtime: %f \nrequestSize:%lu \ncontentType:%@",self, self.connection, connection, [[NSDate date] timeIntervalSince1970], connection.originalRequest.HTTPBody.length, connection.originalRequest.allHTTPHeaderFields);
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //开始接收数据
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //正在接收数据
    [self.client URLProtocol:self didLoadData:data];
    
    self.currrentUrlInfo.responseSize = data.length;
    [MXRPROFILERVCURLMANAGER updateURLInfo:self.currrentUrlInfo];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //接收数据失败
    NSLog(@"%@",error);
    [self.client URLProtocol:self didFailWithError:error];
}


@end

@implementation MXRProfilerVCURLManager

+ (instancetype)sharedInstance
{
    SINGLE_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (void)addURLInfo:(MXRProfilerURLInfo *)_urlInfo
{
    _urlInfo.VCClassString = self.currentVCClassName;
    _urlInfo.VCTitle = self.currentVCTitle;
    MXRProfilerURLInfo *urlInfo = [_urlInfo copy];
    [self.URLInfoArray addObject:urlInfo];
    
    //    NSUInteger index = [self.URLInfoArray indexOfObject:_urlInfo];
    //    if (index == NSNotFound) {
    //        MXRProfilerURLInfo *urlInfo = [_urlInfo copy];
    //        [self.URLInfoArray addObject:urlInfo];
    //    }
    //    else
    //    {
    //        MXRProfilerURLInfo *urlInfo = [self.URLInfoArray objectAtIndex:index];
    //        urlInfo.requestSize += _urlInfo.requestSize;
    //        urlInfo.responseSize += _urlInfo.responseSize;
    //        urlInfo.requestCount ++;
    //    }
}

- (void)updateURLInfo:(MXRProfilerURLInfo *)_urlInfo
{
    _urlInfo.VCClassString = self.currentVCClassName;
    _urlInfo.VCTitle = self.currentVCTitle;
    NSUInteger index = [self.URLInfoArray indexOfObject:_urlInfo];
    if (index != NSNotFound) {
        MXRProfilerURLInfo *urlInfo = [self.URLInfoArray objectAtIndex:index];
        urlInfo.responseSize += _urlInfo.responseSize;
    }
    
    //    else
    //    {
    //        MXRProfilerURLInfo *urlInfo = [_urlInfo copy];
    //        [self.URLInfoArray addObject:urlInfo];
    //    }
}

- (NSMutableArray *)URLInfoArray
{
    if (!_URLInfoArray) {
        _URLInfoArray = [NSMutableArray array];
    }
    return _URLInfoArray;
}

- (NSString *)currentVCTitle
{
    return _currentVCTitle ?: @"";
}

- (NSString *)currentVCClassName
{
    return _currentVCClassName ?: @"";
}

@end
