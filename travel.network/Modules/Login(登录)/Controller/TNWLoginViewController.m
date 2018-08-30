//
//  TNWLoginViewController.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWLoginViewController.h"

@interface TNWLoginViewController ()
@property (strong,nonatomic) UIView*backView;

@end

@implementation TNWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *testview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    testview.backgroundColor = [UIColor redColor];
    [self.view addSubview:testview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
