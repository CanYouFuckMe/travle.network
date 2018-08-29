//
//  TNWBaseViewController.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWBaseViewController.h"

@interface TNWBaseViewController ()
@property (nonatomic ,strong) UIImageView * imageView;
@end

@implementation TNWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavTitleView];
    [self setupViewModel];
    [self configUI];
    [self bindViewModel];
    [self requestData];
 
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self isKindOfClass:NSClassFromString(@"MMMainViewController")]||[self isKindOfClass:NSClassFromString(@"MMNearbyViewController")]||[self isKindOfClass:NSClassFromString(@"MMCircleViewController")]||[self isKindOfClass:NSClassFromString(@"MMMyselfViewController")]||[self isKindOfClass:NSClassFromString(@"PersonViewController")]) {
        self.tabBarController.tabBar.hidden = NO;
        [self.leftBtn setImage:nil forState:UIControlStateNormal];
    }else{
        self.tabBarController.tabBar.hidden = YES;
        [self.leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [[YYWebImageManager sharedManager].cache.memoryCache removeAllObjects];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 创建自定义导航栏
-(void)setupNavTitleView{
    UIView * viewBack = [UIView new];
    viewBack.backgroundColor = MM_MAIN_COLOR;
    
    UIImageView * imageView = [UIImageView new];
    
    UIButton * left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    [left setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [left setImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
    
    UIButton * right = [UIButton buttonWithType:UIButtonTypeCustom];
    [right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    right.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [right setContentEdgeInsets:UIEdgeInsetsMake(0, TopHeight, 0, 10)];
    //    [right setImage:[UIImage imageNamed:@"ditu_icon_houtui"] forState:UIControlStateNormal];
    right.hidden = YES ;
    
    UILabel * lab = [UILabel new];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:17.f];
    
    [self.view addSubview:viewBack];
    [viewBack addSubview:imageView];
    [viewBack addSubview:left];
    [viewBack addSubview:lab];
    [viewBack addSubview:right];
    
    [viewBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVH);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.mas_equalTo(0);
    }];
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(TopHeight).priority(MASLayoutPriorityDefaultHigh);
    }];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(TopHeight).priority(MASLayoutPriorityDefaultHigh);
        make.bottom.mas_equalTo(0);
    }];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-6);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(TopHeight).priority(MASLayoutPriorityDefaultHigh);
    }];
    
    _viewBack = viewBack ;
    _imageView = imageView ;
    _leftBtn = left ;
    _titleLable = lab;
    _rightBtn = right ;
    [self.view layoutIfNeeded];
}
-(void)backHome{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(void)rightAction{}
#pragma mark - 创建tableView
-(void)creatTableViewWithFrame:(CGRect)rect style:(UITableViewStyle)style{
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:rect style:style];
    tableView.estimatedSectionFooterHeight  = 0 ;
    tableView.estimatedSectionHeaderHeight = 0 ;
    self.tableView = tableView ;
    
    [self.view addSubview:self.tableView];
    if(@available(iOS 11, *)) {
        self.tableView.tableFooterView = [UIView new];
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    __weak typeof(self) _self = self ;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(_self.viewBack.mas_bottom).offset(0).priority(MASLayoutPriorityDefaultHigh);
    }];
    [self.view bringSubviewToFront:self.viewBack];
    [self.view layoutIfNeeded];
    
    
}
#pragma mark - set
-(void)setTitleBackColor:(UIColor *)titleBackColor{
    self.viewBack.backgroundColor = titleBackColor ;
}
-(void)setTitleBackgroundImage:(UIImage *)titleBackgroundImage{
    self.imageView.image = titleBackgroundImage ;
}
-(void)setNavTintColor:(UIColor *)navTintColor{
    [self.leftBtn setTitleColor:navTintColor forState:UIControlStateNormal];
    self.leftBtn.tintColor = navTintColor ;
}
-(void)setHidden:(BOOL)hidden{
    [self.viewBack mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(hidden?0:NAVH);
    }];
    [self.view layoutIfNeeded];
}
-(void)setTitle:(NSString *)title{
    self.titleLable.text = title ;
}
#pragma mark - 一些公共的方法
-(void)requestData{}
-(void)setupViewModel {}
-(void)configUI{self.view.backgroundColor = [UIColor whiteColor];}
-(void)bindViewModel{}


@end
