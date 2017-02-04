//
//  MARBaseDBModel.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/5.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARBaseDBModel.h"

@implementation MARBaseDBModel

+ (LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"MAIERSI/data.db"];
//        NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"MAIERSI/data.db"];
        db = [[LKDBHelper alloc] initWithDBPath:dbPath];
    });
    return db;
}

+ (NSArray<MARBaseDBModel *> *)mar_getAllDBModelArray
{
    NSArray<MARBaseDBModel *> *allDBModelArray = [self searchWithWhere:nil];
    return allDBModelArray;
}

+ (MARBaseDBModel *)mar_getFirstDBModel
{
    NSArray<MARBaseDBModel *> *allDBModelArray = [self mar_getAllDBModelArray];
    if (allDBModelArray.count > 0) {
        return allDBModelArray[0];
    }
    return nil;
}

@end
