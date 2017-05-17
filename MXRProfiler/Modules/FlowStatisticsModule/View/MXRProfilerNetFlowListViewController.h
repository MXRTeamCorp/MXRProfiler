//
//  MXRNetFlowViewController.h
//  easywayout
//
//  Created by weiqing.tang on 2017/2/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerBaseViewController.h"
#import "MXRProfilerMovableViewController.h"
#import "MXRProfilerPresentationModeDelegate.h"

@interface MXRProfilerNetFlowListViewController : MXRProfilerBaseViewController<MXRProfilerMovableViewController>

@property (nonatomic, weak) id<MXRProfilerPresentationModeDelegate> delegate;
@end
