//
//  TNWLoginHelper.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TNWLoginModel;
@interface TNWLoginHelper : NSObject
//登录操作
+(void)XJLogin;
//进入主页
+(void)enterMainUI;
/**
 获取用户登录信息
 
 @return 登录模型
 */
+(nullable TNWLoginModel *)saveLoginInfo;
/**
 保存用户登录信息
 
 @param model 用户登录信息
 */
+(void)saveLoginInfo:(nonnull TNWLoginModel *)model ;
/**
 删除登录信息
 */
+ (void)removeSavedLoginInfo ;
/**
 是否登录
 */
+ (BOOL)isLogin ;
/**
 城市编码
 */
//+ (NSString * _Nonnull)cityCode;
///**
// 定位经纬度
// */
//+ (NSString * _Nonnull)location;
@end
