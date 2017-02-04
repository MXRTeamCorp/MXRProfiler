//
//  MXRFPSObserver.m
//  easywayout
//
//  Created by mxr on 17/1/17.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRFPSObserver.h"
#import "MXRWeakProxy.h"
@interface MXRFPSObserver()
@property (nonatomic, assign) NSInteger fpsRate;

@end

@implementation MXRFPSObserver
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
}

- (instancetype)init
{
    if (self = [super init]) {
        _link = [CADisplayLink displayLinkWithTarget:[MXRWeakProxy proxyWithTarget:self] selector:@selector(tick:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mxr_applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mxr_applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        
    }
    return self;
}

- (void)dealloc {
    [_link invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)mxr_applicationWillResignActive:(NSNotification *)noti
{
    [self setPaused:YES];
}

- (void)mxr_applicationDidBecomeActive:(NSNotification *)noti
{
    [self setPaused:NO];
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    self.fpsRate = (int)round(fps);
}

- (void)setFpsRate:(NSInteger)fpsRate
{
    [self willChangeValueForKey:@"fpsRate"];
    _fpsRate = fpsRate;
    [self didChangeValueForKey:@"fpsRate"];
}

- (void)setPaused:(BOOL)paused
{
    [_link setPaused:paused];
}


@end
