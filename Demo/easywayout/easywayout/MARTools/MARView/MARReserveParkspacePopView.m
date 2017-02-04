//
//  MARReserveParkspacePopView.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/8.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARReserveParkspacePopView.h"
#import <Masonry.h>
#import <UIView+YYAdd.h>
@interface MARReserveParkspacePopView()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *parkspaceNameLabel;
@property (nonatomic, strong) UIView *seperateLine;
@property (nonatomic, strong) UILabel *tipTitleLabel1;
@property (nonatomic, strong) UILabel *tipTitleLabel2;
@property (nonatomic, strong) UILabel *tipSubTitilLabel1;
@property (nonatomic, strong) UILabel *tipSubTitilLabel2;
@property (nonatomic, strong) UIButton *reserveParkspaceButton;

@end

@implementation MARReserveParkspacePopView

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.parkspaceNameLabel];
    [self.contentView addSubview:self.seperateLine];
    [self.contentView addSubview:self.tipTitleLabel1];
    [self.contentView addSubview:self.tipSubTitilLabel1];
    [self.contentView addSubview:self.tipTitleLabel2];
    [self.contentView addSubview:self.tipSubTitilLabel2];
    [self.contentView addSubview:self.reserveParkspaceButton];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(6, 6, 9, 6));
    }];
    [self.parkspaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
        make.height.mas_greaterThanOrEqualTo(@15);
    }];
    [self.seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.parkspaceNameLabel.mas_leading);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-15);
        make.top.mas_equalTo(self.parkspaceNameLabel.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(kScreenOnePixelSize);
    }];
    [self.tipTitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.parkspaceNameLabel);
        make.top.mas_equalTo(self.seperateLine.mas_bottom).mas_offset(16);
    }];
    [self.tipSubTitilLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.tipTitleLabel1.mas_trailing).mas_offset(8);
        make.baseline.mas_equalTo(self.tipTitleLabel1.mas_baseline);
    }];
    [self.tipTitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.parkspaceNameLabel);
        make.top.mas_equalTo(self.tipTitleLabel1.mas_bottom).mas_offset(20);
    }];
    [self.tipSubTitilLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.tipTitleLabel2.mas_trailing).mas_offset(8);
        make.baseline.mas_equalTo(self.tipTitleLabel2);
    }];
    [self.reserveParkspaceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seperateLine.mas_bottom).mas_offset(25);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-15);
    }];
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"bg_parkinglotpopup"];
    }
    return _backgroundImageView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UILabel *)parkspaceNameLabel
{
    if (!_parkspaceNameLabel) {
        _parkspaceNameLabel = [[UILabel alloc] init];
        _parkspaceNameLabel.font = [UIFont systemFontOfSize:15.f];
        _parkspaceNameLabel.text = @"停车场";
    }
    return _parkspaceNameLabel;
}

- (UIView *)seperateLine
{
    if (!_seperateLine) {
        _seperateLine = [[UIView alloc] init];
        _seperateLine.backgroundColor = RGBHEX(0xe5e5e5);
    }
    return _seperateLine;
}

- (UILabel *)tipTitleLabel1
{
    if (!_tipTitleLabel1) {
        _tipTitleLabel1 = [[UILabel alloc] init];
        _tipTitleLabel1.font = [UIFont systemFontOfSize:15.f];
        _tipTitleLabel1.textColor = RGBHEX(0x999999);
        _tipTitleLabel1.text = @"车位";
    }
    return _tipTitleLabel1;
}

- (UILabel *)tipSubTitilLabel1
{
    if (!_tipSubTitilLabel1) {
        _tipSubTitilLabel1 = [[UILabel alloc] init];
        _tipSubTitilLabel1.font = [UIFont boldSystemFontOfSize:20.f];
        _tipSubTitilLabel1.textColor = kMainColor;
        _tipSubTitilLabel1.text = @"6 / 110";
    }
    return _tipSubTitilLabel1;
}

- (UILabel *)tipTitleLabel2
{
    if (!_tipTitleLabel2) {
        _tipTitleLabel2 = [[UILabel alloc] init];
        _tipTitleLabel2.font = [UIFont systemFontOfSize:15.f];
        _tipTitleLabel2.textColor = RGBHEX(0x999999);
        _tipTitleLabel2.text = @"收费";
    }
    return _tipTitleLabel2;
}

- (UILabel *)tipSubTitilLabel2
{
    if (!_tipSubTitilLabel2) {
        _tipSubTitilLabel2 = [[UILabel alloc] init];
        _tipSubTitilLabel2.font = [UIFont systemFontOfSize:20.f];
        _tipSubTitilLabel2.textColor = RGBHEX(0x666666);
        _tipSubTitilLabel2.text = @"5 / 小时";
    }
    return _tipSubTitilLabel2;
}

- (UIButton *)reserveParkspaceButton
{
    if (!_reserveParkspaceButton) {
        _reserveParkspaceButton = [[UIButton alloc] init];
        [_reserveParkspaceButton setTitle:@"预约车位" forState:UIControlStateNormal];
        [_reserveParkspaceButton setBackgroundImage:[UIImage imageNamed:@"bg_roundedrectangle_shortbutton"] forState:UIControlStateNormal];
        [_reserveParkspaceButton addTarget:self action:@selector(clickReserveParkAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reserveParkspaceButton;
}

- (void)clickReserveParkAction:(id)sender
{
    MARLog(@"click the reserve park button");
    [MARGLOBALMANAGER postNotif:kNOTIFICATION_reverseParkspaceAction data:nil object:nil];
}

- (void)setParkspaceName:(NSString *)parkspaceName
{
    _parkspaceName = [parkspaceName copy];
    self.parkspaceNameLabel.text = _parkspaceName ?: @"";
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.backgroundImageView.frame = CGRectComposes(CGPointZero, self.frame.size);
//    self.contentView.frame = CGRectMake(6, 6, CGRectGetWidth(self.frame) - 6 - 6, self.height - 6 - 9);
//    self.parkspaceNameLabel.frame = CGRectMake(15, 15, self.contentView.width - 15 * 2, 18);
//    self.seperateLine.frame = CGRectMake(15, self.parkspaceNameLabel.bottom + 10, self.contentView.width - 15 - 15, kScreenOnePixelSize);
//    self.reserveParkspaceButton.frame = CGRectMake(self.contentView.width - 15 - 85, self.seperateLine.bottom + 25, 85, 33);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
