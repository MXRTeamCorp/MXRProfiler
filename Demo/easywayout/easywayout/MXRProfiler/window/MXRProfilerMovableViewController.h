//
//  MXRProfilerMovableViewController.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MXRProfilerMovableViewController <NSObject>
/**
 Container will move view controller (either by pan or pinch).
 */
- (void)containerWillMove:(nonnull UIViewController *)container;

/**
 Should view should stretch on pinch?
 */
- (BOOL)shouldStretchInMovableContainer;

/**
 @return minimum height that view controllers must have
 */
- (CGFloat)minimumHeightInMovableContainer;
@end
