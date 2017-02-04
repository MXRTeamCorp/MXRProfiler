//
//  MXRProfilerURLProtocol.h
//  easywayout
//
//  Created by mxr on 17/1/19.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRProfilerURLInfo.h"

@interface MXRProfilerURLProtocol : NSURLProtocol

@end

#define MXRPROFILERVCURLMANAGER [MXRProfilerVCURLManager sharedInstance]

@interface MXRProfilerVCURLManager : NSObject

@property (nonatomic, strong) NSString* currentVCTitle;
@property (nonatomic, strong) NSString* currentVCClassName;

@property (nonatomic, strong) NSMutableArray* URLInfoArray;

- (void)addURLInfo:(MXRProfilerURLInfo *)urlInfo;

- (void)updateURLInfo:(MXRProfilerURLInfo *)urlInfo;

+ (instancetype)sharedInstance;


@end
