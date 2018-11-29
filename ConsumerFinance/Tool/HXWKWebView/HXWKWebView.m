//
//  HXWKWebView.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXWKWebView.h"
#import "WKWebViewJavascriptBridge.h"

#import <WebKit/WebKit.h>
#import <NYTPhotoViewer/NYTPhoto.h>

static HXWKWebView *_wkWebViewOne = nil;
static HXWKWebView *_wkWebViewOther = nil;

@interface HXWKWebView()<WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate, NSCopying>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKUserScript *userScript;

@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;

@end

@implementation HXWKWebView

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _wkWebViewOne = [[HXWKWebView alloc] init];
        _wkWebViewOther = [[HXWKWebView alloc] init];
    });
    return _wkWebViewOne;
}

- (instancetype)init {
    if (self == [super init]) {
        [self setUpProgressView];
        [self setUpWebView];
        
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
       
        [self registerHandler];
    }
    return self;
}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)registerHandler {
    [self.bridge registerHandler:@"Native_Target_CallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js调oc里面的方法，获取的值: %@", data);
        if (self.delegate && [self.delegate respondsToSelector:@selector(targetToViewController:withData:block:)]) {
            [self.delegate targetToViewController:self withData:data block:responseCallback];
        }
    }];
    
    // 暂时不需要这个方法
//    [self.bridge registerHandler:@"OC_Scroll_ContentOffset" handler:^(id data, WVJBResponseCallback responseCallback) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(scrollOffsetY:withData:block:)]) {
//            [self.delegate scrollOffsetY:self withData:data block:responseCallback];
//        }
//    }];
    
    [self.bridge registerHandler:@"Native_SetId" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dic = @{@"userUuid":userUuid,@"authorization":[AppManager manager].hxUserInfo.token?:@""};
        responseCallback(dic.mj_JSONString);
    }];
    
    [self.bridge registerHandler:@"Native_Call_Phone" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",DefineText_Hotline];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    
    [self.bridge registerHandler:@"Native_isLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
        BOOL isLogin = [AppManager manager].isOnline?true:false;
        NSDictionary *dic = @{@"isLogin":@(isLogin)};
        responseCallback(dic.mj_JSONString);
    }];
}

- (WKUserScript *)userScript {
    if (!_userScript) {
        static  NSString * const jsGetImages =
        @"function getImages(){\
        var objs = document.getElementsByTagName(\"img\");\
        var imgScr = '';\
        for(var i=0;i<objs.length;i++){\
        imgScr = imgScr + objs[i].src + '+';\
        };\
        return imgScr;\
        };function registerImageClickAction(){\
        var imgs=document.getElementsByTagName('img');\
        var length=imgs.length;\
        for(var i=0;i<length;i++){\
        img=imgs[i];\
        img.onclick=function(){\
        window.location.href='image-preview:'+this.src}\
        }\
        }";
        _userScript = [[WKUserScript alloc] initWithSource:jsGetImages injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    }
    return _userScript;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        self.progressView.progressTintColor = [UIColor redColor];
        self.progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] init];
        _wkWebView.scrollView.bounces = false;
//        [_wkWebView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
//        [_wkWebView.configuration.userContentController addUserScript:self.userScript];
    }
    return _wkWebView;
}

- (void)setUpProgressView {
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(2);
    }];
}

- (void)setUpWebView {
    [self addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [self.bridge setWebViewDelegate:self];
    self.wkWebView.UIDelegate = self;
    
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [self.delegate webView:webView runJavaScriptConfirmPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.progress = 0.0;
    
//    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];[formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
//    NSString*dateTime = [formatter stringFromDate:[NSDate date]];
//    NSLog(@"开始时间===%@",dateTime);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.absoluteString hasPrefix:@"alipay://"]) {
        NSString *payUrl = navigationAction.request.URL.absoluteString;
        if (SYSTEM_VERSION_LESS_THAN(@"10")) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:payUrl]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:payUrl] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }
    
    // TODO: 获取点击的图片, 暂时通过 Native_Show_Big_Picture 获取图片
//    if ([navigationAction.request.URL.scheme isEqualToString:@"image-preview"]) {
//        NSString *URLpath = [navigationAction.request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
//        NSString *dsd = @"";
//    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [self.delegate webView:webView didFinishNavigation:navigation];
    }
    self.progressView.hidden = YES;
    
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];

//    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];[formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
//    NSString*dateTime = [formatter stringFromDate:[NSDate date]];
//    NSLog(@"结束时间===%@",dateTime);
    
    
    //TODO: 获取图片数组 暂时通过 Native_Show_Big_Picture 获取图片
//    [webView evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSMutableArray *imgSrcArray = [NSMutableArray arrayWithArray:[result componentsSeparatedByString:@"+"]];
//        if (imgSrcArray.count >= 2) {
//            [imgSrcArray removeLastObject];
//        }
//    }];
//    
//    [webView evaluateJavaScript:@"registerImageClickAction();" completionHandler:^(id _Nullable result, NSError * _Nullable error) {}];
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
    }
}

#pragma mark - Public Methods

- (void)reload {
    [self.wkWebView reloadFromOrigin];
}

- (WKNavigation *)loadRequest:(NSURLRequest *)request {
    return [self.wkWebView loadRequest:request];
}

- (WKNavigation *)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
    return [self.wkWebView loadHTMLString:string baseURL:baseURL];
}

-(void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler {
    [self.bridge registerHandler:handlerName handler:handler];
}

- (void)removeHandler:(NSString *)handlerName {
    [self.bridge removeHandler:handlerName];
}

- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback {
    [self.bridge callHandler:handlerName data:data responseCallback:responseCallback];
}

#pragma mark - Private Methods

- (id)copyWithZone:(NSZone *)zone {
    return [[HXWKWebView allocWithZone:zone] init];
}

@end
