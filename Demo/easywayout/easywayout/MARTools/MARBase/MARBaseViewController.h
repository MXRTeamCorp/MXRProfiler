//
//  MARBaseViewController.h
//  
//
//  Created by Martin.Liu on 15/12/21.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MARBaseViewController : UIViewController

/**
 *  YES will call [self.navigationController setNavigationBarHidden:NO animated:YES] when view will appeal,
 *  NO do nothing
 *  see showNaviBarViewWillAppeal fllowing category
 */
//@property (nonatomic, assign, setter=setShowNaviBarViewWillAppeal:) BOOL isShowNaviBarViewWillAppeal;

/**
 *  the value indicate wheather resign first responder when tap view
 */
@property (nonatomic, assign, setter=setTapResignTFS:) BOOL isTapResignTFS;

/**
 *  app的UI全局设置，包括背景色，top bar背景等
 */
- (void)UIGlobal;

/**
 *  获取全局通知
 *
 *  @param type 通知类型
 *  @param data 数据
 *  @param obj  通知来源
 */
- (void)getNotifType:(NSInteger)type data:(id)data target:(id)obj;

@end

@interface UIViewController (MARBaseVCEX)
/**
 *  YES will call [self.navigationController setNavigationBarHidden:NO animated:YES] when view will appeal,
 *  NO do nothing
 */
@property (nonatomic, assign) BOOL showNaviBarViewWillAppeal;

@end
