//
//  MARResetPasswordViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/7.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARResetPasswordViewController.h"

@interface MARResetPasswordViewController ()
#pragma mark IB Property UI
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_upTitleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_modifyButtonTop;

#pragma mark IB Property
@property (weak, nonatomic) IBOutlet UITextField *aPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *bPasswordTF;

#pragma mark IB Action
- (IBAction)clickCloseButtonAction:(id)sender;
- (IBAction)clickModifyButtonAction:(id)sender;

@end

@implementation MARResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTapResignTFS:YES];
}

- (void)UIGlobal
{
    if (kiPhone4s) {
        self.constraint_upTitleTop.constant = 40;
        self.constraint_modifyButtonTop.constant = 30;
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

- (IBAction)clickModifyButtonAction:(id)sender
{
    if (self.presentingViewController) {
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    ShowSuccessMessage(@"模拟修改成功", 1.f);
}

- (IBAction)clickCloseButtonAction:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
//        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
