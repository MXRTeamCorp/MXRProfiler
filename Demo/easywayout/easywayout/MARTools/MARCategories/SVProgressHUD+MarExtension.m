//
//  SVProgressHUD+MarExtension.m
//  
//
//  Created by Martin.Liu on 15/12/24.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import "SVProgressHUD+MarExtension.h"

@implementation SVProgressHUD (MarExtension)

+ (void) mar_showSuccessWithStatus:(NSString*)status duration:(CGFloat)duration
{
    [self setMinimumDismissTimeInterval:duration];
    [self showSuccessWithStatus:status];
}
+ (void) mar_showErrorWithStatus:(NSString*)status duration:(CGFloat)duration
{
    [self setMinimumDismissTimeInterval:duration];
    [self showErrorWithStatus:status];
}
+ (void) mar_showInfoWithStatus:(NSString*)status  duration:(CGFloat)duration
{
    [self setMinimumDismissTimeInterval:duration];
    [self showInfoWithStatus:status];
}
@end
