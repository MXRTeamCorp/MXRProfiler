//
//  MARBaseDBModel.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/5.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LKDBHelper.h>
@interface MARBaseDBModel : NSObject

+ (NSArray<MARBaseDBModel *> *)mar_getAllDBModelArray;

+ (MARBaseDBModel *)mar_getFirstDBModel;

@end
