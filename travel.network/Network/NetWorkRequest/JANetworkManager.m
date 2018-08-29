//
//  SVNetworkManager.m
//  JedAuto
//
//  Created by Sven on 2017/11/17.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "JANetworkManager.h"
#define kIsDebugURL @"kIsDebugURL"

@implementation JANetworkManager
static JANetworkManager *_defaultManager = nil;
+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseURL = [self getBaseURL];
        _defaultManager = [[JANetworkManager alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
        [self setManager];
    });
    
    return _defaultManager;
}

+ (void)setManager {
    _defaultManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _defaultManager.requestSerializer.timeoutInterval = 10;
    _defaultManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    _defaultManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"multipart/form-data", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    _defaultManager.securityPolicy.allowInvalidCertificates = YES;
}

+ (instancetype)changeBaseURLToDebug:(BOOL)isDebug {
    _defaultManager = [[JANetworkManager alloc]initWithBaseURL:[NSURL URLWithString:isDebug ? kDebugBaseURL : kReleaseBaseURL]];
    [self saveToUserDefault:isDebug];
    [self setManager];
    return _defaultManager;
}

+ (NSString *)getBaseURL {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:kIsDebugURL]) {
        BOOL isDebugURL = [[defaults valueForKey:kIsDebugURL] boolValue];
        return isDebugURL ? kDebugBaseURL : kReleaseBaseURL;
    }
    NSString *baseURL = nil;
    if (!baseURL) {
#ifdef DEBUG
        baseURL = kDebugBaseURL;
        [self saveToUserDefault:YES];
#else
        baseURL = kReleaseBaseURL;
        [self saveToUserDefault:NO];
#endif
    }
    return baseURL;
}

+ (void)saveToUserDefault:(BOOL)isDebug {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(isDebug) forKey:kIsDebugURL];
    [defaults synchronize];
}


@end
