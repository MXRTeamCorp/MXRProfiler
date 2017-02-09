//
//  MXRProfilerInfo.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRProfilerTool.h"

#define MXRPROFILERINFO [MXRProfilerInfo sharedInstance]

@interface MXRProfilerInfo : NSObject

+ (instancetype)sharedInstance;

/**
 表示检测手机哪些性能，需要在startAnalyze前设置好。默认所有都检测
 indicate the which performaces will be monitored.
 should set it before invoke startAnalyze. default is MXRProfilerModeALL
 */
///
@property (nonatomic, assign) MXRProfilerModes profilerModes;

/**
 表示窗口当前显示的viewcontroller
 */
@property (nonatomic, strong) NSString *currentVCClassName;

/**
 卡顿信息的缓存
 */
@property (nonatomic, strong) NSMutableArray *standstaillInfos;

/**
 是否有新的卡顿信息
 */
@property (nonatomic, assign) BOOL standstaillSign;


@end
