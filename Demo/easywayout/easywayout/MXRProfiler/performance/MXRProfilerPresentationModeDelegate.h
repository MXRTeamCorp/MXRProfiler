//
//  MXRProfilerPresentationModeDelegate.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MXRProfilerPresentationMode) {
    MXRProfilerPresentationMode_SimpleInfo = 0,
    MXRProfilerPresentationMode_Standstill
};

@protocol MXRProfilerPresentationModeDelegate <NSObject>

- (void)presentationDelegateChangePresentationModeToMode:(MXRProfilerPresentationMode)mode;

@end
