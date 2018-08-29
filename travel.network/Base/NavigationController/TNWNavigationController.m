//
//  TNWNavigationController.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWNavigationController.h"
#import "TNWBaseViewController.h"
@interface TNWNavigationController ()<UINavigationControllerDelegate>

@end

@implementation TNWNavigationController

+ (void)initialize {
    [self setupNavBar];
    [self setBarButtonItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

+ (void)setupNavBar {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],
                                            NSForegroundColorAttributeName : kNavTitleColor
                                            }];
    navigationBar.barTintColor = kMainColor;
    navigationBar.tintColor = kNavItemColor;
    [navigationBar setShadowImage:[UIImage new]];
}

+ (void)setBarButtonItem {
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    [barButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16],
                                            NSForegroundColorAttributeName : kNavItemColor
                                            } forState:UIControlStateNormal | UIControlStateHighlighted];
    
    [barButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16],
                                            NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                            } forState:UIControlStateDisabled];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
    //适配iPhoneX: 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[TNWBaseViewController class]]) {
        TNWBaseViewController *vc = (TNWBaseViewController *)viewController;
        if (vc.isNaviBarHidden) {
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}


- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}


@end
