//
//  MARBaseViewController.m
//  
//
//  Created by Martin.Liu on 15/12/21.
//  Copyright © 2015年 MAR. All rights reserved.
//

#import "MARBaseViewController.h"
#import <objc/runtime.h>
@interface MARBaseViewController ()
@property (nonatomic, strong) UITapGestureRecognizer* resignFirstResponserGesture;
@end

@implementation MARBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.view.backgroundColor = RGBHEX(MARColor1_VCBackgound);
    [self addObserverGlobal];
    if ([self respondsToSelector:@selector(UIGlobal)]) {
        [self UIGlobal];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.showNaviBarViewWillAppeal) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    }
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - set YES/NO to indicate wheather resign first responder when tap view
#pragma mark start
- (void)setTapResignTFS:(BOOL)isTapResignTFS
{
    if (isTapResignTFS) {
        [self.view addGestureRecognizer:self.resignFirstResponserGesture];
    }
    else
    {
        [self.view removeGestureRecognizer:_resignFirstResponserGesture];
    }
}

- (UITapGestureRecognizer *)resignFirstResponserGesture
{
    if (!_resignFirstResponserGesture) {
        _resignFirstResponserGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTFS)];
    }
    return _resignFirstResponserGesture;
}

- (void)resignTFS
{
    [self.view endEditing:YES];
}
#pragma mark end
#pragma mark -

- (void)UIGlobal{}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

//statusbar 用白色字体
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
#pragma mark -
#pragma mark 全局通知  -- start
- (void)addObserverGlobal{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__getNotif:) name:kMARGlobalNotification object:nil];
}

- (void)__getNotif:(NSNotification *)sender{
    
    NSDictionary *dd=sender.userInfo;
    NSInteger ty=-1;
    id data;
    id obj;
    
    if ([dd objectForKey:@"type"] && [[dd objectForKey:@"type"] isKindOfClass:[NSNumber class]]) {
        ty=[[dd objectForKey:@"type"]integerValue];
    }
    
    data=[dd objectForKey:@"data"];
    obj=[dd objectForKey:@"object"];
    
    [self getNotifType:ty data:data target:obj];
}

- (void)getNotifType:(NSInteger)type data:(id)data target:(id)obj{}

- (void)__removeObserverGlobal{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMARGlobalNotification object:nil];
}
#pragma mark 全局通知  -- end
#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self __removeObserverGlobal];
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


@implementation UIViewController (MARBaseVCEX)

- (BOOL)showNaviBarViewWillAppeal
{
    return [objc_getAssociatedObject(self, @selector(showNaviBarViewWillAppeal)) boolValue];
}

- (void)setShowNaviBarViewWillAppeal:(BOOL)showNaviBarViewWillAppeal
{
    objc_setAssociatedObject(self, @selector(showNaviBarViewWillAppeal), @(showNaviBarViewWillAppeal), OBJC_ASSOCIATION_ASSIGN);
}

@end
