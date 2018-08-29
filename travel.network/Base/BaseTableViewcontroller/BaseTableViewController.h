//
//  BaseTableViewController.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWBaseViewController.h"

@interface BaseTableViewController : TNWBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat tableViewTopMargin;
@property (assign, nonatomic) CGFloat tableViewBottomMargin;
@property (assign, nonatomic) UITableViewStyle tableViewStyle;
@end
