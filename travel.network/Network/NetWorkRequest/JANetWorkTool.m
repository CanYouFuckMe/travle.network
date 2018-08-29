//
//  NetWorkTool.m
//  JedAuto
//
//  Created by Sven on 2017/11/28.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "JANetWorkTool.h"

@implementation JANetWorkTool

+ (void)telephoneLoginWithTelephoneNumber:(NSString *)telephoneNumber password:(NSString *)password success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    NSDictionary *paramters = @{ @"account" : telephoneNumber,
                                @"pwd" : password };
    [[JANetworkRequest shared] postRequestWithURLConfig:Tel_Login parameters:paramters success:success failure:failure];
}

//接送服务开通城市
+ (void)getChooseCitySuccess:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    
    [[JANetworkRequest shared] getRequestWithURLConfig:CHOOSECITY parameters:nil success:success failure:failure];
}

//获取首页banner图
+ (void)getBannerInfoWithSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    [[JANetworkRequest shared] getRequestWithURLConfig:Home_Banner parameters:nil success:success failure:failure];
}

//根据城市获取车辆列表
+ (void)getCarsListWithCityID:(NSString *)cityID success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    NSDictionary *paramters = @{ @"city_id" : cityID };
    [[JANetworkRequest shared] getRequestWithURLConfig:Home_Car_List parameters:paramters success:success failure:failure];
    
}

@end
