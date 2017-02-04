//
//  MARPrepareAddVehicleViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARPrepareAddVehicleViewController.h"

@interface MARPrepareAddVehicleViewController ()

@end

@implementation MARPrepareAddVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的爱车";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
