//
//  NSObject+MXRSwizz.h
//  easywayout
//
//  Created by Martin.Liu on 2017/2/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MXRSwizz)
+ (void)mxr_swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;
@end
