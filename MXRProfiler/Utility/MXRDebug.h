//
//  MXRDebug.h
//  easywayout
//
//  Created by Martin.Liu on 2017/2/9.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//
/*
 do{...}while(0)在C中是唯一的构造程序，让你定义的宏总是以相同的方式工作，这样不管怎么使用宏（尤其在没有用大括号包围调用宏的语句），宏后面的分号也是相同的效果。
 概括就是：使用do{...}while(0)构造后的宏定义不会受到大括号、分号等的影响，总是会按你期望的方式调用运行。
 */
#import <Foundation/Foundation.h>
#import "MXRProfilerMacro.h"
typedef NS_OPTIONS(NSUInteger, MXRDebugLogLevel) {
    MXRDebugLogLevelNone            = 0,
    MXRDebugLogLevelInfo            = 1 << 0,
    MXRDebugLogLevelWarn            = 1 << 1,
    MXRDebugLogLevelError           = 1 << 2,
    MXRDebugLogLevelALL             = 0xFFFFFFFF
};

#define MXRDebugLog
#ifdef MXRDebugLog
#define MXRDEBUGLOGLEVEL            [MXRDebug debugLogLevel]
#define MXRDebugCouldLogInfo()      (MXRDEBUGLOGLEVEL & MXRDebugLogLevelInfo)
#define MXRDebugCouldLogWarn()      (MXRDEBUGLOGLEVEL & MXRDebugLogLevelWarn)
#define MXRDebugCouldLogError()     (MXRDEBUGLOGLEVEL & MXRDebugLogLevelError)

#define MXRInfoLog(format, args...)                             \
        do {                                                    \
            if (MXRDebugCouldLogInfo()) {                       \
                NSString *s = MXRDebugMethodMsg(                \
                self, _cmd, __FILE__, __LINE__,                 \
                [NSString stringWithFormat: format, ##args]);   \
                NSLog(@"[info]%@", s);                          \
            }                                                   \
        } while (0)

#define MXRWarnLog(format, args...)                             \
        do {                                                    \
            if (MXRDebugCouldLogWarn()) {                       \
                NSString *s = MXRDebugMethodMsg(                \
                self, _cmd, __FILE__, __LINE__,                 \
                [NSString stringWithFormat: format, ##args]);   \
                NSLog(@"[warn]%@", s);                          \
            }                                                   \
        } while (0)

#define MXRErrorLog(format, args...)                            \
        do {                                                    \
            if (MXRDebugCouldLogError()) {                      \
                NSString *s = MXRDebugMethodMsg(                \
                self, _cmd, __FILE__, __LINE__,                 \
                [NSString stringWithFormat: format, ##args]);   \
                NSLog(@"[error]%@", s);                         \
            }                                                   \
        } while (0)

#define MXRFuncInfoLog(format, args...)                         \
        do {                                                    \
            if (MXRDebugCouldLogInfo()) {                       \
                NSString *s = MXRDebugFunctionMsg(              \
                __PRETTY_FUNCTION__, __FILE__, __LINE__,        \
                [NSString stringWithFormat: format, ##args]);   \
                NSLog(@"[info]%@", s);                          \
            }                                                   \
        } while (0)

#define MXRFuncWarnLog(format, args...)                         \
        do {                                                    \
            if (MXRDebugCouldLogWarn()) {                       \
                NSString *s = MXRDebugFunctionMsg(              \
                __PRETTY_FUNCTION__, __FILE__, __LINE__,        \
                [NSString stringWithFormat: format, ##args]);   \
                NSLog(@"[warn]%@", s);                          \
            }                                                   \
        } while (0)

#define MXRFuncErrorLog(format, args...)                        \
        do {                                                    \
            if (MXRDebugCouldLogError()) {                      \
                NSString *s = MXRDebugFunctionMsg(              \
                __PRETTY_FUNCTION__, __FILE__, __LINE__,        \
                [NSString stringWithFormat: format, ##args]);   \
                NSLog(@"[error]%@", s);                         \
            }                                                   \
        } while (0)

#else

#define MXRInfoLog(format, args...)     do {} while (0)
#define MXRWarnLog(format, args...)     do {} while (0)
#define MXRErrorLog(format, args...)    do {} while (0)

#define MXRFuncInfoLog(format, args...)     do {} while (0)
#define MXRFuncWarnLog(format, args...)     do {} while (0)
#define MXRFuncErrorLog(format, args...)    do {} while (0)

#endif


MXR_EXTERN_C_BEGIN

/**
 * Used to produce a format string for logging a message with function
 * location details.
 */
extern NSString*	MXRDebugFunctionMsg(const char *func, const char *file,
                                        int line, NSString *fmt);
/**
 * Used to produce a format string for logging a message with method
 * location details.
 */
extern NSString*	MXRDebugMethodMsg(id obj, SEL sel, const char *file,
                                      int line, NSString *fmt);


@interface MXRDebug : NSObject

+ (MXRDebugLogLevel)debugLogLevel;

+ (void)setDebugLogLevel:(MXRDebugLogLevel)debugLogLevel;

@end


MXR_EXTERN_C_END
