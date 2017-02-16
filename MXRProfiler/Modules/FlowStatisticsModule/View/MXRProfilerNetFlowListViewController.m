//
//  MXRNetFlowViewController.m
//  easywayout
//
//  Created by weiqing.tang on 2017/2/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MXRProfilerNetFlowListViewController.h"
#import "MXRProfilerNetFlowListView.h"
#import "MXRProfilerInfo.h"
#import "MXRNetFlowInfo.h"
#import "MXRProfilerNetFlowDetailViewController.h"

@interface MXRProfilerNetFlowListViewController ()<UITableViewDelegate, UITableViewDataSource>{
    MXRProfilerNetFlowListView  *_netFlowView;
}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation MXRProfilerNetFlowListViewController


#pragma mark LifeCircle
-(void)loadView{
    _netFlowView = [MXRProfilerNetFlowListView new];
    _netFlowView.tableView.delegate = self;
    _netFlowView.tableView.dataSource = self;
    self.view = _netFlowView;
    self.view.backgroundColor = [UIColor blackColor];
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
        _dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss.SSS";
    }
    return _dateFormatter;
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXRProfilerNetFlowDetailViewController *netFlowVC =  [MXRProfilerNetFlowDetailViewController new];
    [self.navigationController pushViewController:netFlowVC animated:YES];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MXRPROFILERINFO.netFlowInfos.count;
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
    MXRNetFlowInfo *netFlowInfo = nil;
    if (index < MXRPROFILERINFO.netFlowInfos.count) {
        netFlowInfo = MXRPROFILERINFO.netFlowInfos[index];
    }
    cell.textLabel.text = netFlowInfo.currentVCClassName;
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:netFlowInfo.happendTimeIntervalSince1970]];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

@end
