//
//  NetWorkTool.h
//  JedAuto
//
//  Created by Sven on 2017/11/28.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JANetworkRequest.h"

@interface JANetWorkTool : NSObject

+ (void)telephoneLoginWithTelephoneNumber:(NSString *)telephoneNumber password:(NSString *)password success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

//接送服务开通城市
+ (void)getChooseCitySuccess:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
//获取首页banner图
+ (void)getBannerInfoWithSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

//根据城市获取车辆列表
+ (void)getCarsListWithCityID:(NSString *)cityID success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;


@end
