//
//  MARGlobalManager.h
//  
//
//  Created by Martin.Liu on 15/12/21.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>
#define MARGLOBALMANAGER [MARGlobalManager sharedInstance]

#define StrFromInt(IntValue)     [NSString stringWithFormat: @"%ld", (long)IntValue]
#define StrFromFloat(FloatValue)     [NSString stringWithFormat: @"%f", FloatValue]
#define StrFromDouble(DoubleValue)     [NSString stringWithFormat: @"%f", DoubleValue]
#define StrFromObj(objValue)     [NSString stringWithFormat: @"%@", objValue]
#define StrIsEmpty(strObj)      [MARGLOBALMANAGER isStringEmpty:strObj]
#define StrDFString(targetStr, defaultStr) [MARGLOBALMANAGER targetString:targetStr defaultString:defaultStr]

#define StrForUserKey(key)  [MARGLOBALMANAGER userDefaultStringForKey:key]
#define StrSetUser(str,key) [MARGLOBALMANAGER userDefaultSetObject:str forKey:key]

#define ShowSuccessMessage(message, durationValue) [SVProgressHUD mar_showSuccessWithStatus:message duration:durationValue]
#define ShowErrorMessage(message, durationValue) [SVProgressHUD mar_showErrorWithStatus:message duration:durationValue]
#define ShowInfoMessage(message, durationValue) [SVProgressHUD mar_showInfoWithStatus:message  duration:durationValue]
#define Duration_Normal 1

#define DEVICE_ID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

@interface MARGlobalManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  判断字符串是空
 *
 *  @param obj obj description
 *
 *  @return return value description
 */
- (BOOL)isStringEmpty:(id)obj;

/**
 *  如果目标字符串不为空，返回目标字符串，反则返回默认字符串
 *
 *  @param targetString    目标字符串
 *  @param defaultString    默认字符串
 *  @return 返回BOOL
 */
- (NSString*)targetString:(NSString*)targetString defaultString:(NSString*)defaultString;


/**
 *  判断是不是电话号码
 *
 *  @param obj 判断对象
 *
 *  @return 返回BOOL
 */
- (BOOL)isPhoneNumber:(NSString*)text;

/**
 *  判断是不是邮箱地址
 *
 *  @param text 判断对象
 *
 *  @return 返回BOOL
 */
- (BOOL)isEmail:(NSString*)text;

/*
 简单封装 NSUserDefaults
 **/
- (void) userDefaultSetObject:(id)obj forKey:(NSString*)key;
- (id) userDefaultObjectForKey:(NSString*)key;
- (NSString*) userDefaultStringForKey:(NSString*)key;

/**
 *  发出全局通知
 *
 *  @param type 通知类型
 *  @param data 数据
 *  @param object  通知来源对象，填self
 *  @return @{type:,data:,object:}
 */
- (NSDictionary*)postNotif:(NSInteger)type data:(id)data object:(id)object;

/*
 *  get the path of mobile directory
 *  返回手机文件夹的路径
 */
- (NSString*)documentsPath;

/**打开系统应用
 打电话：tel:或者tel://、telprompt:或telprompt://(拨打电话前有提示)
 发短信：sms:或者sms://
 发送邮件：mailto:或者mailto://
 启动浏览器：http:或者http://
 如果无法打开返回NO
 */
-(BOOL)openUrl:(NSString *)urlStr;

- (NSString *)convertMilliSecondsToDate:(NSString *)milliSeconds withFormatString:(NSString*) format;

- (NSString *)convertMilliSecondsToDate:(NSString *)milliSeconds;

- (NSString *)stringWithDate:(NSDate*)date withDateFormat:(NSString*)dateFormat;

/** 返回虚线UIImage */
- (UIImage*)dashImageWithSize:(CGSize)size color:(UIColor*)color;

/** 是否注册远程通知，允许发送推送消息 */
//- (BOOL) isRegisteredForRemoteNotifications;

/**  正则表达式
 @param  regex              正则表达式的公式
 @param  destinationStr     目的字符串
 */
- (BOOL) conformRegex:(NSString*)regex destinationString:(NSString*)destinationStr;

/**
 *  是否是APP第一次打开应用
 *
 *  @return 第一次打开app返回YES，否则NO
 */
- (BOOL)isAPPFirstOpen;

@end
