//
//  MXRMonitorNetFlow.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/7.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRMonitorNetFlow.h"

@interface MXRMonitorNetFlow()

@end

@implementation MXRMonitorNetFlow

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static MXRMonitorNetFlow *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)startMonitor:(NSURLRequest*)urlRequest responseObject:(id)responseObject{
    
}

-(void)startMonitor:(NSString*)urlString parameters:(id)parameters responseObject:(id)responseObject{
    
}



@end
