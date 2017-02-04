//
//  MXRProfilerStandstillDetailScrollView.m
//  easywayout
//
//  Created by Martin.Liu on 2017/2/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerStandstillDetailScrollView.h"
#define MXRProfilerStandstillDetailScrollViewDetailLabelFont [UIFont systemFontOfSize:12.f]
@implementation MXRProfilerStandstillDetailScrollView
{
    UILabel *_detailLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.numberOfLines = 0;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLabel.font = MXRProfilerStandstillDetailScrollViewDetailLabelFont;
        
        _closeBtn = [UIButton new];
        [_closeBtn setTitle:@"Close" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _closeBtn.contentMode = UIViewContentModeLeft;
        
        [self addSubview:_closeBtn];
        [self addSubview:_detailLabel];
    }
    return self;
}
static NSDateFormatter *dateFormatter;
- (void)setStandstillInfo:(MXRProfilerStandstillInfo *)standstillInfo
{
    _standstillInfo = standstillInfo;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    }
    NSString *detailString = [NSString stringWithFormat:@"VC:%@\nTime:%@\n%@", self.standstillInfo.currentVCClassName, [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.standstillInfo.happendTimeIntervalSince1970]], self.standstillInfo.mainTreadCallStack];
    _detailLabel.text = detailString;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _closeBtn.frame = CGRectMake(15, 5, [UIScreen mainScreen].bounds.size.width, 30);
    _detailLabel.frame = CGRectMake(15, 5 + 30 + 15, [UIScreen mainScreen].bounds.size.width - 15 * 2, 0);
    CGFloat height = [_detailLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_detailLabel.frame), FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MXRProfilerStandstillDetailScrollViewDetailLabelFont} context:nil].size.height;
    _detailLabel.frame = CGRectMake(15, 5 + 30 + 15, [UIScreen mainScreen].bounds.size.width - 15 * 2, height);
    self.contentSize = CGSizeMake(self.contentOffset.x, height + 5 + 30 + 15 + 15);
}

@end
