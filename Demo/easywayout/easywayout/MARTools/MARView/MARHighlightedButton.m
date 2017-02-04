//
//  MARHighlightedButton.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/5.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARHighlightedButton.h"

@interface MARHighlightedButton()

@property (nonatomic, strong) UIView *assistantView;

@end

@implementation MARHighlightedButton

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

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    [self setup];
//}

- (void)setup
{
    [self addSubview:self.assistantView];
    self.assistantView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewDic = @{@"assistantView":self.assistantView};
    NSArray<NSLayoutConstraint *> *vConstrants = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[assistantView]|" options:0 metrics:nil views:viewDic];
    NSArray<NSLayoutConstraint *> *hConstrants = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[assistantView]|" options:0 metrics:nil views:viewDic];
    [self addConstraints:vConstrants];
    [self addConstraints:hConstrants];
}

- (UIView *)assistantView
{
    if (!_assistantView) {
        _assistantView = [UIView new];
        _assistantView.backgroundColor = UIColorFromRGB(0x000000, 0.3);
        _assistantView.hidden = YES;
        _assistantView.userInteractionEnabled = NO;
    }
    return _assistantView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.assistantView.hidden = !highlighted;
}

@end
