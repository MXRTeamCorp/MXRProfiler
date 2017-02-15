//
//  MXRNetFlowInfo.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/15.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRNetFlowInfo.h"

@implementation MXRNetFlowInfo
-(NSUInteger)flowAmountTotal{
    return (_flowAmountRequest + _flowAmountResponse);
}

- (NSString *)description{
    return [NSString stringWithFormat:@"\nURL=%@\n viewController=%@\n request size=%ld\n response size=%ld\n HttpMethod=%@\n amountTotal=%ld\n netStatus=%ld\n createTime=%@\n",_url,_viewControllerName,_flowAmountRequest,_flowAmountResponse,_HTTPMethod,self.flowAmountTotal,_netStatus,_createTime];
}
@end
