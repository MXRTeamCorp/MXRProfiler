//
//  MARAppDelegate.h
//  
//
//  Created by Martin.Liu on 15/12/21.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MARGlobalManager.h"

#define MARAPPDELEGATE_RegisterDeviceToken          // 申请devicetoken

@interface MARAppDelegate : UIResponder<UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

- (void) startMonitorNetwork;
- (void) stopMonitorNetwork;
#pragma mark - 注册推送通知
- (void) registerDeviceToken;

#pragma mark - 全局设置导航栏样式
- (void) initAppearance;

@end
