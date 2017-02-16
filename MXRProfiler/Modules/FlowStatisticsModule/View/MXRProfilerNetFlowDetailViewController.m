//
//  MXRProfilerNetFlowDetailViewController.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerNetFlowDetailViewController.h"
#import "MXRProfilerNetFlowDetailView.h"

@interface MXRProfilerNetFlowDetailViewController (){
    MXRProfilerNetFlowDetailView *_netFlowDetailView;
}

@end

@implementation MXRProfilerNetFlowDetailViewController

#pragma mark LifeCircle
-(void)loadView{
    _netFlowDetailView = [MXRProfilerNetFlowDetailView new];
    self.view          = _netFlowDetailView;
    self.view.frame    = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
