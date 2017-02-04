//
//  UIViewController+MarExtension.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VCBySBNameAndSBID(_kSBName_, _kSBID_) [UIViewController vcWithStoryboardName:_kSBName_ storyboardId:_kSBID_];

@interface UIViewController (MarExtension)
+ (instancetype)vcWithStoryboardName:(NSString*)name storyboardId:(NSString*)storyboardId;
@end
