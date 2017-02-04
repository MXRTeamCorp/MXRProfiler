//
//  AppDelegate.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/1.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "MARAppDelegate.h"
@interface AppDelegate : MARAppDelegate <UIApplicationDelegate, BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

