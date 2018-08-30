//
//  APIMacro.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/28.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#ifndef APIMacro_h
#define APIMacro_h
/**
 *  本文件可放请求API 拼接的路径
 */

#define URLPath @"urlPath"
#define ShowLoading @"showLoading"
#define LoadingString @"loadingString"
#define NoDataString @"noDataString"

#define Tel_Login @{URLPath : @"action/login", ShowLoading : @"1", LoadingString : @"正在登录", NoDataString : @""}
//首页banner图
#define Home_Banner @{URLPath : @"banner/list", ShowLoading : @"0", LoadingString : @"", NoDataString : @""}
//接送服务车辆列表
#define Home_Car_List @{URLPath : @"delivery/service/car/list", ShowLoading : @"0", LoadingString : @"", NoDataString : @""}


#define CHOOSECITY @{URLPath : @"delivery/service/city/list", ShowLoading : @"0", LoadingString : @"", NoDataString : @""}
#endif /* APIMacro_h */
