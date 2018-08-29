//
//  TNWTabBar.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/28.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWTabBar.h"
#define DefaultTitleColor [UIColor lightGrayColor]
#define DefaultTitleFont [UIFont systemFontOfSize:15]
#define DefaultSelectedTitleColor [UIColor blackColor]
#define DefaultSelectedTitleFont [UIFont systemFontOfSize:16]

@interface TNWTabBar()
@property (assign,nonatomic)NSUInteger customButtonIndex;
@property (strong,nonatomic) UIButton *customButton;

@end

@implementation TNWTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)commonInit {
}

- (void)addCustomButton:(UIButton *)customButton atIndex:(NSUInteger)index {
    _customButtonIndex = index;
    _customButton = customButton;
    [self addSubview:customButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BOOL isCustomButtonExist = self.customButton != nil;
    
    NSInteger itemCount = isCustomButtonExist ? self.items.count + 1 : self.items.count;
    
    CGFloat buttonW = self.frame.size.width / itemCount;
    
    CGFloat buttonH = self.frame.size.height;
    if (@available(iOS 11.0, *)) {
        buttonH = self.frame.size.height - (IphoneX ? self.safeAreaInsets.bottom : 0);
    }
    CGFloat buttonY = 0;
    
    int buttonIndex = 0;
    for (UIView *subView in self.subviews) {
        
        if ([NSStringFromClass(subView.class) isEqualToString:@"UITabBarButton"]) {
            CGFloat buttonX = buttonIndex * buttonW;
            if (isCustomButtonExist && buttonIndex >= self.customButtonIndex) {
                buttonX += buttonW;
            }
            subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            buttonIndex++;
        }
        
    }
    
    if (isCustomButtonExist) {
        self.customButton.frame = CGRectMake(0, 0, buttonW, buttonH);
        self.customButton.center = CGPointMake(self.bounds.size.width / 2, buttonH / 2);
    }
    
    for (UITabBarItem *item in self.items) {
        [item setTitleTextAttributes:@{NSFontAttributeName :
                                           self.titleFont ? self.titleFont : DefaultTitleFont,
                                       NSForegroundColorAttributeName : self.titleColor ? self.titleColor :
                                           DefaultTitleColor
                                       } forState:UIControlStateNormal];
        
        [item setTitleTextAttributes:@{NSFontAttributeName :
                                           self.selectedTitleFont ? self.selectedTitleFont :                   DefaultSelectedTitleFont,
                                       NSForegroundColorAttributeName : self.selectedTitleColor ?self.selectedTitleColor : DefaultSelectedTitleColor
                                       } forState:UIControlStateSelected];
    }
    
    
}


@end
