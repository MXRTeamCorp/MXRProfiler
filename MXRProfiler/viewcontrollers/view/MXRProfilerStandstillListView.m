//
//  MXRProfilerStandstillListView.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerStandstillListView.h"

static const CGFloat kMXRProfilerStandstaillListView_HeaderViewHeight = 40;
static const CGFloat kMXRProfilerStandstaillListView_CommonButtonHeight = 30;
static const CGFloat kMXRProfilerStandstaillListView_CommonButtonWidth = 100;
@implementation MXRProfilerStandstillListView
{
    UIView *_headerView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        _clearButton = [[UIButton alloc] init];
        [_clearButton setTitle:@"clear" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _hiddenButton = [[UIButton alloc] init];
        [_hiddenButton setTitle:@"hidden" forState:UIControlStateNormal];
        [_hiddenButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        
        [_headerView addSubview:_clearButton];
        [_headerView addSubview:_hiddenButton];
        [self addSubview:_headerView];
        [self addSubview:_tableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), kMXRProfilerStandstaillListView_HeaderViewHeight);
    _hiddenButton.frame = CGRectMake(15, (kMXRProfilerStandstaillListView_HeaderViewHeight - kMXRProfilerStandstaillListView_CommonButtonHeight) / 2, kMXRProfilerStandstaillListView_CommonButtonWidth, kMXRProfilerStandstaillListView_CommonButtonHeight);
    
    _clearButton.frame = CGRectMake(MIN(30 + CGRectGetMaxX(_hiddenButton.bounds), CGRectGetWidth(self.bounds) - 15 - kMXRProfilerStandstaillListView_CommonButtonWidth) , (kMXRProfilerStandstaillListView_HeaderViewHeight - kMXRProfilerStandstaillListView_CommonButtonHeight) / 2, kMXRProfilerStandstaillListView_CommonButtonWidth, kMXRProfilerStandstaillListView_CommonButtonHeight);
    
    _tableView.frame = CGRectMake(0, CGRectGetHeight(_headerView.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - kMXRProfilerStandstaillListView_HeaderViewHeight);
}

@end
