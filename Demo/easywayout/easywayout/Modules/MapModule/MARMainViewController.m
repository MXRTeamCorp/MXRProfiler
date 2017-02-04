//
//  MARMainViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/5.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARMainViewController.h"
#import <objc/runtime.h>
#import "MARReserveParkspacePopView.h"
@interface MARMainViewController ()
{
    BMKLocationService *_locService;
    BMKPoiSearch *_poisearch;
    BMKUserLocation *_lastUserLocation;
}
#pragma mark - IB Property
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

#pragma mark - IB Action
- (IBAction)clickLookforParkspaceAction:(id)sender;
@end
@implementation MARMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locService = [[BMKLocationService alloc] init];
    _poisearch = [[BMKPoiSearch alloc]init];
    [_mapView setZoomLevel:18];
    [_mapView hiddenLoginView];
}

- (void)usuallyUseFunctions
{
    [_mapView setShowMapScaleBar:YES];      // 设定是否显式比例尺
    [_mapView setTrafficEnabled:YES];   // 是否打开路况图层
    [_mapView setShowMapPoi:YES];       // 是否显示底图poi标注
    [_mapView setMapType:BMKMapTypeStandard]; // 设置当前地图类型 BMKMapTypeSatellite 卫星地图
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _poisearch.delegate = nil; // 不用时，置nil
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startFollowing];
    [_mapView setCompassPosition:CGPointMake(10, kScreenHEIGHT - _mapView.compassSize.height - 10)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)simulateOneParkSpaceIfUserLocationValid
{
//    ShowErrorMessage(@"附近找不到停车场，模拟一个停车场", 1.f);
    if (_lastUserLocation) {
        BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = _lastUserLocation.location.coordinate.latitude + 0.001;
        coor.longitude = _lastUserLocation.location.coordinate.longitude - 0.001;
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = @"我的御用停车场";
        [_mapView addAnnotation:pointAnnotation];
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

- (void)startLocation
{
    MARLog(@"进入普通定位状态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;    //   先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone; // 设置定位的状态
    _mapView.showsUserLocation = YES; // 显示定位图层
}

- (void)startFollowing
{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}

- (void)stopLocation
{
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

- (void)searchNearby
{
    if (!_lastUserLocation) {
        ShowSuccessMessage(@"正在获取当前定位，请稍等", 1.f);
        return;
    }
    BMKNearbySearchOption *nearbySearchOption = [[BMKNearbySearchOption alloc] init];
    nearbySearchOption.keyword = @"停车";
    nearbySearchOption.pageIndex = 0;
    nearbySearchOption.pageCapacity = 20;
    nearbySearchOption.location = _lastUserLocation.location.coordinate;
    nearbySearchOption.radius = 5000;
    nearbySearchOption.sortType = BMK_POI_SORT_BY_DISTANCE;
    BOOL flag = [_poisearch poiSearchNearBy:nearbySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}

#pragma mark -
#pragma mark LocationService Delegate start
/**
 *在地图View将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    MARLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    _lastUserLocation = userLocation;
//    MARLog(@"heading is %@", userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    MARLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _lastUserLocation = userLocation;
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    MARLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    MARLog(@"location error : %@", error);
}

#pragma mark LocationService Delegate end
#pragma mark - 

#pragma mark -
#pragma mark Mapview Delegate start
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
#ifdef RESERVEPARKSPACEVIEW_MIDDLE
    MARReserveParkspacePopView *customPaopaoView = [[MARReserveParkspacePopView alloc] init];
    [customPaopaoView setParkspaceName:[(id<BMKAnnotation>)annotation title]];
    customPaopaoView.frame = CGRectMake(0, 0, 270, 140);
    annotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:customPaopaoView];
#endif
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}


- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    MARLog(@"选中了一个annotation views");
    [self startLocation];   // 进入普通状态
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
    self.parkspaceName = [(id<BMKAnnotation>)view.annotation title];
    [self hiddenParkSpaceView:NO animated:YES];
#ifdef RESERVEPARKSPACEVIEW_MIDDLE
    [mapView setCenterCoordinate:[(id<BMKAnnotation>)view.annotation coordinate] animated:YES];
#endif
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    MARLog(@"当取消选中一个annotation views");
    [self hiddenParkSpaceViewwWhenShowWithAnimated:YES];
}



- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi
{
    MARLog(@"点中底图标注");
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate
{
    MARLog(@"双击地图");
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
}


- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    MARLog(@"长按地图");
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    MARLog(@"点中底图空白处");
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
}

- (void)mapView:(BMKMapView *)mapView onClickedBMKOverlayView:(BMKOverlayView *)overlayView
{
    MARLog(@"点中覆盖物");
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
}

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    MARLog(@"点击了annotation view弹出的泡泡");
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
}

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    MARLog(@"地图区域即将改变");
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    MARLog(@"地图区域改变");
    [self hiddenPopMenuViewWhenShowWithAnimated:YES];
}

#pragma mark Mapview Delegate end
#pragma mark -

#pragma mark -
#pragma mark PoiSearch Delegate start

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
        if (poiResult.poiInfoList.count == 0) {
            [self simulateOneParkSpaceIfUserLocationValid];
        }
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
        [self simulateOneParkSpaceIfUserLocationValid];
    } else {
        // 各种情况的判断。。。
        [self simulateOneParkSpaceIfUserLocationValid];
    }

}

#pragma mark PoiSearch Delegate end
#pragma mark -

#pragma mark - hanle notification
- (void)getNotifType:(NSInteger)type data:(id)data target:(id)obj
{
    [super getNotifType:type data:data target:obj];
    if (type == kNOTIFICATION_reverseParkspaceSuccess) {
        [self hiddenParkSpaceView:YES animated:YES];
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
    }
}

- (void)dealloc
{
    if (_mapView) {
        _mapView = nil;
    }
}

- (IBAction)clickLookforParkspaceAction:(id)sender {
    [self searchNearby];
}

@end
