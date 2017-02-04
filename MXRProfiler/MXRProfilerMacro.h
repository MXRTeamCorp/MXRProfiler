//
//  MXRProfilerMacro.h
//  easywayout
//
//  Created by mxr on 17/1/17.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//
#import "MXRProfilerInfo.h"
#import "MXRProfilerStandstillInfo.h"
#import "MXRProfilerNotification.h"

#ifndef MXRProfilerMacro_h
#define MXRProfilerMacro_h

#import <pthread.h>

#ifndef RGBHEX
#define RGBHEX(_hex)    [UIColor \
                            colorWithRed:((float)((_hex & 0xFF0000) >> 16))/255.0 \
                            green:((float)((_hex & 0xFF00) >> 8))/255.0 \
                            blue:((float)(_hex & 0xFF))/255.0 alpha:1]
#endif
#ifndef RGBAHEX
#define RGBAHEX(_hex, _alpha)    [UIColor \
                                colorWithRed:((float)((_hex & 0xFF0000) >> 16))/255.0 \
                                green:((float)((_hex & 0xFF00) >> 8))/255.0 \
                                blue:((float)(_hex & 0xFF))/255.0 alpha:_alpha]
#endif

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void mxr_dispatch_async_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void mxr_dispatch_sync_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

//#ifndef SINGLE_INSTANCE_USING_BLOCK
/**
 *  单例宏方法
 *
 *  @param block
 *
 *  @return 返回单例
 */
#define SINGLE_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \
//#endif

#endif /* MXRProfilerMacro_h */
