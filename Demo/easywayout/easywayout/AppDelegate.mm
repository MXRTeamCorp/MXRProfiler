//
//  AppDelegate.m
//  easywayout
//
//  Created by Martin.Liu and Gxd on 2017/1/1.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "AppDelegate.h"
//#import <YYKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <FBMemoryProfiler/FBMemoryProfiler.h>
#import "CacheCleanerPlugin.h"
#import "RetainCycleLoggerPlugin.h"
#import "MXRProfiler.h"
#import "MXRNetFlowTest.h"
@interface AppDelegate ()
{
    FBMemoryProfiler *_memoryProfiler;
    MXRProfilerTool *_profilerTool;
}
@end
BMKMapManager *_mapManager;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _profilerTool = [[MXRProfilerTool alloc] init];
    [_profilerTool setProfilerModes:MXRProfilerModeNetflowSpeed];
    [_profilerTool startAnalyze];
    
    /***/
    // Override point for customization after application launch.
    [self initAppearance];  
    
    _mapManager = [[BMKMapManager alloc] init];
    [_mapManager start:@"Qx4tcbgXcxBQoZtjuy7H51TjVjzpCgix" generalDelegate:self];
   
    
//    _memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:@[[CacheCleanerPlugin new],
//                                                                  [RetainCycleLoggerPlugin new]]
//                               retainCycleDetectorConfiguration:nil];
//    [_memoryProfiler enable];
    
    [MXRNetFlowTest testDataWithURL];
    [MXRNetFlowTest testDataWithRequest];
    [MXRNetFlowTest testDowloadWithRequest];
    [MXRNetFlowTest testDowloadWithURL];
    [MXRNetFlowTest testUploadFromData];
    [MXRNetFlowTest testUploadFromFile];

    return YES;
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
