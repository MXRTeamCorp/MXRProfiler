//
//  UINavigationController+MarExtension.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MarExtension)
- (NSArray<UIViewController *> *)popToViewControllerClazz:(Class)clazz Animated:(BOOL)animated;
@end


@interface UINavigationBar (MarCustomNaviStyle)

@end

@interface UINavigationItem (MarCustomNaviStyle)

@end
