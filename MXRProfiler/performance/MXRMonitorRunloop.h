//
//  MXRMonitorRunloop.h
//  easywayout
//
//  Created by mxr on 17/1/19.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRMonitorRunloop : NSObject
+ (instancetype)sharedInstance;
- (void)startMonitor;
- (void)endMonitor;

@property (nonatomic, copy) void (^callbackWhenStandStill)();

@end
