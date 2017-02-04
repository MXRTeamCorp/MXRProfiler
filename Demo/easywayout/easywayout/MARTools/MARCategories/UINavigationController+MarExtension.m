//
//  UINavigationController+MarExtension.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "UINavigationController+MarExtension.h"

@implementation UINavigationController (MarExtension)
#ifdef MARNavigationOrientation
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}
#endif

- (NSArray<UIViewController *> *)popToViewControllerClazz:(Class)clazz Animated:(BOOL)animated
{
    NSArray* vcArray = self.viewControllers;
    for (UIViewController* vc in vcArray) {
        if ([vc isKindOfClass:clazz]) {
            return [self popToViewController:vc animated:animated];
        }
    }
    return nil;
}
@end

@implementation UINavigationBar (MarCustomNaviStyle)
- (UIImage *)backIndicatorImage
{
    return [UIImage imageNamed:@"btn_navigation_back"]; // icon_navi.png
}
@end


@implementation UINavigationItem (MarCustomNaviStyle)
- (UIBarButtonItem *)backBarButtonItem
{
    return [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}
@end
