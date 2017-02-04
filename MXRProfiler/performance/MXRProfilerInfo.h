//
//  MXRProfilerInfo.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MXRPROFILERINFO [MXRProfilerInfo sharedInstance]

@interface MXRProfilerInfo : NSObject

@property (nonatomic, strong) NSString *currentVCClassName;

@property (nonatomic, strong) NSMutableArray *standstaillInfos;

@property (nonatomic, assign) BOOL standstaillSign;

+ (instancetype)sharedInstance;

@end
