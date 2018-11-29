//
//  HXWevbViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXWevbViewController.h"
#import <WebKit/WebKit.h>

@interface HXWevbViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong) WKWebView *webView;
@end

@implementation HXWevbViewController
-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view endEditing:YES];
    [self editNavi];
    
    [self.view addSubview:self.webView];
    
    [MBProgressHUD showMessage:nil toView:self.view];
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"活动";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = HXRGB(255, 255, 255);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UIWebViewDelegate
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [MBProgressHUD hideHUDForView:self.view];
//}
//
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [MBProgressHUD hideHUDForView:self.view];
//}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
//    NSLog(@"XXXXXX didFinishNavigation");
    [MBProgressHUD hideHUDForView:self.view];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    NSLog(@"++++++ didFailNavigation");
    [MBProgressHUD hideHUDForView:self.view];
}

#pragma mark - setter and getter
- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _webView.backgroundColor = kUIColorFromRGB(0xfafafa);
//        _webView.delegate = self;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.htmlStr]]];
    }
    return _webView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
