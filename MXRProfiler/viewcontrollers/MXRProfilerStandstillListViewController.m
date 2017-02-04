//
//  MXRProfilerStandstillListViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/25.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerStandstillListViewController.h"
#import "MXRProfilerMacro.h"
#import "MXRProfilerStandstillListView.h"
#import "MXRProfilerStandstillDetailViewController.h"

@interface MXRProfilerStandstillListViewController () <UITableViewDelegate, UITableViewDataSource>
{
    MXRProfilerStandstillListView *_standstillListView;
}

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation MXRProfilerStandstillListViewController

- (void)loadView
{
    _standstillListView = [MXRProfilerStandstillListView new];
    self.view = _standstillListView;
    
    _standstillListView.tableView.delegate = self;
    _standstillListView.tableView.dataSource = self;
    [_standstillListView.hiddenButton addTarget:self action:@selector(hiddenVC:) forControlEvents:UIControlEventTouchUpInside];
    [_standstillListView.clearButton addTarget:self action:@selector(clearAndReloadData:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:_standstillListView.tableView selector:@selector(reloadData) name:MXRPROFILERNOTIFICATION_HAPPENSTANDSTILL object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:_standstillListView name:MXRPROFILERNOTIFICATION_HAPPENSTANDSTILL object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    }
    return _dateFormatter;
}

- (void)hiddenVC:(id)sender
{
    if ([_delegate respondsToSelector:@selector(presentationDelegateChangePresentationModeToMode:)]) {
        [_delegate presentationDelegateChangePresentationModeToMode:MXRProfilerPresentationMode_SimpleInfo];
    }
}

- (void)clearAndReloadData:(id)sender
{
    [MXRPROFILERINFO.standstaillInfos removeAllObjects];
    [_standstillListView.tableView reloadData];
}

#pragma mark - UITableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MXRPROFILERINFO.standstaillInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:10.f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10.f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger index = indexPath.row;
    MXRProfilerStandstillInfo *standstillInfo = nil;
    if (index < MXRPROFILERINFO.standstaillInfos.count) {
        standstillInfo = MXRPROFILERINFO.standstaillInfos[index];
    }
    cell.textLabel.text = standstillInfo.currentVCClassName;
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:standstillInfo.happendTimeIntervalSince1970]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    MXRProfilerStandstillInfo *standstillInfo = nil;
    if (index < MXRPROFILERINFO.standstaillInfos.count) {
        standstillInfo = MXRPROFILERINFO.standstaillInfos[index];
        MXRProfilerStandstillDetailViewController *standstillDetailVC = [MXRProfilerStandstillDetailViewController new];
        standstillDetailVC.standstillInfo = standstillInfo;
//        [self.navigationController pushViewController:standstillDetailVC animated:YES];
        [self addChildViewController:standstillDetailVC];
        standstillDetailVC.view.frame = self.view.bounds;
        standstillDetailVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self.view addSubview:standstillDetailVC.view];
        [standstillDetailVC didMoveToParentViewController:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
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

@end
