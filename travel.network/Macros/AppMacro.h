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

// 正式
//#define REQUEST_URL @"http://api.qijiwang.cn/app_v1.0/"

// 首次启动判断
#define CM_FIRST_LAUNCHED @"firstLaunch"

// 动态令牌
#define YC_DYNAMIC_TOKEN_NAME @"yc_dynamic_token"

#define YC_DYNAMIC_TOKEN IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(YC_DYNAMIC_TOKEN_NAME)))

#endif /* AppMacro_h */
