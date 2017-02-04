//
//  UIViewController+MarExtension.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "UIViewController+MarExtension.h"

@implementation UIViewController (MarExtension)
+ (UIViewController*)vcWithStoryboardName:(NSString *)name storyboardId:(NSString *)storyboardId
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    if (storyboard) {
        MARAssert(!storyboard, @"Storyboard<name :'%@'> is not exist", name);
    }
    return [storyboard instantiateViewControllerWithIdentifier:storyboardId];
}
@end
