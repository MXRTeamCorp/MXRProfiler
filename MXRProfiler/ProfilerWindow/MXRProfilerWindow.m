//
//  MXRProfilerWindow.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerWindow.h"

@implementation MXRProfilerWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 100;
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([_touchesDelegate mxr_window:self shouldReceiveTouchAtPoint:point]) {
        return [super pointInside:point withEvent:event];
    }
    
    return NO;
}

- (BOOL)_canAffectStatusBarAppearance
{
    return NO;
}

- (BOOL)_canBecomeKeyWindow
{
    return NO;
}


@end
