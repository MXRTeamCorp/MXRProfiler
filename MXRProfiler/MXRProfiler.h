//
//  MXRProfiler.h
//  easywayout
//
//  Created by Martin.Liu on 2017/2/4.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#ifndef MXRProfiler_h
#define MXRProfiler_h

#import "MXRProfilerTool.h"                     // 入口
#import "MXRProfilerMacro.h"                    // 全局宏
#import "MXRProfilerNotification.h"             // 通知名称

// 主窗口与容器相关
#import "MXRProfilerWindow.h"                           // 检测主窗口
#import "MXRProfilerContainerViewController.h"          // 视图控制器主容器
#import "MXRProfilerMovableViewController.h"            // 检测控制视图控制器代理，控制
#import "MXRProfilerPresentationModeDelegate.h"         // 检测模式转换的代理
#import "MXRProfilerWindowTouchesHandling.h"            // 用来计算是否响应用户与检测窗体的行为

// unity
#import "MXRWeakProxy.h"                                // 弱引用
#import "NSObject+MXRSwizz.h"                           // 方法挂钩
#import "MXRProfilerBaseDBModel.h"                      // 数据库model
#import "NSObject+MXRBase.h"                            // 基类的分类
#import "UIDevice+MXRProfiler.h"                        // 设备的分类
#import "MXRDebug.h"                                    // debug相关

// baseModules
#import "MXRProfilerInfo.h"                             // 缓存相关数据
#import "UIViewController+MXRProfier.h"                 // 实时获取当前窗口类名
#import "MXRProfilerBaseViewController.h"               // 视图控制器基类
#import "MXRProfilerBaseViewController.h"               // 导航视图控制器基类

// SimpleInfoModule
#import "MXRFPSObserver.h"                              // FPS观察者
#import "MXRProfilerUtils.h"                            // 提供当前内存使用、cup使用、流量使用的方法
#import "MXRProfilerSimpleInfoViewController.h"         // 抓取手机基本信息的视图控制器

// StandstillModeule
#import "MXRProfilerStandstillInfo.h"                   // 卡顿信息model
#import "MXRCallStack.h"                                // 函数调用栈
#import "MXRMonitorRunloop.h"                           // 检测卡顿
#import "MXRProfilerStandstillDetailView.h"             // 卡顿详情视图
#import "MXRProfilerStandstillDetailViewController.h"   // 卡顿详情视图控制器
#import "MXRProfilerStandstillListView.h"               // 卡顿列表视图
#import "MXRProfilerStandstillListViewController.h"     // 卡顿列表视图控制器

#endif /* MXRProfiler_h */
