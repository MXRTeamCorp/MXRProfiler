//
//  MARMainViewController.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/5.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARBaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "MARMainLogicBaseVC.h"
@interface MARMainViewController : MARMainLogicBaseVC <BMKMapViewDelegate, BMKLocationServiceDelegate, BMKPoiSearchDelegate>

@end
