//
//  MXRFPSObserver.h
//  easywayout
//
//  Created by mxr on 17/1/17.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRFPSObserver : NSObject

@property (nonatomic, assign, readonly) NSInteger fpsRate;

- (void)setPaused:(BOOL)paused;

@end
