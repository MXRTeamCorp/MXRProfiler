//
//  SVProgressHUD+MarExtension.h
//
//
//  Created by Martin.Liu on 15/12/24.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import <SVProgressHUD.h>

@interface SVProgressHUD (MarExtension)
+ (void) mar_showSuccessWithStatus:(NSString*)status duration:(CGFloat)duration;
+ (void) mar_showErrorWithStatus:(NSString*)status duration:(CGFloat)duration;
+ (void) mar_showInfoWithStatus:(NSString*)status  duration:(CGFloat)duration;

@end
