//
//  MXRProfilerSimpleInfoViewController.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/17.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXRProfilerBaseViewController.h"
#import "MXRProfilerMovableViewController.h"
#import "MXRProfilerPresentationModeDelegate.h"

@interface MXRProfilerSimpleInfoViewController : MXRProfilerBaseViewController <MXRProfilerMovableViewController>

@property (nonatomic, weak) id<MXRProfilerPresentationModeDelegate> delegate;

@end
