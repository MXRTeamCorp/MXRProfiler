//
//  MXRProfilerNetFlowCellView.m
//  easywayout
//
//  Created by weiqing.tang on 2017/5/17.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerNetFlowCellView.h"

@interface MXRProfilerNetFlowCellView (){
   
}
@property (nonatomic, strong) UILabel* vcClassNameLabel;
@property (nonatomic, strong) UILabel* urlLabel;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation MXRProfilerNetFlowCellView



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //1.vc class name label
        [self addSubview:self.vcClassNameLabel];
        //2.url label
        [self addSubview:self.urlLabel];
        //3.detail info label
        [self addSubview:self.detailLabel];
        //4.date label
        [self addSubview:self.dateLabel];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark custom

-(UILabel*)vcClassNameLabel{
    if (!_vcClassNameLabel) {
        _vcClassNameLabel = [[UILabel alloc] init];
        _vcClassNameLabel.font = [UIFont systemFontOfSize:15.f];
        _vcClassNameLabel.frame = CGRectMake(15, 0, 300, 16);
    }
    return _vcClassNameLabel;
}

-(UILabel*)urlLabel{
    if (!_urlLabel) {
        _urlLabel = [[UILabel alloc] init];
        _urlLabel.font = [UIFont systemFontOfSize:12.f];
        _urlLabel.frame = CGRectMake(15, 15, 300, 16);
    }
    return _urlLabel;
}

-(UILabel*)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:12.f];
        _detailLabel.frame = CGRectMake(15, 28, 300, 16);
    }
    return _detailLabel;
}
-(UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:12.f];
        _dateLabel.frame = CGRectMake(290, 15, 300, 16);
    }
    return _dateLabel;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"hh:mm:ss.SSS";
    }
    return _dateFormatter;
}


-(void)setData:(MXRNetFlowInfo*)info{
    self.vcClassNameLabel.text = info.currentVCClassName;
    self.urlLabel.text         = info.url;
    if (info.flowAmountResponse > 1024) {
        self.detailLabel.text      = [NSString stringWithFormat:@"%@/%ld/%.2fKB",info.httpMethod,info.flowAmountRequest,info.flowAmountResponse/1024.0];
    }else{
        self.detailLabel.text      = [NSString stringWithFormat:@"%@/%ld/%ldB",info.httpMethod,info.flowAmountRequest,info.flowAmountResponse];
    }
    
    self.dateLabel.text        = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:info.happendTimeIntervalSince1970]];
}

@end
