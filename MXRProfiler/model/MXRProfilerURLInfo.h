//
//  MXRProfilerURLInfo.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/22.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRProfilerURLInfo : NSObject

@property (nonatomic, strong) NSString *preURLString;         //
@property (nonatomic, strong) NSString *absoluteURLString;
@property (nonatomic, strong) NSString *VCClassString;
@property (nonatomic, strong) NSString *VCTitle;
@property (nonatomic, assign) NSUInteger requestCount;
@property (nonatomic, assign) NSUInteger requestSize;
@property (nonatomic, assign) NSUInteger responseSize;

@property (nonatomic, assign) NSUInteger requestDateTimeIntervalSince1970;
@property (nonatomic, assign) NSUInteger finishLodadDateTimeIntervalSince1970;

- (void)resetInfo;
@end
