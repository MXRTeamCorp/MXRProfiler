//
//  MXRProfilerNavigationViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/2/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerNavigationViewController.h"

@interface MXRProfilerNavigationViewController ()

@end

@implementation MXRProfilerNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MXRProfilerMovableViewController

- (void)containerWillMove:(UIViewController *)container
{
    // No extra behavior
}

- (BOOL)shouldStretchInMovableContainer
{
    return YES;
}

- (CGFloat)minimumHeightInMovableContainer
{
    return 200;
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
