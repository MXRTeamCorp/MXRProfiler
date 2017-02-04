//
//  BMKMapView+MAREX.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/8.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "BMKMapView+MAREX.h"

@implementation BMKMapView (MAREX)

- (void)hiddenLoginView
{
    UIView *logoView = [self valueForKey:@"_logoView"];
    if ([logoView respondsToSelector:@selector(setHidden:)]) {
        [logoView setHidden:YES];
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"_logoView"]) {
        NSLog(@"百度地图的地图Logo不存在了，key:%@", key);
    }
    NSLog(@"百度地图BMKMapView中有get方法没实现，key:%@", key);
    return nil;
}

@end
