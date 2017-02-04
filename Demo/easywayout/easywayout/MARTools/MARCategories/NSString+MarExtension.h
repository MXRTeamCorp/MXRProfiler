//
//  NSString+MarExtension.h
//  
//
//  Created by Martin.Liu on 15/12/24.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MarExtension)

- (BOOL) mar_isNull;
/**
 判断是否是一个url
 */
- (BOOL) mar_isUrl;
/**
 判断是否是一个手机号码
 */
- (BOOL) mar_isPhone;
/** Returns `YES` if a string is a valid email address, otherwise `NO`.
 @return True if the string is formatted properly as an email address.
 */
@property (nonatomic, getter=mar_isEmail, readonly) BOOL mar_isEmail;

/**
 当自身和比较字符串不为空时候 , 并且自身包含比较字符串返回YES ， 否则返回NO,
 */
- (BOOL) mar_contains : (NSString*) otherString;

/**
 对字符串进行MD5加密
 */
- (NSString *)mar_MD5Hash;
/**
 返回去掉头尾空格的字符串
 */
- (NSString*) mar_trim;
@end

@interface NSString (SHA)
-(NSString *) mar_sha1;
-(NSString *) mar_sha224;
-(NSString *) mar_sha256;
-(NSString *) mar_sha384;
-(NSString *) mar_sha512;
@end
