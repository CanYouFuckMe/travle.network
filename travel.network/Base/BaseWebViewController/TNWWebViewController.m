//
//  TNWWebViewController.m
//  travel.network
//
//  Created by design-mac1 on 2018/8/29.
//  Copyright © 2018年 design-mac1. All rights reserved.
//

#import "TNWWebViewController.h"

@interface TNWWebViewController ()
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation TNWWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        self.url = url;
        [self addWebViewWithUrl:self.url];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.webView removeObserverBlocks];
}

- (void)addWebViewWithUrl:(NSString *)url {
    WKWebViewConfiguration *configuartion = [WKWebViewConfiguration new];
    configuartion.userContentController = [WKUserContentController new];
    configuartion.allowsInlineMediaPlayback = YES;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) configuration:configuartion];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]
                                          cachePolicy:NSURLRequestReloadIgnoringCacheData
                                      timeoutInterval:DISPATCH_TIME_FOREVER]];
    
    webView.navigationDelegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    self.progressView.backgroundColor = [UIColor clearColor];
    self.progressView.progressTintColor = [UIColor greenColor];
    self.progressView.trackTintColor = [UIColor whiteColor];
    self.progressView.transform = CGAffineTransformMakeScale(1.0, 2.0);
    [self.view addSubview:self.progressView];
    
    kWeakSelf(self);
    [self.webView addObserverBlockForKeyPath:@"estimatedProgress" block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        kStrongSelf(self);
        float progress = [newVal floatValue];
        if (progress > self.progressView.progress) {
            [self.progressView setProgress:[newVal doubleValue] animated:YES];
        } else {
            self.progressView.progress = progress;
        }
        
        if (progress == 1.0) {
            dispatch_queue_t hudQue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC));
            dispatch_after(time, hudQue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.progressView.hidden = YES;
                });
            });
        } else {
            self.progressView.hidden = NO;
        }
        //        weakSelf.progressView.hidden = progress == 1.0 ? YES : NO;
    }];
    
    self.navigationItem.title = self.webView.title;
    [self.webView addObserverBlockForKeyPath:@"title" block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        kStrongSelf(self);
        self.navigationItem.title = newVal;
    }];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.userInteractionEnabled = NO;
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {}

// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {}

// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


@end
