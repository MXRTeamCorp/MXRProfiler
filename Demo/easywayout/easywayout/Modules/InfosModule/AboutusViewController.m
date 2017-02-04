//
//  AboutusViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "AboutusViewController.h"

#ifndef AppShortVersion
#define AppShortVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#endif

@interface AboutusViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_upTitleTop;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
- (IBAction)clickCloseButtonAction:(id)sender;

@end

@implementation AboutusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.versionLabel.text = AppShortVersion;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)UIGlobal
{
    if (kiPhone4s) {
        self.constraint_upTitleTop.constant = 40;
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
@end
