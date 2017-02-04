//
//  MXRProfilerTool.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRProfilerPresentationModeDelegate.h"

@interface MXRProfilerTool : NSObject

@property (nonatomic, assign) MXRProfilerPresentationMode presentationMode;

- (void)startAnalyze;

- (void)endAnalyze;

@end
