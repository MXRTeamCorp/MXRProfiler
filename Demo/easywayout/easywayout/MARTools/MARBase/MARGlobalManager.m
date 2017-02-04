//
//  MARGlobalManager.m
//  
//
//  Created by Martin.Liu on 15/12/21.
//  Copyright © 2015年 MAR. All rights reserved.
//

NSString * const kMarAppFirstOpenKey = @"kMarAppFirstOpenKey";

#import "MARGlobalManager.h"
#import "NSString+MarExtension.h"
@interface MARGlobalManager()
@property (nonatomic, strong) NSDateFormatter* dateFormater;
@end

@implementation MARGlobalManager

+ (instancetype)sharedInstance
{
    SINGLE_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (NSDateFormatter *)dateFormater
{
    if (!_dateFormater) {
        _dateFormater = [[NSDateFormatter alloc] init];
        [_dateFormater setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormater;
}

- (BOOL)isStringEmpty:(id)obj
{
    if (obj==nil || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj length]==0) {
            return YES;
        }
    }
    return NO;
}

- (NSString*)targetString:(NSString*)targetString defaultString:(NSString*)defaultString
{
    if (!StrIsEmpty(targetString)) {
        return targetString;
    }
    if (!StrIsEmpty(defaultString)) {
        return defaultString;
    }
    return @"";
}

- (BOOL)isPhoneNumber:(NSString*)text
{
    NSString *urlRegEx = @"[1][34578]\\d{9}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [regExPredicate evaluateWithObject:text];
    
    //    /**
    //     * 手机号码
    //     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     * 联通：130,131,132,152,155,156,185,186
    //     * 电信：133,1349,153,180,189
    //     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189
    //     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    //    //     NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})-?\\d{7,8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    //
    //    if (([regextestmobile evaluateWithObject:text] == YES)
    //        || ([regextestcm evaluateWithObject:text] == YES)
    //        || ([regextestct evaluateWithObject:text] == YES)
    //        || ([regextestcu evaluateWithObject:text] == YES)
    //        || ([regextestphs evaluateWithObject:text] == YES))
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
}

- (BOOL)isEmail:(NSString *)text
{
    NSString* emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate* regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[text lowercaseString]];
}

- (void) userDefaultSetObject:(id)obj forKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:key];
    [userDefaults synchronize];
}

- (id) userDefaultObjectForKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

- (NSString*) userDefaultStringForKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:key];
}

- (NSDictionary *)postNotif:(NSInteger)type data:(id)data object:(id)object
{
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    if (data) {
        [info setObject:data forKey:@"data"];
    }
    if (object) {
        [info setObject:object forKey:@"object"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMARGlobalNotification object:object userInfo:info];
    return info;
}

-(NSString*) documentsPath
{
    NSArray* docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docPath = docDir[0];
    return docPath;
    
    //    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

-(BOOL)openUrl:(NSString *)urlStr{
    //注意url中包含协议名称，iOS根据协议确定调用哪个应用，例如发送邮件是“sms://”其中“//”可以省略写成“sms:”(其他协议也是如此)
    // 打开itunes中搜索app，可以在百度中所搜“<app名称> itunes”,查看url，进行替换 @"itms-apps://itunes.apple.com/us/app/qq/id444934666"
    // https://itunes.apple.com/cn/lookup?id=444934666  可以获取应用的具体详情
    // https://itunes.apple.com/cn/lookup?id=916413571
    NSURL *url=[NSURL URLWithString:urlStr];
    UIApplication *application=[UIApplication sharedApplication];
    if(![application canOpenURL:url]){
        MARLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
        return NO;
    }
    [application openURL:url];
    return YES;
}

- (NSString *)convertMilliSecondsToDate:(NSString *)milliSeconds withFormatString:(NSString*) format
{
    if (StrIsEmpty(milliSeconds.mar_trim) || [milliSeconds.mar_trim isEqualToString:@"0"]) {
        return @"";
    }
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:([milliSeconds doubleValue]/1000)];
    [self.dateFormater setDateFormat:format];
    NSString* dateString = [self.dateFormater stringFromDate:date];
    if (dateString == nil) {
        MARLog(@"date format is invalid :%@", format);
        return milliSeconds;
    }
    return dateString;
}

- (NSString *)convertMilliSecondsToDate:(NSString *)milliSeconds
{
    return [self convertMilliSecondsToDate:milliSeconds withFormatString:@"yyyy-MM-dd"];
}

- (NSString *)stringWithDate:(NSDate*)date withDateFormat:(NSString*)dateFormat
{
    [self.dateFormater setDateFormat:dateFormat];
    return [self.dateFormater stringFromDate:date];
}

- (UIImage*)dashImageWithSize:(CGSize)size color:(UIColor*)color
{
    if (!color) {
        color = UIColorFromRGB(0xb2c6ee, 1);
    }
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 2);
    CGFloat patterns[] = {3,1};
    CGContextSetLineDash(context, 0, patterns, 2);
    CGPoint points[] = {CGPointMake(0, 0),CGPointMake(size.width, 0)};
    CGContextStrokeLineSegments(context, points,2);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//- (BOOL) isRegisteredForRemoteNotifications
//{
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
//    if ((IS_IOS8() && [APP currentUserNotificationSettings].types == 0) ||(IS_IOS7() && ![APP isRegisteredForRemoteNotifications])) {
//        return NO;
//    }
//#else
//    if (IS_IOS7() && ![APP isRegisteredForRemoteNotifications]) {
//        return NO;
//    }
//#endif
//    return YES;
//}

- (BOOL) conformRegex:(NSString*)regex destinationString:(NSString*)destinationStr
{
    destinationStr = [destinationStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSPredicate* predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , regex];
    return [predicte evaluateWithObject:destinationStr];
}

- (BOOL)isAPPFirstOpen
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    BOOL isAPPFirstOpenFlag = [user boolForKey:kMarAppFirstOpenKey];
    if (!isAPPFirstOpenFlag) {
        [user setBool:YES forKey:kMarAppFirstOpenKey];
        [user synchronize];
    }
    return isAPPFirstOpenFlag;
}

@end
