//
//  TNWViewController.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWViewController.h"
#import "TNWTabBar.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"

@interface TNWViewController ()<UITabBarControllerDelegate>

@end

@implementation TNWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self creatTabBaritem];
//    [self setCustomTabBar];
    [self setControllers];
    self.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setCustomTabBar {
    TNWTabBar *customTabBar = [[TNWTabBar alloc]init];
//    customTabBar.backgroundImage = [UIImage imageWithColor:HexRGBAColor(0x000000, 0.8)];
    customTabBar.backgroundImage  = [UIImage imageNamed:@""];
//    customTabBar.backgroundColor =red_color;
    customTabBar.titleColor = [UIColor lightGrayColor];
    customTabBar.selectedTitleColor = [UIColor whiteColor];
    [self setValue:customTabBar forKey:@"tabBar"];
}
-(void)creatTabBaritem{
    NSArray *classNameArray = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController",@"FourViewController"];
    NSArray *titleArray = @[@"first",@"sencond",@"third",@"fourth"];
    NSMutableArray *navigationControllerArray = [[NSMutableArray alloc] init];
    for (int i=0; i<classNameArray.count; i++) {
        TNWViewController *viewController = [[NSClassFromString(classNameArray[i]) alloc] init];
        //设置title
        viewController.title = titleArray[i];
        //设置tabbarItem图片
        UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"btn_%@_正常",titleArray[i]]];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"btn_%@_点击",titleArray[i]]];
//        if (IOS7) {
//            viewController.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        }
//        else {
            [viewController.tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
//        }
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navigationControllerArray addObject:navigationController];
    }
    TNWViewController *tabBatController = [[TNWViewController alloc] init];
    tabBatController.viewControllers = classNameArray;
//    self.window.rootViewController = tabBatController;
    //设置UITabBarItem属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:14.0f]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:20/255.0 green:152/255.0 blue:172/255.0 alpha:1], NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:14.0f]} forState:UIControlStateSelected];
    
    tabBatController.viewControllers = navigationControllerArray;
    tabBatController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"item_selected_background.png"];
    tabBatController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
    
}
- (void)setControllers {
    NSArray *controllerConfigs = @[@{@"name" : @"FirstViewController",
                                     @"title" : @"糖果",
                                     @"imageName" : @"tabbar_home",
                                     @"selectedImageName" : @"tabbar_home_select"},
                                   @{@"name" : @"SecondViewController",
                                     @"title" : @"行程",
                                     @"imageName" : @"tabbar_journey",
                                     @"selectedImageName" : @"tabbar_journey_select"},
                                   @{@"name" : @"ThirdViewController",
                                     @"title" : @"兑换",
                                     @"imageName" : @"tabbar_mine",
                                     @"selectedImageName" : @"tabbar_mine_select"},
                                  @{@"name" : @"FourViewController",
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
        addController = [[UINavigationController alloc]initWithRootViewController:childController];
    } else {
        addController = childController;
    }
    
    [self addChildViewController:addController];
}

#pragma mark - TabBarItemClick

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

- (void)customButtonClick:(UIButton *)customButton {
    JALog(@"12231");
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    UINavigationController *selectedNavi = (UINavigationController *)viewController;
    UIViewController *selectedVC = selectedNavi.topViewController;
    if ([selectedVC isMemberOfClass:[SecondViewController class]]) {
//        UserManager *userManager = [UserManager sharedManager];
//        if (userManager.isLogin) {
//            return YES;
//        } else {
//            [JALoginViewController show:^(BOOL success, NSString *errorDes) {
//                if (success) {
//                    self.selectedViewController = selectedNavi;
//                }
//            }];
//            return NO;
//        }
    }
    
    return YES;
}


@end
