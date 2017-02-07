//
//  MXRProfilerTool.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerTool.h"
#import "MXRMonitorRunloop.h"
#import "MXRProfilerInfo.h"
#import "MXRProfilerStandstillInfo.h"
#import "MXRCallStack.h"
#import "MXRProfilerMacro.h"
#import "MXRProfilerWindow.h"
#import "MXRProfilerWindowTouchesHandling.h"
#import "MXRProfilerContainerViewController.h"
#import "MXRProfilerSimpleInfoViewController.h"
#import "MXRProfilerStandstillListViewController.h"

static const NSUInteger kMXRSimpleVCHeight = 100.0;
static const NSUInteger kMXRStandstaillVCHeight = 250;

@interface MXRProfilerTool() <MXRProfilerWindowTouchesHandling, MXRProfilerPresentationModeDelegate>

@property (nonatomic, strong) MXRProfilerWindow *profilerWindow;
@property (nonatomic, assign) MXRProfilerPresentationMode presentationMode;
@end

@implementation MXRProfilerTool
{
    MXRProfilerContainerViewController *_containerViewController;
    UIViewController *_currentLocationViewController;   // 保存present时的VC，用来计算用户行为是否有效。
    
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

- (void)setProfilerModes:(MXRProfilerModes)profilerModes
{
    MXRPROFILERINFO.profilerModes = profilerModes;
}

- (void)startAnalyze
{
    if (MXRPROFILERINFO.profilerModes == MXRProfilerModeNone) {
        return;
    }
    _isAnalyzing = YES;
    _containerViewController = [[MXRProfilerContainerViewController alloc] init];
    self.profilerWindow.rootViewController = _containerViewController;
    
    [_containerViewController dismissCurrentViewController];
    _simpleInfoViewController = [MXRProfilerSimpleInfoViewController new];
    _simpleInfoViewController.delegate = self;
    _currentLocationViewController = _simpleInfoViewController;
    [_containerViewController presentViewController:_simpleInfoViewController
                                           withSize:CGSizeMake(kMXRSimpleVCHeight,
                                                               kMXRSimpleVCHeight)];
    if (MXRPROFILERINFO.profilerModes & MXRProfilerModeStandstill) {
        [[MXRMonitorRunloop sharedInstance] startMonitor];
        [MXRMonitorRunloop sharedInstance].callbackWhenStandStill = ^{
            MXRProfilerStandstillInfo *standstaillInfo = [MXRProfilerStandstillInfo new];
            standstaillInfo.happendTimeIntervalSince1970 = [[NSDate new] timeIntervalSince1970];
            standstaillInfo.currentVCClassName = MXRPROFILERINFO.currentVCClassName;
            standstaillInfo.mainTreadCallStack = [MXRCallStack mxr_backtraceOfMainThread];
            [MXRPROFILERINFO.standstaillInfos addObject:standstaillInfo];
        };
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorStandstillHappend) name:MXRPROFILERNOTIFICATION_HAPPENSTANDSTILL object:nil];
}

- (void)endAnalyze
{
    _isAnalyzing = NO;
    [[MXRMonitorRunloop sharedInstance] endMonitor];
    _profilerWindow = nil;
}

- (void)setPresentationMode:(MXRProfilerPresentationMode)presentationMode
{
    _presentationMode = presentationMode;
    switch (presentationMode) {
        case MXRProfilerPresentationMode_SimpleInfo:
        {
            [_containerViewController dismissCurrentViewController];
            _standstillListViewController = nil;
            _currentLocationViewController = nil;
            _simpleInfoViewController = [MXRProfilerSimpleInfoViewController new];
            _simpleInfoViewController.delegate = self;
            _currentLocationViewController = _simpleInfoViewController;
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
            _currentLocationViewController = nil;
            _standstillListViewController = [MXRProfilerStandstillListViewController new];
            _standstillListViewController.delegate = self;
            _currentLocationViewController = _standstillListViewController;
            [_containerViewController presentViewController:_standstillListViewController withSize:CGSizeMake(FLT_MAX, kMXRStandstaillVCHeight)];
        }
            break;
    }
}

#pragma mark - Notification
- (void)monitorStandstillHappend
{
    if (self.presentationMode != MXRProfilerPresentationMode_Standstill) {
        MXRPROFILERINFO.standstaillSign = YES;
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
    if (_currentLocationViewController) {
        return CGRectContainsPoint(_currentLocationViewController.view.bounds,
                                   [_currentLocationViewController.view convertPoint:point
                                                                       fromView:window]);
    }
//    switch (self.presentationMode) {
//        case MXRProfilerPresentationMode_SimpleInfo:
//            return CGRectContainsPoint(_simpleInfoViewController.view.bounds,
//                                [_simpleInfoViewController.view convertPoint:point
//                                                                    fromView:window]);
//
//            break;
//        case MXRProfilerPresentationMode_Standstill:
//            return CGRectContainsPoint(_standstillListViewController.view.bounds,
//                                [_standstillListViewController.view convertPoint:point
//                                                                    fromView:window]);
//    }
    return NO;
}

@end
