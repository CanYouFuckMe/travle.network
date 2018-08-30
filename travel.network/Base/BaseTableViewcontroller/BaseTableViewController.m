//
//  BaseTableViewController.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "BaseTableViewController.h"
#import <MJRefresh.h>
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (instancetype)init {
    if (self = [super init]) {
        _tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    self.dataArray = @[];
    
}

- (void)setRefreshHidden:(BOOL)refreshHidden {
    [super setRefreshHidden:refreshHidden];
    if (self.isRefreshHidden) {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }
}

- (void)setTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:self.tableViewStyle];
    self.tableView = tableView;
    tableView.backgroundColor = white_color;
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] init];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    tableView.mj_footer = footer;
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setTableViewTopMargin:(CGFloat)tableViewTopMargin {
    _tableViewTopMargin = tableViewTopMargin;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(tableViewTopMargin);
    }];
    
}

- (void)setTableViewBottomMargin:(CGFloat)tableViewBottomMargin {
    _tableViewBottomMargin = tableViewBottomMargin;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-tableViewBottomMargin);
    }];
}


- (void)showNoDataView {
    [self.tableView addSubview:self.noDataView];
    self.noDataView.frame = self.tableView.frame;
}

- (void)setDataArray:(NSArray *)dataArray {
    [super setDataArray:dataArray];
    MJRefreshAutoStateFooter *footer = (MJRefreshAutoStateFooter *)self.tableView.mj_footer;
    if (self.pageCount <= self.pageIndex + 1 ) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        footer.hidden = YES;
    }
    else {
        [self.tableView.mj_footer endRefreshing];
        footer.hidden = NO;
    }
    [self.tableView reloadData];
}

- (void)headerRefresh {
    self.pageIndex = 0;
    [self headerRefreshing];
}

- (void)footerRefresh {
    self.pageIndex++;
    [self footerRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
