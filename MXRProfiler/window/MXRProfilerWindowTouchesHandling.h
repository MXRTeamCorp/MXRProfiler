//
//  MXRProfilerWindowTouchesHandling.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MXRProfilerWindowTouchesHandling <NSObject>

- (BOOL)mxr_window:(nullable UIWindow *)window shouldReceiveTouchAtPoint:(CGPoint)point;

@end
