//
//  MARMyVehicleViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARMyVehicleViewController.h"
#import "MARVehicleDBM.h"
@interface MARMyVehicleViewController ()
/// IB Property
@property (weak, nonatomic) IBOutlet UILabel *licenseNumberLabel;
/// IB Action
- (IBAction)clickDeleteButtonAction:(id)sender;

@end

@implementation MARMyVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的爱车";
    // Do any additional setup after loading the view.
}

- (void)UIGlobal
{
    MARVehicleDBM *vehicle = (MARVehicleDBM *)[MARVehicleDBM mar_getFirstDBModel];
    if (vehicle) {
        self.licenseNumberLabel.text = [NSString stringWithFormat:@"%@ %@", vehicle.prefixLicenseNumber, [vehicle.suffixLicenseNumber uppercaseString]];
    }
    else
    {
        self.licenseNumberLabel.text = nil;
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

- (IBAction)clickDeleteButtonAction:(id)sender {
    if ([MARVehicleDBM deleteWithWhere:nil]) {
        ShowSuccessMessage(@"删除成功！", 1.f);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        ShowErrorMessage(@"删除失败！请稍后再试", 1.f);
    }
}
@end
