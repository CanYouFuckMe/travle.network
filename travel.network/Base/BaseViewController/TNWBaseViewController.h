//
//  TNWBaseViewController.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNWBaseViewController : UIViewController
@property (nonatomic ,strong) UITableView * tableView ;
@property (nonatomic ,strong) UILabel * titleLable ;
@property (nonatomic ,strong) UIColor * titleBackColor ;
@property (nonatomic ,strong) UIImage * titleBackgroundImage ;
@property (nonatomic ,strong) UIColor * navTintColor ;
@property (nonatomic ,strong) UIView * viewBack;
@property (nonatomic ,strong) UIButton * leftBtn ;
@property (nonatomic ,strong) UIButton * rightBtn ;
@property (nonatomic ,assign) BOOL hidden ;
//创建ViewModel
-(void)setupViewModel ;
-(void)bindViewModel ;
//配置UI
-(void)configUI;
//数据请求
-(void)requestData ;
//设置titleView
-(void)setupNavTitleView ;
//创建TableView
-(void)creatTableViewWithFrame:(CGRect)rect style:(UITableViewStyle)style;
//右侧按钮
-(void)rightAction;
//返回上一页
-(void)backHome;
@end
