//
//  MXRProfilerStandstillDetailView.h
//  easywayout
//
//  Created by Martin.Liu on 2017/2/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXRProfilerStandstillInfo.h"

@interface MXRProfilerStandstillDetailView : UIView
@property (nonatomic, strong, readonly) UIScrollView *scrollview;
@property (nonatomic, strong) MXRProfilerStandstillInfo *standstillInfo;
@property (nonatomic, strong) UIButton *closeBtn;

@end
