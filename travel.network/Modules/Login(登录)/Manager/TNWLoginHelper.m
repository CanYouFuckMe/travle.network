//
//  TNWLoginHelper.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWLoginHelper.h"
#import "AppDelegate.h"
#import "TNWLoginModel.h"

static NSString *const JMUserArchiverFileName = @"XJUserArchiverFileName.arch";
static NSString *const JMUserFileName = @"XJUserFileName";
static NSString *const SetInfoName = @"XJSetInfoName";
static NSString *const JMUserInfo = @"XJUserInfo";
static NSString *const JMConfigInfo = @"XJConfigInfoName";
static NSString *const XJUserArchiverAdressFileName = @"XJUserArchiverAdressFileName.arch";

@implementation TNWLoginHelper

+(void)XJLogin{
    AppDelegate *app =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [app enterLoginUI];
}
+(void)enterMainUI{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app enterMainUI];
}
+(nullable HRLoginModel *)saveLoginInfo{
    NSString *path = [self pathForName:JMUserArchiverFileName];
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if ([obj isKindOfClass:[TNWLoginModel class]]) {
        return obj;
    } else {
        return nil;
    }
}
+ (void)saveLoginInfo:(nonnull TNWLoginModel *)model
{
    NSString *path = [self pathForName:JMUserArchiverFileName];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    if (data) {
        BOOL success = [data writeToFile:path atomically:YES];
        if (success) {
            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"HRlogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}
+ (void)removeSavedLoginInfo
{
    NSString *path = [self pathForName:JMUserArchiverFileName];
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (exist) {
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        if (success) {
            [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"HRlogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
    }
}
+ (BOOL)isLogin{
    BOOL login = [[[NSUserDefaults standardUserDefaults]objectForKey:@"HRlogin"] boolValue];
    return login ;
}
//+ (NSString *)cityCode{
//
//    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    return  app.cityCode ;
//}
//+(NSString *)location{
//    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    return  app.location ;
//}
#pragma mark
+ (NSString *)pathForName:(NSString *)name
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [array[0] stringByAppendingPathComponent:name];
}
@end
