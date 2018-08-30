//
//  JAUserManager.h
//  SvenFramework_OC
//
//  Created by Sven on 2017/11/21.
//  Copyright © 2017年 Sven. All rights reserved.
//

/*
 用户管理类，处理登录等动作
 */
#import <Foundation/Foundation.h>
#import "TNWLoginModel.h"


typedef NS_ENUM(NSInteger, JAUserLoginType) {
    JAUserLoginTypeUnKnow = 0,//未知
    JAUserLoginTypeWeChat,//微信登录
    JAUserLoginTypeQQ,///QQ登录
    JAUserLoginTypeTelephone,///手机号登录
};

typedef void(^LoginBlock)(BOOL success, NSString *errorDes);

@interface UserManager : NSObject

@property (assign, nonatomic) JAUserLoginType loginType;
@property (strong, nonatomic) TNWLoginModel *currentUserModel;
@property (assign, nonatomic, readonly) BOOL isLogin;

+ (instancetype)sharedManager;

//登录
- (void)loginWithThirdType:(JAUserLoginType)type completion:(LoginBlock)completion;
- (void)loginWithTelePhone:(NSString *)phoneNumber password:(NSString *)password completion:(LoginBlock)completion;
//登出
- (void)logout:(LoginBlock)completion;
 

@end
