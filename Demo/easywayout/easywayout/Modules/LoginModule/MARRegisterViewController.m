//
//  MARRegisterViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARRegisterViewController.h"

@interface MARRegisterViewController ()
#pragma mark IB Property UI
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_upTitleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TFSHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_registerButtonTop;

#pragma mark IB Property
@property (weak, nonatomic) IBOutlet UITextField *userAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;

#pragma mark IB Action
- (IBAction)clickCloseButtonAction:(id)sender;
- (IBAction)clickGetVerifyCodeButtonAction:(id)sender;
- (IBAction)clickRegisterButtonAction:(id)sender;

@end

@implementation MARRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTapResignTFS:YES];
    // Do any additional setup after loading the view.
}

- (void)UIGlobal
{
    if (kiPhone4s) {
        self.constraint_upTitleTop.constant = 50;
        self.constraint_TFSHeight.constant = 45;
        self.constraint_registerButtonTop.constant = 30;
    }
    else if (kiPhone5)
    {
        
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickGetVerifyCodeButtonAction:(id)sender {
    ShowSuccessMessage(@"模拟获取验证码", 1.f);
}

- (IBAction)clickRegisterButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    ShowSuccessMessage(@"模拟注册成功", 1.f);
}
@end
