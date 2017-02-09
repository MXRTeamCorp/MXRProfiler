//
//  MXRDebug.m
//  easywayout
//
//  Created by Martin.Liu on 2017/2/9.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRDebug.h"
#import <objc/runtime.h>

NSString*
MXRDebugFunctionMsg(const char *func, const char *file, int line, NSString *fmt)
{
    NSString *message;
    message = [NSString stringWithFormat: @"File %s: %d. In %s %@",
               file, line, func, fmt];
    return message;
}

NSString*
MXRDebugMethodMsg(id obj, SEL sel, const char *file, int line, NSString *fmt)
{
    NSString	*message;
    Class	cls = [obj class];
    char		c = '-';
    
    if (class_isMetaClass(cls))
    {
        cls = (Class)obj;
        c = '+';
    }
    message = [NSString stringWithFormat: @"File %s: %d. In [%@ %c%@] %@",
               file, line, NSStringFromClass(cls), c, NSStringFromSelector(sel), fmt];
    return message;
}

@implementation MXRDebug
static MXRDebugLogLevel _debugLogLevel;

+ (void)load
{
    _debugLogLevel = MXRDebugLogLevelALL;
}

+ (MXRDebugLogLevel)debugLogLevel
{
    return _debugLogLevel;
}

+ (void)setDebugLogLevel:(MXRDebugLogLevel)debugLogLevel
{
    _debugLogLevel = debugLogLevel;
}

@end

