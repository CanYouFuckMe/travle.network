//
//  UserManager.m
//  SvenFramework_OC
//
//  Created by Sven on 2017/11/21.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "UserManager.h"
#import "JANetWorkTool.h"

#define kUserCacheName @"JAUserCache"
#define kUserModelCache @"JAUserModelCache"

@interface UserManager()

@property (assign ,nonatomic, readwrite) BOOL isLogin;

@end

@implementation UserManager

+ (instancetype)sharedManager {
    static UserManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}


- (void)loginWithThirdType:(JAUserLoginType)type completion:(LoginBlock)completion {
    self.loginType = type;
    switch (type) {
        case JAUserLoginTypeQQ:
            
            break;
        case JAUserLoginTypeWeChat:
            
            break;
            
        default:
            break;
    }
}

- (void)loginWithTelePhone:(NSString *)phoneNumber password:(NSString *)password completion:(LoginBlock)completion {
    [JANetWorkTool telephoneLoginWithTelephoneNumber:phoneNumber password:password success:^(ErrorModel * _Nonnull errorModel, NSArray * _Nullable modelArray) {
        if (errorModel.code == 0) {
            self.currentUserModel = [modelArray firstObject];
            [self saveUserInfo];
            self.isLogin = YES;
            completion(YES, nil);
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLoginStateChange object:@YES];
        } else if (errorModel.code == 1) {
            completion(NO, errorModel.Message);
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLoginStateChange object:@NO];
        }
    } failure:^(NSError * _Nonnull error) {
        completion(NO, @"登录失败");
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLoginStateChange object:@NO];
    }];
}

- (void)saveUserInfo {
//    if (self.currentUserModel) {
//        YYCache *cache = [[YYCache alloc]initWithName:kUserCacheName];
//        NSDictionary *dic = self.currentUserModel.mj_keyValues;
//        [cache setObject:dic forKey:kUserModelCache];
//    }
}

- (BOOL)loadUserInfo {
//    YYCache *cache = [[YYCache alloc]initWithName:kUserCacheName];
//    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:kUserModelCache];
//    if (userDic) {
//        self.currentUserModel = [JAUserModel mj_objectWithKeyValues:userDic];
//        return YES;
//    }
    return NO;
}

- (void)logout:(LoginBlock)completion {
    self.currentUserModel = nil;
    self.isLogin = NO;
//    YYCache *cache = [[YYCache alloc]initWithName:kUserCacheName];
//    [cache removeAllObjectsWithBlock:^{
//        if (completion) {
//            completion(YES,nil);
//        }
//    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLoginStateChange object:@NO];
}

@end
