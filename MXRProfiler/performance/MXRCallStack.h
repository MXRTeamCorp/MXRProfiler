//
//  MXRCallStack.h
//  easywayout
//
//  Created by mxr on 17/1/19.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MXRLOG_Callstack_Current NSLog(@"%@",[BSBacktraceLogger mxr_backtraceOfCurrentThread]);
#define MXRLOG_Callstack_MAIN NSLog(@"%@",[BSBacktraceLogger mxr_backtraceOfMainThread]);
#define MXRLOG_Callstack_ALL NSLog(@"%@",[BSBacktraceLogger mxr_backtraceOfAllThread]);

/**
 获取函数调用栈
 @see https://github.com/bestswifter/BSBacktraceLogger
 */
@interface MXRCallStack : NSObject

+ (NSString *)mxr_backtraceOfAllThread;
+ (NSString *)mxr_backtraceOfCurrentThread;
+ (NSString *)mxr_backtraceOfMainThread;
+ (NSString *)mxr_backtraceOfNSThread:(NSThread *)thread;

@end
