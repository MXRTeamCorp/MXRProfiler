//
//  MXRProfilerPresentationModeDelegate.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MXRProfilerPresentationMode) {
    MXRProfilerPresentationMode_SimpleInfo = 0,//基本信息
    MXRProfilerPresentationMode_Standstill,//卡顿信息
    MXRProfilerPresentationMode_NetFlow,//流量
};

@protocol MXRProfilerPresentationModeDelegate <NSObject>

- (void)presentationDelegateChangePresentationModeToMode:(MXRProfilerPresentationMode)mode;

@end
