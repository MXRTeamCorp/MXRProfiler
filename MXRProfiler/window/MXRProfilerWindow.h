//
//  MXRProfilerWindow.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXRProfilerWindowTouchesHandling.h"

/**
 Window that MXRProfiler will reside in.
 */
@interface MXRProfilerWindow : UIWindow

/**
 Whenever we receive a touch event, window needs to ask delegate if this event should be captured.
 */
@property (nonatomic, weak, nullable) id<MXRProfilerWindowTouchesHandling> touchesDelegate;
@end
