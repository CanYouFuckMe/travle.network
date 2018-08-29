//
//  SVNetworkManager.h
//  JedAuto
//
//  Created by Sven on 2017/11/17.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import <AFNetworking.h>

@interface JANetworkManager : AFHTTPSessionManager

+ (instancetype)defaultManager;
+ (instancetype)changeBaseURLToDebug:(BOOL)isDebug;

@end
