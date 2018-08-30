//
//  AppMacro.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/28.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h
/**
 *  本类放app相关的宏定义
 */

//内网
#define REQUEST_URL @"https://www.baidu.com"
//开发
#define kDebugBaseURL @"http://192.168.1.158:3003/"
//生产
#define kReleaseBaseURL @"http://192.168.1.158:3003/"

// 正式
//#define REQUEST_URL @"http://api.qijiwang.cn/app_v1.0/"

// 首次启动判断
#define CM_FIRST_LAUNCHED @"firstLaunch"

// 动态令牌
#define YC_DYNAMIC_TOKEN_NAME @"yc_dynamic_token"

#define YC_DYNAMIC_TOKEN IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(YC_DYNAMIC_TOKEN_NAME)))
/* 颜色 */

//主题色
#define kMainColor              ssRGBHex(0x000000)
//默认背景色
#define kViewBackgroundColor    ssRGBHex(0x333333)
//默认黄色
#define kMainYellowColor        ssRGBHex(0xfab13b)
//默认分割线颜色
#define kSeparatorColor         ssRGBHex(0xEEEEEE)
//默认导航栏标题颜色
#define kNavTitleColor          ssRGBHex(0xFFFFFF)
//默认导航栏Item颜色
#define kNavItemColor           ssRGBHex(0xFFFFFF)


#endif /* AppMacro_h */
