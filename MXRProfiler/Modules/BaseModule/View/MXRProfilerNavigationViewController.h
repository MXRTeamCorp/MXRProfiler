//
//  MXRProfilerNavigationViewController.h
//  easywayout
//
//  Created by Martin.Liu on 2017/2/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXRProfilerBaseViewController.h"
#import "MXRProfilerMovableViewController.h"
#import "MXRProfilerPresentationModeDelegate.h"

@interface MXRProfilerNavigationViewController : UINavigationController <MXRProfilerMovableViewController>

@property (nonatomic, weak) id<MXRProfilerPresentationModeDelegate> profilerDelegate;

@end
