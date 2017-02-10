//
//  MXRProfilerStandstillInfo.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRProfilerStandstillInfo : NSObject

@property (nonatomic, assign) NSTimeInterval happendTimeIntervalSince1970;
@property (nonatomic, strong) NSString *currentVCClassName;
@property (nonatomic, strong) NSString *mainTreadCallStack;
@property (nonatomic, assign) int limitMillisecond;         // 影响一次有效卡顿的一个因素
@property (nonatomic, assign) int standstillCount;          // 影响一次有效卡顿的一个因素

@property (nonatomic, strong) NSString *appVersion;         // 保存本地或者上传的时候用到  数据库中是可能变化的
@property (nonatomic, strong) NSString *systemVersion;      // 保存本地或者上传的时候用到  数据库中是可能变化的
//@property (nonatomic, strong) NSString *machineModelName;      // 保存本地或者上传的时候用到  数据库中是不变的
@end
