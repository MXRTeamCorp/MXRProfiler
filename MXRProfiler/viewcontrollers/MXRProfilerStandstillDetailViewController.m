//
//  MXRProfilerStandstillDetailViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/2/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerStandstillDetailViewController.h"
#import "MXRProfilerStandstillDetailScrollView.h"
#import "MXRProfilerStandstillDetailView.h"
@interface MXRProfilerStandstillDetailViewController ()

@end

@implementation MXRProfilerStandstillDetailViewController

- (void)loadView
{
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    MXRProfilerStandstillDetailView *standstillDetailView = [MXRProfilerStandstillDetailView new];
    self.view = standstillDetailView;
    standstillDetailView.standstillInfo = self.standstillInfo;
    
    [standstillDetailView.closeBtn addTarget:self action:@selector(clickCloseAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickCloseAction:(id)sender
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
