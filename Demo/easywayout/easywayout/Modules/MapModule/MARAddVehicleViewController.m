//
//  MARAddVehicleViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/6.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARAddVehicleViewController.h"
#import "MARPrepareAddVehicleViewController.h"
#import "MARVehicleDBM.h"
@interface MARAddVehicleViewController ()
#pragma mark - IB Property
@property (weak, nonatomic) IBOutlet UIButton *prefixLicenseNumberButton;
@property (weak, nonatomic) IBOutlet UITextField *suffixLicenseNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *addLicenseNumberButton;

#pragma mark - IB Action
- (IBAction)clickPrefixLicenseNumberButtonAction:(id)sender;
- (IBAction)clickAddLicenseNumberButtonAction:(id)sender;

@end

@implementation MARAddVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加爱车";
    [self setTapResignTFS:YES];
    self.addLicenseNumberButton.enabled = NO;
    [self.suffixLicenseNumberTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChanged:(UITextField *)textField
{
    self.addLicenseNumberButton.enabled = textField.text.length > 0;
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

- (IBAction)clickPrefixLicenseNumberButtonAction:(id)sender {
}

- (IBAction)clickAddLicenseNumberButtonAction:(id)sender {
    if (self.suffixLicenseNumberTF.text.length > 0) {
        MARVehicleDBM *vehicle = [[MARVehicleDBM alloc] init];
        vehicle.prefixLicenseNumber = [self.prefixLicenseNumberButton.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        vehicle.suffixLicenseNumber = [self.suffixLicenseNumberTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        // 删除表中所有记录
        if ([MARVehicleDBM deleteWithWhere:nil]) {
            MARLog(@"成功删除VehicleDB表中的所有记录");
        }
        BOOL addFlag = [vehicle saveToDB];
        if (addFlag) {
            ShowSuccessMessage(@"添加成功", 1.f);
//            NSArray<UIViewController *> *vcs = self.navigationController.viewControllers;
//            if (vcs.count >= 3) {
//                NSMutableArray *tempvcs = [NSMutableArray arrayWithArray:vcs];
//                for (UIViewController *vc in tempvcs) {
//                    if ([vc isKindOfClass:[MARPrepareAddVehicleViewController class]]) {
//                        [tempvcs removeObject:vc];
//                        break;
//                    }
//                }
//                if (tempvcs.count >= 2) {
//                    [self.navigationController setViewControllers:tempvcs];
//                }
//            }
//            [self.navigationController popViewControllerAnimated:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
            ShowErrorMessage(@"添加失败", 1.f);
    }
}
@end
