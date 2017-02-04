//
//  NSObject+MXRSwizz.m
//  easywayout
//
//  Created by Martin.Liu on 2017/2/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "NSObject+MXRSwizz.h"
#import <objc/runtime.h>

@implementation NSObject (MXRSwizz)

+ (void)mxr_swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
