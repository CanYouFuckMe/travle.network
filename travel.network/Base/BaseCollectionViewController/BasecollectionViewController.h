//
//  BasecollectionViewController.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWBaseViewController.h"

@interface BasecollectionViewController : TNWBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (assign, nonatomic) CGFloat collectionViewTopMargin;
@property (assign, nonatomic) CGFloat collectionViewBottomMargin;

@end
