//
//  TNWWebViewController.h
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
/**
有进度条的webView
*/
@interface TNWWebViewController : UIViewController<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;

- (instancetype)initWithUrl:(NSString *)url;

@end
