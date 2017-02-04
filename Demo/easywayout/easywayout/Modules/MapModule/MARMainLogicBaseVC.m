//
//  MARMainLogicBaseVC.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/8.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARMainLogicBaseVC.h"
#import "AboutusViewController.h"
#import "MARLoginViewController.h"
#import "MARVehicleDBM.h"
#import "MarReserveParkSpaceViewController.h"
@interface MARMainLogicBaseVC ()
#pragma mark - IB Property
@property (weak, nonatomic) IBOutlet UIView *popMenuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_popMenuViewTop;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userAccountLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomParkspaceInfoView;
@property (weak, nonatomic) IBOutlet UILabel *parkspaceNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_bottomParkspaceInfoViewBottom;

#pragma mark - IB Action
- (IBAction)clickLogoutButtonAction:(id)sender;
- (IBAction)clickMenuButtonAction:(id)sender;
- (IBAction)clickMyCarButtonAction:(id)sender;
- (IBAction)clickChangePasswordButtonAction:(id)sender;
- (IBAction)clickAbortusButtonAction:(id)sender;
- (IBAction)reserveParkspaceButtonAction:(id)sender;
@property (weak) id<UITableViewDelegate> codeStandardDelegate;
@end
static const CGFloat kShowPopMenuViewConstant = 0;
static const CGFloat kHiddenPopMenuViewConstant = -300;
#ifndef RESERVEPARKSPACEVIEW_MIDDLE
    #ifdef RESERVEPARKSPACEVIEW_BOTTOM
static const CGFloat kShowParkViewViewBottomConstant = 0;
static const CGFloat kHiddenParkViewViewBottomConstant = 200;
    #endif
#endif
@implementation MARMainLogicBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenPopMenuViewWhenShow];
    [self hiddenParkSpaceViewWhenShow];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self hiddenPopMenuViewWhenShow];
}

- (void)setParkspaceName:(NSString *)parkspaceName
{
    _parkspaceName = [parkspaceName copy];
    self.parkspaceNameLabel.text = _parkspaceName ?: @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hiddenPopMenuViewWhenShow
{
    [self hiddenPopMenuViewWhenShowWithAnimated:NO];
}

- (void)hiddenPopMenuViewWhenShowWithAnimated:(BOOL)animated
{
    if (self.constraint_popMenuViewTop.constant != kHiddenPopMenuViewConstant) {
        [self hiddenPopmenuView:YES animated:animated];
    }
}

- (void)hiddenPopmenuView:(BOOL)hidden
{
    [self hiddenPopmenuView:hidden animated:NO];
}

- (void)hiddenPopmenuView:(BOOL)hidden animated:(BOOL)animated
{
    CGFloat topConstrant = kShowPopMenuViewConstant;
    if (hidden) {
        topConstrant = kHiddenPopMenuViewConstant;
    }
    self.constraint_popMenuViewTop.constant = topConstrant;
    if (animated) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
}

- (void)hiddenParkSpaceView:(BOOL)hidden
{
    [self hiddenParkSpaceView:hidden animated:NO];
}

- (void)hiddenParkSpaceView:(BOOL)hidden animated:(BOOL)animated
{
#ifndef RESERVEPARKSPACEVIEW_MIDDLE
    #ifdef RESERVEPARKSPACEVIEW_BOTTOM
    CGFloat bottomConstant = kShowParkViewViewBottomConstant;
    if (hidden) {
        bottomConstant = kHiddenParkViewViewBottomConstant;
    }
    self.constraint_bottomParkspaceInfoViewBottom.constant = bottomConstant;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }    
    #endif
#endif
}

- (void)hiddenParkSpaceViewWhenShow
{
    [self hiddenParkSpaceViewwWhenShowWithAnimated:NO];
}
- (void)hiddenParkSpaceViewwWhenShowWithAnimated:(BOOL)animated
{
#ifndef RESERVEPARKSPACEVIEW_MIDDLE
    #ifdef RESERVEPARKSPACEVIEW_BOTTOM
    if (self.constraint_bottomParkspaceInfoViewBottom.constant != kHiddenParkViewViewBottomConstant) {
        [self hiddenParkSpaceView:YES animated:animated];
    }
    #endif
#endif
}

- (IBAction)clickLogoutButtonAction:(id)sender {
    MARLoginViewController *loginVC = (MARLoginViewController *)VCBySBNameAndSBID(kSBNAME_LOGIN, kSBID_VCNAME_Login);
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navi animated:YES completion:^{
        
    }];
}

- (IBAction)clickMenuButtonAction:(id)sender {
    [self hiddenPopmenuView:NO animated:YES];
}

- (IBAction)clickMyCarButtonAction:(id)sender {
    if ([MARVehicleDBM mar_getAllDBModelArray].count > 0) {
        UIViewController *myVehicleVC = VCBySBNameAndSBID(kSBNAME_MAIN, kSBID_VCNAME_MyVehicle);
        myVehicleVC.showNaviBarViewWillAppeal = YES;
        [self.navigationController pushViewController:myVehicleVC animated:YES];
    }
    else
    {
        UIViewController *prepareAddVehicleVC = VCBySBNameAndSBID(kSBNAME_MAIN, kSBID_VCNAME_PrepareAddVehicle);
        prepareAddVehicleVC.showNaviBarViewWillAppeal = YES;
        [self.navigationController pushViewController:prepareAddVehicleVC animated:YES];
    }
}

- (IBAction)clickChangePasswordButtonAction:(id)sender {
    UIViewController *verifyPhoneCodeToChangePasswordVC = VCBySBNameAndSBID(kSBNAME_LOGIN, kSBID_VCNAME_VerifyPhoneCode);
    [self.navigationController pushViewController:verifyPhoneCodeToChangePasswordVC animated:YES];
}

- (IBAction)clickAbortusButtonAction:(id)sender {
    AboutusViewController *usViewController = [[AboutusViewController alloc] init];
    [self presentViewController:usViewController animated:YES completion:^{
        
    }];
    
}

- (IBAction)reserveParkspaceButtonAction:(id)sender {
    if ([MARVehicleDBM mar_getAllDBModelArray].count == 0) {
        ShowErrorMessage(@"您还没有添加爱车，无法预订", 1.5f);
        return;
    }
    MarReserveParkSpaceViewController *reserveParkSpaceVC = (MarReserveParkSpaceViewController *)VCBySBNameAndSBID(kSBNAME_MAIN, kSBID_VCNAME_ReserveParkSpace);
    reserveParkSpaceVC.showNaviBarViewWillAppeal = YES;
    reserveParkSpaceVC.parkSpaceName = self.parkspaceName;
    [self.navigationController pushViewController:reserveParkSpaceVC animated:YES];
}

- (void)getNotifType:(NSInteger)type data:(id)data target:(id)obj
{
    [super getNotifType:type data:data target:obj];
    if (type == kNOTIFICATION_reverseParkspaceAction)
    {
        [self reserveParkspaceButtonAction:nil];
    }
}

@end
