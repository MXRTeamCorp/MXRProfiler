//
//  MXRProfilerBaseDBModel.m
//  easywayout
//
//  Created by Martin.Liu on 2017/2/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerBaseDBModel.h"

#define MXRBaseDBName @"Profiler.db"

@implementation MXRProfilerBaseDBModel

+ (LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:MXRBaseDBName];
        db = [[LKDBHelper alloc] initWithDBPath:dbPath];
    });
    return db;
}

@end
