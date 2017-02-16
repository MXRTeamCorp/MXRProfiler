//
//  MXRNetFlowView.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerNetFlowListView.h"

@implementation MXRProfilerNetFlowListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];

        [self addSubview:_tableView];
    }
    return self;
}


-(void)layoutSubviews{
    _tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

@end
