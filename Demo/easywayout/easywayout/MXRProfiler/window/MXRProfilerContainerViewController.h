//
//  MXRProfilerContainerViewController.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXRProfilerMovableViewController.h"
@interface MXRProfilerContainerViewController : UIViewController

- (void)presentViewController:(nonnull UIViewController<MXRProfilerMovableViewController> *)viewController
                     withSize:(CGSize)size;

- (void)dismissCurrentViewController;

@end
