//
//  MARAppDelegate.m
//  
//
//  Created by Martin.Liu on 15/12/21.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import "MarAppDelegate.h"
#import <RealReachability.h>
//#import "NotificationMacro.h"
//#import "AppMacro.h"
//#import "css.h"

@implementation MARAppDelegate

-(void)startMonitorNetwork
{
    //开启网络状况的监听  RealReachability 替代
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(reachabilityChanged:)
//                                                 name: kReachabilityChangedNotification
//                                               object: nil];
//    Reachability * reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    [reach startNotifier];
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
}

- (void) stopMonitorNetwork
{
    [GLobalRealReachability stopNotifier];
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    NSLog(@"currentStatus:%@",@(status));
    
//    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        switch (status)
        {
            case RealStatusNotReachable:
            {
                //  case NotReachable handler
                break;
            }
                
            case RealStatusViaWiFi:
            {
                //  case ReachableViaWiFi handler
                break;
            }
                
            case RealStatusViaWWAN:
            {
                //  case ReachableViaWWAN handler
                break;
            }
                
            default:
                break;
        }
//    }];
//    // 获取当前的数据网络连接类型
//    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
//    switch (accessType) {
//        case WWANType2G:
//            
//            break;
//        case WWANType3G:
//            
//            break;
//        case WWANType4G:
//            
//            break;
//        default:
//            break;
//    }
}
// RealReachability 替代
//- (void) reachabilityChanged: (NSNotification* )noti
//{
//    Reachability* curReach = [noti object];
//    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//    GLOBALMANAGER.currentNetWork = curReach.currentReachabilityStatus;
//    // 发送网络改变通知
//    [GLOBALMANAGER postNotif:kMARNotification_ReachabilityChanged data:nil object:nil];
//}
#pragma mark - 注册推送通知
#pragma mark 申请DeviceToken
- (void)registerDeviceToken
{
//#ifdef __IPHONE_8_0
//    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
////        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
////        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
//    }  else {
//        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
//    }
//#else
//    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
//#endif
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)_deviceToken
{
    NSString *devStr = [NSString stringWithFormat:@"%@",_deviceToken];
    NSArray *array = [devStr componentsSeparatedByString:@" "];
    NSString* deviceToken = [array componentsJoinedByString:@""];
    deviceToken = [deviceToken substringWithRange:NSMakeRange(1, deviceToken.length - 2)];
    MARLog(@"device token : %@", deviceToken);
}

- (void)initAppearance
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(APPNaviBarTint, 1)];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(APPNaviTint, 1)];
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:kSCALE(15.f)], NSFontAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,UIColorFromRGB(APPNaviBarTint, 1).CGColor);
    CGContextFillRect(context, rect);
    UIImage * imge = [[UIImage alloc] init];
    imge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[UINavigationBar appearance] setBackgroundImage:imge forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

@end
