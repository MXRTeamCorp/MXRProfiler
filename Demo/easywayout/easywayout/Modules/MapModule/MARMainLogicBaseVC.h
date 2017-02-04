//
//  MARMainLogicBaseVC.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/8.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARBaseViewController.h"

/**
    在中间的泡泡视图优先级高于底部的
    如果都没有定义则没有预约的泡泡视图
 */
#define RESERVEPARKSPACEVIEW_MIDDLE         // 预约车位的泡泡视图在地图中间
//#define RESERVEPARKSPACEVIEW_BOTTOM         // 预约车位的泡泡视图在地图底部
/**
 1.简介
    主页的第一层控制器，用来负责页面的逻辑控制
 2.UI
    头部抽屉式目录，显示了个人信息以及跳转的按钮
 3.接口
 
 */
@interface MARMainLogicBaseVC : MARBaseViewController

@property (nonatomic, copy) NSString *parkspaceName;

//- (void)hiddenPopmenuView:(BOOL)hidden;
- (void)hiddenPopmenuView:(BOOL)hidden animated:(BOOL)animated;
- (void)hiddenPopMenuViewWhenShow;
- (void)hiddenPopMenuViewWhenShowWithAnimated:(BOOL)animated;

//- (void)hiddenParkSpaceView:(BOOL)hidden;
- (void)hiddenParkSpaceView:(BOOL)hidden animated:(BOOL)animated;
- (void)hiddenParkSpaceViewWhenShow;
- (void)hiddenParkSpaceViewwWhenShowWithAnimated:(BOOL)animated;
@end
