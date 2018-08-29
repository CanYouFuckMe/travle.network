//
//  TNWViewController.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWViewController.h"
#import "TNWTabBar.h"

@interface TNWViewController ()<UITabBarControllerDelegate>

@end

@implementation TNWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTabBar];
    [self setControllers];
    self.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setCustomTabBar {
    TNWTabBar *customTabBar = [[TNWTabBar alloc]init];
    customTabBar.backgroundImage = [UIImage imageWithColor:HexRGBAColor(0x000000, 0.8)];
    customTabBar.titleColor = [UIColor lightGrayColor];
    customTabBar.selectedTitleColor = [UIColor whiteColor];
    [self setValue:customTabBar forKey:@"tabBar"];
}

- (void)setControllers {
    NSArray *controllerConfigs = @[@{@"name" : @"JAHomeViewController",
                                     @"title" : @"",
                                     @"imageName" : @"tabbar_home",
                                     @"selectedImageName" : @"tabbar_home_select"},
                                   @{@"name" : @"JAJourneyController",
                                     @"title" : @"行程",
                                     @"imageName" : @"tabbar_journey",
                                     @"selectedImageName" : @"tabbar_journey_select"},
                                   @{@"name" : @"JAMineViewController",
                                     @"title" : @"我的",
                                     @"imageName" : @"tabbar_mine",
                                     @"selectedImageName" : @"tabbar_mine_select"}];
    
    [controllerConfigs enumerateObjectsUsingBlock:^(NSDictionary *controllerConfig, NSUInteger idx, BOOL * _Nonnull stop) {
        Class controllerClass = NSClassFromString(controllerConfig[@"name"]);
        [self addControllerWithNavigation:[controllerClass new]
                                    title:controllerConfig[@"title"]
                                    image:controllerConfig[@"imageName"]
                            selectedImage:controllerConfig[@"selectedImageName"]];
    }];
}

- (void)addControllerNoNavigation:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    [self addController:childController title:title image:image selectedImage:selectedImage haveNavigation:NO];
}

- (void)addControllerWithNavigation:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    [self addController:childController title:title image:image selectedImage:selectedImage haveNavigation:YES];
}

- (void)addController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage haveNavigation:(BOOL)haveNavigation {
    
    childController.navigationItem.title = title;
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);
    if (image.length > 0) {
        childController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    UIViewController *addController = nil;
    if (haveNavigation) {
        addController = [[JANavigationContoller alloc]initWithRootViewController:childController];
    } else {
        addController = childController;
    }
    
    [self addChildViewController:addController];
}

#pragma mark - TabBarItemClick

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

- (void)customButtonClick:(UIButton *)customButton {
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    UINavigationController *selectedNavi = (UINavigationController *)viewController;
    UIViewController *selectedVC = selectedNavi.topViewController;
    if ([selectedVC isMemberOfClass:[JAJourneyController class]]) {
        UserManager *userManager = [UserManager sharedManager];
        if (userManager.isLogin) {
            return YES;
        } else {
            [JALoginViewController show:^(BOOL success, NSString *errorDes) {
                if (success) {
                    self.selectedViewController = selectedNavi;
                }
            }];
            return NO;
        }
    }
    
    return YES;
}


@end
