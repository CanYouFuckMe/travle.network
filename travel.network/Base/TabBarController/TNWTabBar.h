//
//  TNWTabBar.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/28.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNWTabBar : UITabBar
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIFont *titleFont;
@property (strong, nonatomic) UIColor *selectedTitleColor;
@property (strong, nonatomic) UIFont *selectedTitleFont;
- (void)addCustomButton:(UIButton *)button atIndex:(NSUInteger)index;
@end
