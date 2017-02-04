//
//  MARLoginViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARLoginViewController.h"

@interface MARLoginViewController ()
#pragma mark IB Property for UI
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_upTitleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TFSHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_loginButtonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_centerY;
#pragma mark IB Property
@property (weak, nonatomic) IBOutlet UITextField *userAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

#pragma mark IB Action
- (IBAction)clickCloseButtonAction:(id)sender;
- (IBAction)clickLoginButtonAction:(id)sender;

@end

@implementation MARLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTapResignTFS:YES];
    
}

- (void)UIGlobal
{
    if (kiPhone4s) {
        self.constraint_upTitleTop.constant = 50;
        self.constraint_centerY.constant = -10;
        self.constraint_TFSHeight.constant = 45;
        self.constraint_loginButtonTop.constant = 15;
    }
    else if (kiPhone5)
    {
        self.constraint_TFSHeight.constant = 50;
        self.constraint_loginButtonTop.constant = 30;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
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

- (IBAction)clickLoginButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    ShowSuccessMessage(@"模拟登陆成功", 1.f);
}
@end
