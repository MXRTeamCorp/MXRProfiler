//
//  MARUserDefault.h
//  
//
//  Created by Martin.Liu on 15/12/21.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MARUserDefault : NSObject

+ (void)setString:(NSString*)str key:(NSString*)keyWord;
+ (NSString *)getStringBy:(NSString*)keyWord;

+ (void)setBool:(BOOL)value key:(NSString*)keyWord;
+ (BOOL)getBoolBy:(NSString*)keyWord;

+ (void)setDict:(NSDictionary*)dict key:(NSString*)keyWord;
+ (NSDictionary *)getDictBy:(NSString*)keyWord;

+ (void)setObject:(id)obj key:(NSString*)keyWord;
+ (id)getObjectBy:(NSString*)keyWord;

+ (void)setModel:(id)mod key:(NSString*)keyWord;
+ (id)getModelBy:(NSString*)keyWord;

+ (void)setDouble:(double)value key:(NSString*)keyWord;
+ (double)getDoubleBy:(NSString*)keyWord;

+ (void)setNumber:(NSNumber*)num key:(NSString*)keyWord;
+ (NSNumber *)getNumberBy:(NSString*)keyWord;

@end
