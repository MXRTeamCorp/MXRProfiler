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
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.csdn.net"]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
    }] resume];
}
@end
