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
@property (nonatomic, strong) NSString *allTreadCallStack;

@end
