//
//  MARReserveParkSpaceResultViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/7.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARReserveParkSpaceResultViewController.h"
#import "MARVehicleDBM.h"
@interface MARReserveParkSpaceResultViewController ()
#pragma mark IB Property
@property (weak, nonatomic) IBOutlet UILabel *reserveInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *reserveDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *reserveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

#pragma mark IB Action
- (IBAction)clickSendInfoToPhoneAction:(id)sender;

#pragma mark Costom Property
@property (nonatomic, strong) NSAttributedString *reserveInfoAttr;
@property (nonatomic, strong) NSAttributedString *tipAttr;
@end

@implementation MARReserveParkSpaceResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约车位";
    self.reserveDateLabel.text = self.dateString;
    self.reserveTimeLabel.text = self.timeString;
    
    self.reserveInfoLabel.attributedText = self.reserveInfoAttr;
    self.tipLabel.attributedText = self.tipAttr;
}

- (NSAttributedString *)reserveInfoAttr
{
    
    NSString *reserveInfoString = [NSString stringWithFormat:@"恭喜！您已经成功预约 “%@”", self.parkSpaceName ?: @""];
    NSMutableAttributedString *tempAttr = [[NSMutableAttributedString alloc] initWithString:reserveInfoString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.f], NSForegroundColorAttributeName:kMainColor}];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 3;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    [tempAttr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, tempAttr.length)];
    return tempAttr;
}

- (NSAttributedString *)tipAttr
{
    MARVehicleDBM *vehicleDBM = (MARVehicleDBM *)[MARVehicleDBM mar_getFirstDBModel];
    NSString *tipString = [NSString stringWithFormat:@"请驾驶您车牌为 “%@%@” 的爱车直接于预定时间后到达该停车场泊车即可", vehicleDBM.prefixLicenseNumber ?: @"", vehicleDBM.suffixLicenseNumber ?: @""];
    NSMutableAttributedString *tempAttr = [[NSMutableAttributedString alloc] initWithString:tipString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f], NSForegroundColorAttributeName:RGBHEX(0x999999)}];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 3;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    [tempAttr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, tempAttr.length)];
    return tempAttr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickSendInfoToPhoneAction:(id)sender {
    ShowSuccessMessage(@"模拟发送成功", 1.f);
    [MARGLOBALMANAGER postNotif:kNOTIFICATION_reverseParkspaceSuccess data:nil object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
