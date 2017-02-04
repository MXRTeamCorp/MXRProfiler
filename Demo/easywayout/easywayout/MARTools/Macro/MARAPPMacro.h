//
//  MARAPPMacro.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/5.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#ifndef MARAPPMacro_h
#define MARAPPMacro_h

#import "MARCssStyle.h"
#import "MARNotification.h"
#import "MAREnum.h"
#import "MARCategories.h"
#import "MARConstant.h"

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

#define MAR_PRODUCT
//  自定义log
#define MAR_DEBUG
#ifdef MAR_DEBUG
#define MARLog(s, ...) NSLog( @"%s [Line %d] %@", __PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define MARAssert(a,s, ...) NSAssert(!(a), @"%s [Line %d] %@", __PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__] );
// __PRETTY_FUNCTION__  = -[NSStringFromClass([self class]) NSStringFromSelector(_cmd)]
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])
#else
#define MARLog(s, ...) ((void)0)
#define MARAssert(a,s, ...) ((void)0)
#define TICK    ((void)0)
#define TOCK    ((void)0)
#endif

#define BaseServer @""

#define NullString(param) ^NSString * (){if (!param || [param isKindOfClass:[NSNull class]]) { return @""; } else { return [NSString stringWithFormat:@"%@",param]; }}()

#define ParamString(param) NullString(param)

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#import "AppDelegate.h"
#define UseNaviBackWithCategory
// #import "TDBaseViewController.h"
// #import "TDBaseNaviViewController.h"
// #import "MATipMessage.h"
#define APPLICATION [UIApplication sharedApplication]
#ifndef APPDELEGATE
#define APPDELEGATE ((AppDelegate*)APPLICATION.delegate)
#endif
//  布局相关
//#import "UIView+MAExtension.h"
//#import "MABaseViewController.h"
//#import "UITableView+FDTemplateLayoutCell.h"
#define kScreenOnePixelSize     1.0f/[[UIScreen mainScreen] scale]
#define kScreenWIDTH            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHEIGHT           ([UIScreen mainScreen].bounds.size.height)
#define NeedScaleValue()        (kScreenWIDTH != 320)
#define kSCALE(value)           (value * (kScreenWIDTH/320.0f))
#define kFontSCALE(value)       [UIFont systemFontOfSize:kSCALE(value)]

//  颜色相关
#ifndef UIColorFromRGB
#define UIColorFromRGB(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#endif

#ifndef RGBHEX
#define RGBAHEX(rgbValue,alphaValue) UIColorFromRGB(rgbValue,alphaValue)
#define RGBHEX(rgbValue) RGBAHEX(rgbValue,1)
#endif

#define kMainColor                          UIColorFromRGB(0xff0062, 1)
#define kDefaultColor                       UIColorFromRGB(0xff0062, 1)
#define kDefaultColor_HrLine                UIColorFromRGB(0xd2d2d2,1)
#define kDefaultColor_Cell_HrLine           UIColorFromRGB(0xd2d2d2, 1)
#define kDefaultColor_BackGroundOfView      UIColorFromRGB(0xf5f5f5, 1)
#define kDefaultColor_BarBackgroundColor    kDefaultColor
#define kDefaultColor_BarTintColor          [UIColor whiteColor]
#define kDefaultColor_BarTitleColor         [UIColor whiteColor]

#define kDefaultBtnEnabledBackColor         UIColorFromRGB(0xc30d23, 1)
#define kDefaultBtnDisabledBackColor        UIColorFromRGB(0xd2d2d2, 1)

FOUNDATION_STATIC_INLINE NSString* NSStringFromNSInteger(NSInteger integer);
FOUNDATION_STATIC_INLINE NSString* NSStringFromNSInteger(NSInteger integer){
    return [NSString stringWithFormat:@"%ld", (long)integer];
}

FOUNDATION_STATIC_INLINE CGRect CGRectComposes(CGPoint origin, CGSize size);
FOUNDATION_STATIC_INLINE CGRect CGRectComposes(CGPoint origin, CGSize size){
    CGRect r; r.origin = origin; r.size = size; return r;
}


//  Block
//typedef void(^MAViewControllerBlock)(UIViewController* controller);
typedef void(^MAObjectBlock)(id object);
typedef void(^MABlock)();
/*
 版本号相关
 */
#define AppShortVersion     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppBundleVersion    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APPDisplayName      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define CURRENT_VERSION [[[UIDevice currentDevice] systemVersion] integerValue]
#define IOS7 7
#define IOS8 8
#define IOS9 9
#define IS_IOS7() ((CURRENT_VERSION>=IOS7) ? YES : NO)
#define IS_IOS8() ((CURRENT_VERSION>=IOS8) ? YES : NO)
#define IS_IOS9() ((CURRENT_VERSION>=IOS9) ? YES : NO)
#define ISORLATER_IOS(_value_) ((CURRENT_VERSION>=_value_) ? YES : NO)

#define APP [UIApplication sharedApplication]
#define topHeight ((APP.statusBarHidden || !(IS_IOS7())) ? 0 : 20)
#define NavigationBarHeight (self.navigationController.navigationBar.frame.size.height)

#define kiPhone4s   (MAX(kScreenWIDTH, kScreenHEIGHT) == 480  && MIN(kScreenWIDTH, kScreenHEIGHT) == 320)
#define kiPhone5    (MAX(kScreenWIDTH, kScreenHEIGHT) == 568 && MIN(kScreenWIDTH, kScreenHEIGHT) == 320)
//判断iphone6
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6+
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//判断ipad
#define kiPad ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)


/**
 *  单例宏方法
 *
 *  @param block
 *
 *  @return 返回单例
 */
#define SINGLE_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

/*
 #define MA_RMB @"¥"
 //  -fno-objc-arc    -fobjc-arc
 */

#endif /* MARAPPMacro_h */
