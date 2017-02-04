//
//  MXRProfilerTool.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerTool.h"
#import "MXRProfilerWindow.h"
#import "MXRProfilerWindowTouchesHandling.h"
#import "MXRProfilerContainerViewController.h"
#import "MXRProfilerSimpleInfoViewController.h"
#import "MXRProfilerStandstillListViewController.h"
#import "MXRMonitorRunloop.h"
#import "MXRProfilerInfo.h"
#import "MXRProfilerStandstillInfo.h"
#import "MXRCallStack.h"
#import "MXRProfilerMacro.h"

static const NSUInteger kMXRSimpleVCHeight = 100.0;
static const NSUInteger kMXRStandstaillVCHeight = 250;

@interface MXRProfilerTool() <MXRProfilerWindowTouchesHandling, MXRProfilerPresentationModeDelegate>

@property (nonatomic, strong) MXRProfilerWindow *profilerWindow;

@end

@implementation MXRProfilerTool
{
    MXRProfilerContainerViewController *_containerViewController;
    
    MXRProfilerSimpleInfoViewController *_simpleInfoViewController;
    MXRProfilerStandstillListViewController *_standstillListViewController;
}

- (MXRProfilerWindow *)profilerWindow
{
    if (!_profilerWindow) {
        _profilerWindow = [[MXRProfilerWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _profilerWindow.hidden = NO;
        _profilerWindow.touchesDelegate = self;
    }
    return _profilerWindow;
}


- (void)startAnalyze
{
    _containerViewController = [[MXRProfilerContainerViewController alloc] init];
    self.profilerWindow.rootViewController = _containerViewController;
    
    [_containerViewController dismissCurrentViewController];
    _simpleInfoViewController = [MXRProfilerSimpleInfoViewController new];
    _simpleInfoViewController.delegate = self;
    [_containerViewController presentViewController:_simpleInfoViewController
                                           withSize:CGSizeMake(kMXRSimpleVCHeight,
                                                               kMXRSimpleVCHeight)];
    [[MXRMonitorRunloop sharedInstance] startMonitor];
    [MXRMonitorRunloop sharedInstance].callbackWhenStandStill = ^{
        MXRProfilerStandstillInfo *standstaillInfo = [MXRProfilerStandstillInfo new];
        standstaillInfo.happendTimeIntervalSince1970 = [[NSDate new] timeIntervalSince1970];
        standstaillInfo.currentVCClassName = MXRPROFILERINFO.currentVCClassName;
        standstaillInfo.mainTreadCallStack = [MXRCallStack mxr_backtraceOfMainThread];
        [MXRPROFILERINFO.standstaillInfos addObject:standstaillInfo];
//        standstaillInfo.allTreadCallStack = [MXRCallStack mxr_backtraceOfAllThread];
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorStandstillHappend) name:MXRPROFILERNOTIFICATION_HAPPENSTANDSTILL object:nil];
}

- (void)monitorStandstillHappend
{
    if (self.presentationMode != MXRProfilerPresentationMode_Standstill) {
        MXRPROFILERINFO.standstaillSign = YES;
    }
}

- (void)endAnalyze
{
    [[MXRMonitorRunloop sharedInstance] endMonitor];
}

- (void)setPresentationMode:(MXRProfilerPresentationMode)presentationMode
{
    _presentationMode = presentationMode;
    switch (presentationMode) {
        case MXRProfilerPresentationMode_SimpleInfo:
        {
            [_containerViewController dismissCurrentViewController];
            _standstillListViewController = nil;
            _simpleInfoViewController = [MXRProfilerSimpleInfoViewController new];
            _simpleInfoViewController.delegate = self;
            [_containerViewController presentViewController:_simpleInfoViewController
                                                   withSize:CGSizeMake(kMXRSimpleVCHeight,
                                                                       kMXRSimpleVCHeight)];
        }
            break;
        case MXRProfilerPresentationMode_Standstill:
        {
            MXRPROFILERINFO.standstaillSign = NO;
            [_containerViewController dismissCurrentViewController];
            _simpleInfoViewController = nil;
            _standstillListViewController = [MXRProfilerStandstillListViewController new];
            _standstillListViewController.delegate = self;
            [_containerViewController presentViewController:_standstillListViewController withSize:CGSizeMake(FLT_MAX, kMXRStandstaillVCHeight)];
        }
            break;
    }
}

#pragma mark - MXRProfilerPresentationModeDelegate
- (void)presentationDelegateChangePresentationModeToMode:(MXRProfilerPresentationMode)mode
{
    self.presentationMode = mode;
}

#pragma mark - MXRProfilerWindowTouchesHandling
- (BOOL)mxr_window:(UIWindow *)window shouldReceiveTouchAtPoint:(CGPoint)point
{
    switch (self.presentationMode) {
        case MXRProfilerPresentationMode_SimpleInfo:
            return CGRectContainsPoint(_simpleInfoViewController.view.bounds,
                                [_simpleInfoViewController.view convertPoint:point
                                                                    fromView:window]);

            break;
        case MXRProfilerPresentationMode_Standstill:
            return CGRectContainsPoint(_standstillListViewController.view.bounds,
                                [_standstillListViewController.view convertPoint:point
                                                                    fromView:window]);
    }
    return YES;
}

@end
