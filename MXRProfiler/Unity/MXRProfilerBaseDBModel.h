//
//  MXRProfilerBaseDBModel.h
//  easywayout
//
//  Created by Martin.Liu on 2017/2/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<LKDBHelper.h>)
#import <LKDBHelper.h>
#elif __has_include("LKDBHelper.h")
#import "LKDBHelper.h"
#else
#define MXRPROFILERDB_INVALID
#endif

/**
 在LKDB的基础上创建的一个 基础model 与 数据库进行交互
 和数据库交互的直接继承它就可以。 数据库在Documents下的MessageRecord.sqlite中
 与之前保存数据的数据库保持了一致。
 
 */
@interface MXRProfilerBaseDBModel : NSObject

@end
