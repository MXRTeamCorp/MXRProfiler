//
//  MXRNetFlowViewController.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerNetFlowListViewController.h"
#import "MXRProfilerNetFlowListView.h"
#import "MXRProfilerNetFlowCellView.h"
#import "MXRProfilerInfo.h"
#import "MXRNetFlowInfo.h"
#import "MXRProfilerNavigationViewController.h"

@interface MXRProfilerNetFlowListViewController ()<UITableViewDataSource>{
    MXRProfilerNetFlowListView  *_netFlowView;
}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation MXRProfilerNetFlowListViewController


#pragma mark LifeCircle
-(void)loadView{
    _netFlowView = [MXRProfilerNetFlowListView new];
    _netFlowView.tableView.dataSource = self;
    self.view = _netFlowView;
    
    [_netFlowView.hiddenButton addTarget:self action:@selector(hiddenVC:) forControlEvents:UIControlEventTouchUpInside];
    [_netFlowView.clearButton addTarget:self action:@selector(clearAndReloadData:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:_netFlowView.tableView selector:@selector(reloadData) name:MXRPROFILERNOTIFICATION_HAPPENSTANDSTILL object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Property
- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"hh:mm:ss.SSS";
    }
    return _dateFormatter;
}

- (void)hiddenVC:(id)sender
{
    if ([self.navigationController isKindOfClass:[MXRProfilerNavigationViewController class]]) {
        MXRProfilerNavigationViewController *vc = ((MXRProfilerNavigationViewController *)self.navigationController);
        if ([vc.profilerDelegate respondsToSelector:@selector(presentationDelegateChangePresentationModeToMode:)]) {
            [vc.profilerDelegate presentationDelegateChangePresentationModeToMode:MXRProfilerPresentationMode_SimpleInfo];
        }
    }
    else if ([_delegate respondsToSelector:@selector(presentationDelegateChangePresentationModeToMode:)]) {
        [_delegate presentationDelegateChangePresentationModeToMode:MXRProfilerPresentationMode_SimpleInfo];
    }
}

- (void)clearAndReloadData:(id)sender
{
    [MXRPROFILERINFO.netFlowInfos removeAllObjects];
    [_netFlowView.tableView reloadData];
}



#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MXRPROFILERINFO.netFlowInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    MXRProfilerNetFlowCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MXRProfilerNetFlowCellView alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger index = indexPath.row;
    MXRNetFlowInfo *netFlowInfo = nil;
    if (index < MXRPROFILERINFO.netFlowInfos.count) {
        netFlowInfo = MXRPROFILERINFO.netFlowInfos[index];
    }
    [cell setData:netFlowInfo];
   
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

@end
