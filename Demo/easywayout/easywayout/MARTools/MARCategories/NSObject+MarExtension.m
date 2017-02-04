//
//  NSObject+MarExtension.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/8.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "NSObject+MarExtension.h"
#import <objc/runtime.h>
@implementation NSObject (MarExtension)

+ (NSArray *)mar_ivarsNameArray
{
    unsigned int ivarCount;
    Ivar *ivarList = class_copyIvarList([self class], &ivarCount);
    NSMutableArray *ivarNameArray = [NSMutableArray arrayWithCapacity:ivarCount];
    for (int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivarList[i];
        const char * ivarmame = ivar_getName(ivar);
        NSString* ivarName = [NSString stringWithCString:ivarmame encoding:NSUTF8StringEncoding];
//        NSLog(@"iavarName : %@", ivarName);
        [ivarNameArray addObject:ivarName];
    }
    free(ivarList);
    Class clazz;
    return ivarNameArray;
}

@end
