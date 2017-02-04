//
//  UIViewController+MXRProfier.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/22.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "UIViewController+MXRProfier.h"
#import "MXRProfilerBaseViewController.h"
#import "MXRProfilerInfo.h"
#import "NSObject+MXRSwizz.h"
#import <objc/runtime.h>

@implementation UIViewController (MXRProfier)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self mxr_swizzleSEL:@selector(viewWillAppear:) withSEL:@selector(mxr_swizzled_viewWillAppear:)];
        [self mxr_swizzleSEL:@selector(viewDidAppear:) withSEL:@selector(mxr_swizzled_viewDidAppear:)];
    });
}

- (void)mxr_swizzled_viewWillAppear:(BOOL)animated
{
    [self mxr_swizzled_viewWillAppear:animated];
    BOOL isMXRProfilerVC = [self isKindOfClass:[MXRProfilerBaseViewController class]];
    BOOL isNavi = [self isKindOfClass:[UINavigationController class]];
    BOOL isTabbar = [self isKindOfClass:[UITabBarController class]];
    BOOL shouldUpdateVCName = !(isMXRProfilerVC || isNavi || isTabbar);
    if (shouldUpdateVCName) {
        MXRPROFILERINFO.currentVCClassName = NSStringFromClass(self.class);
    }
}

- (void)mxr_swizzled_viewDidAppear:(BOOL)animated
{
    [self mxr_swizzled_viewDidAppear:animated];
}

@end
