//
//  ProViewController.m
//  ConsumerFinance
//
//  Created by Jney on 16/8/11.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "ProViewController.h"

@interface ProViewController ()
<WebBrowserViewDelegate>
@property (nonatomic, strong) WebBrowserView * uiWebView;
@property (nonatomic, strong) ProgressView *uiProgress;
@end

@implementation ProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarBackgroundImage];
    [self setViewBackgroundColor];
    self.title = self.titleName.length!=0?self.titleName:@"";
    [self setBackItemWithIcon:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self prepareForWebView];
    });
    
}

- (void) onBack {

    if ([self.uiWebView canGoBack]){
        [self.uiWebView goBack];
    } else {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:^{}];
        }
    }
}




/** 在请求完成之后加载，防止webview出现黑屏 */

- (void)prepareForWebView {
    
    if (self.uiWebView) {
        [self loadWebViewData];
        return;
    }
    BOOL using = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) ? YES : NO;
    self.uiWebView = [[WebBrowserView alloc] initWithFrame:CGRectMake(0.0,
                                                                      0.0,
                                                                      SCREEN_WIDTH,
                                                                      SCREEN_HEIGHT-STA_NAV_HEIGHT)
                                            usingUIWebView:using];
    self.uiWebView.delegate = self;
    [self.view addSubview:self.uiWebView];
    
//    self.uiProgress = [[ProgressView alloc] initWithFrame:CGRectMake(0.0,
//                                                                     NAVIGATIONBAR_HEIGHT-2.0,
//                                                                     SCREEN_WIDTH,
//                                                                     2.0)];
//    [self.navigationController.navigationBar addSubview:self.uiProgress];
    
    [self loadWebViewData];
    
}

- (void)loadWebViewData{

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.reuqestUrl]];
    [self.uiWebView loadRequest:request];
    
}

#pragma mark - WebBrowserViewDelegate
- (void)webView:(WebBrowserView *)webView didFailLoadWithError:(NSError *)error {
    self.uiProgress.progress = 1.0;
    [self showExceptionView];
    [MBProgressHUD hideHUDForView:self.view];
}

- (void)webViewDidFinishLoad:(WebBrowserView *)webView {
    
    [self hideExceptionView];
    [MBProgressHUD hideHUDForView:self.view];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self setControllerTitle:self.uiWebView.title titleColor:nil];
//    });

}
- (void)webViewDidStartLoad:(WebBrowserView *)webView {
     [MBProgressHUD showMessage:nil toView:self.view];
    
}

- (void)webViewProgress:(WebBrowserView *)webView updateProgress:(CGFloat)progress {
//    self.uiProgress.progress = progress;
}

- (BOOL)webView:(WebBrowserView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)tryAgainAtExceptionView {
    [self loadWebViewData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.uiWebView removeFromSuperview];
    [self.uiProgress removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
