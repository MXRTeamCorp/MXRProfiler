//
//  MARVerifyPhoneCodeViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/7.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARVerifyPhoneCodeViewController.h"

@interface MARVerifyPhoneCodeViewController ()
#pragma mark IB Property UI
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_upTitleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_vefiryButtonTop;

#pragma mark IB Property
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *vefifyCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeButton;

#pragma mark IB Action
- (IBAction)clickCloseButtonAction:(id)sender;
- (IBAction)clickGetVerifyCodeButtonAction:(id)sender;
- (IBAction)clickVerifyButtonAction:(id)sender;

@end

@implementation MARVerifyPhoneCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTapResignTFS:YES];
    // Do any additional setup after loading the view.
}

- (void)UIGlobal
{
    if (kiPhone4s) {
        self.constraint_upTitleTop.constant = 40;
        self.constraint_vefiryButtonTop.constant = 30;
    }
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
- (IBAction)clickCloseButtonAction:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)clickGetVerifyCodeButtonAction:(id)sender {
    ShowSuccessMessage(@"模拟获取验证码成功", 1.f);
}

- (IBAction)clickVerifyButtonAction:(id)sender {
    UIViewController *resetPasswordVC = VCBySBNameAndSBID(kSBNAME_LOGIN, kSBID_VCNAME_ResetPassword);
    [self.navigationController pushViewController:resetPasswordVC animated:YES];
}

@end
