//
//  AppDelegate+AppService.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/28.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

- (void)enterLoginUI;
- (void)enterMainUI;
//监听网络状态
- (void)monitorNetworkStatus;

//分享
- (void)initShare;

//统计
- (void)initStatistics;

//推送
- (void)initPush;

//启动广告
- (void)setADView;

//单例
+ (instancetype)shareAppDelegate;

//当前顶层控制器（包括tabbarController）
- (UIViewController*) getCurrentVC;

//当前顶层视图控制器
- (UIViewController*) getCurrentUIVC;

@end
