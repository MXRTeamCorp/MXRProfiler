//
//  MXRNetFlowTest.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/15.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRNetFlowTest.h"

@implementation MXRNetFlowTest

+(void)testDataWithURL{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"https://www.baidu.com"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"len=%ld",(long)string.length);
    }] resume];

}

+(void)testDataWithRequest{
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.jd.com"]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
    }] resume];
}

+(void)testDowloadWithURL{

    NSURLSession *session = [NSURLSession sharedSession];
    [[session downloadTaskWithURL:[NSURL URLWithString:@"https://www.taobao.com/"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }] resume];
}

+(void)testDowloadWithRequest{
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.taobao.com/request"]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session downloadTaskWithRequest:mutableRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }] resume];
}
+(void)testUploadFromFile{
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.linkedin.com/uploadfile"]];
    [mutableRequest setValue:@"aaaa" forHTTPHeaderField:@"bbb"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    [[session uploadTaskWithRequest:mutableRequest fromFile:[NSURL fileURLWithPath:path] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }]resume];
}

+(void)testUploadFromData{
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.linkedin.com/uploaddata"]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session uploadTaskWithRequest:mutableRequest fromData:[[NSData alloc] initWithBytes:"aaaa" length:4] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }] resume];
}

@end
