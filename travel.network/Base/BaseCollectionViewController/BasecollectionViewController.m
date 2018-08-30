//
//  BasecollectionViewController.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "BasecollectionViewController.h"
#import <MJRefresh.h>
@interface BasecollectionViewController ()

@end

@implementation BasecollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCollectionView];
    self.dataArray = @[];
}

- (void)setRefreshHidden:(BOOL)refreshHidden {
    [super setRefreshHidden:refreshHidden];
    if (self.isRefreshHidden) {
        self.collectionView.mj_header = nil;
        self.collectionView.mj_footer = nil;
    }
}

- (void)setCollectionView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
    self.collectionView = collectionView;
    collectionView.backgroundColor = white_color;
    collectionView.delegate = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    collectionView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    collectionView.mj_footer = footer;
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setCollectionViewTopMargin:(CGFloat)collectionViewTopMargin {
    _collectionViewTopMargin = collectionViewTopMargin;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(collectionViewTopMargin);
    }];
}

- (void)setCollectionViewBottomMargin:(CGFloat)collectionViewBottomMargin {
    _collectionViewBottomMargin = collectionViewBottomMargin;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-collectionViewBottomMargin);
    }];
}

- (void)showNoDataView {
    [self.collectionView addSubview:self.noDataView];
    self.noDataView.frame = self.collectionView.frame;
}

- (void)setDataArray:(NSArray *)dataArray {
    [super setDataArray:dataArray];
    MJRefreshAutoStateFooter *footer = (MJRefreshAutoStateFooter *)self.collectionView.mj_footer;
    if (self.pageCount <= self.pageIndex + 1 ) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        footer.hidden = YES;
    }
    else {
        [self.collectionView.mj_footer endRefreshing];
        footer.hidden = NO;
    }
    [self.collectionView reloadData];
}

- (void)headerRefresh {
    self.pageIndex = 0;
    [self headerRefreshing];
}

- (void)footerRefresh {
    self.pageIndex++;
    [self footerRefreshing];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    return cell;
}

@end
