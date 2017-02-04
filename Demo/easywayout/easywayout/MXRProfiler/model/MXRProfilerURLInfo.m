//
//  MXRProfilerURLInfo.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/22.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerURLInfo.h"

#import "MXRProfilerURLInfo.h"

@interface MXRProfilerURLInfo () <NSCopying>

@end

@implementation MXRProfilerURLInfo

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    if (object && [object isKindOfClass:[MXRProfilerURLInfo class]]) {
        MXRProfilerURLInfo *anotherObj = object;
        return [self.preURLString isEqual:anotherObj.preURLString] && [self.VCClassString isEqual:anotherObj.VCClassString];
    }
    return NO;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@" VCClass : %@\n preURL : %@\n absoluteURL : %@\n requestCount : %ld\n requestSize : %ld\n responseSize : %ld", self.VCClassString, self.preURLString, self.absoluteURLString, self.requestCount, self.requestSize, self.responseSize];
}

- (id)copyWithZone:(NSZone *)zone
{
    MXRProfilerURLInfo *urlInfo = [[self.class allocWithZone:zone] init];
    urlInfo.preURLString = [self.preURLString copy];
    urlInfo.absoluteURLString = [self.absoluteURLString copy];
    urlInfo.VCClassString = [self.VCClassString copy];
    urlInfo.VCTitle = [self.VCTitle copy];
    urlInfo.requestCount = self.requestCount;
    urlInfo.requestSize = self.requestSize;
    urlInfo.responseSize = self.responseSize;
    urlInfo.requestDateTimeIntervalSince1970 = self.requestDateTimeIntervalSince1970;
    urlInfo.finishLodadDateTimeIntervalSince1970 = self.finishLodadDateTimeIntervalSince1970;
    return urlInfo;
}

- (instancetype)init
{
    if (self = [super init]) {
        _requestCount = 1;
    }
    return self;
}

- (void)resetInfo
{
    self.requestSize = 0;
    self.responseSize = 0;
}

@end
