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
@property (strong, nonatomic) NSArray *dataArray;
@property (nonatomic ,assign) BOOL hidden ;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIView *noDataView;

@property (assign, nonatomic) NSInteger pageIndex;
@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) NSInteger pageCount;

@property (assign, nonatomic, getter = isNaviBarHidden) BOOL naviBarHidden;
@property (assign, nonatomic, getter = isBackBtnHidden) BOOL backBtnHidden;
@property (assign, nonatomic, getter = isRefreshHidden) BOOL refreshHidden;

- (void)headerRefreshing;
- (void)footerRefreshing;

- (void)showLoadingView:(NSString *)loadingStr;
- (void)hideLoadingView;

- (void)showNoDataView;
- (void)hideNoDataView;
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
