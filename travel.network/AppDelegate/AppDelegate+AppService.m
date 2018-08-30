//
//  AppDelegate+AppService.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/28.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "TNWLoginHelper.h"
#import "TNWLoginViewController.h"
#import "TNWViewController.h"
#import <AFNetworking.h>

@implementation AppDelegate (AppService)

-(void)enterLoginUI{
    if ([TNWLoginHelper isLogin]) {
        [TNWLoginHelper removeSavedLoginInfo];
        //        移除认证步骤
    }
    if ([self.window.rootViewController isKindOfClass:[TNWLoginViewController class]]) {return ;}
    
    TNWLoginViewController * vc = [[TNWLoginViewController alloc] init];
    //    XJBaseNavgationController *navi = [[XJBaseNavgationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = vc;
    //    [self.window addSubview:vc.view];
    [self.window makeKeyAndVisible];
}
-(void)enterMainUI{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    TNWViewController  *tabBarVC= [[TNWViewController alloc]init];
    self.window.rootViewController = tabBarVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}
- (void)monitorNetworkStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                JALog(@"未知网络");
                break;
                case AFNetworkReachabilityStatusNotReachable:
                JALog(@"没有网络");
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                JALog(@"移动网络");
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                JALog(@"WIFI网络");
                break;
                
            default:
                break;
        }
    }];
}

- (void)initShare {
    
}

- (void)initStatistics {
    
}

- (void)initPush {
    
}

- (void)setADView {
    
}

+ (instancetype)shareAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    result = nextResponder;
    else
    result = window.rootViewController;
    
    return result;
}

- (UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
    if ([superVC isKindOfClass:[UINavigationController class]]) {
        
        return ((UINavigationController*)superVC).viewControllers.lastObject;
    }
    return superVC;
}
@end
