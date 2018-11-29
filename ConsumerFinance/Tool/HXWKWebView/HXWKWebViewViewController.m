//
//  HXWebViewViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXWKWebViewViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "HXAlertViewController.h"
#import "AddressPickView.h"
#import "UINavigationBar+Category.h"
#import "HXWKWebView.h"
#import "HXScoreProductDetailViewController.h"
#import "HXShoppingCartViewController.h"
#import "HXImagePhoto.h"

#import <WebKit/WebKit.h>
#import <NYTPhotoViewer/NYTPhoto.h>
#import <NYTPhotoViewer/NYTPhotosViewController.h>

@interface HXWKWebViewViewController ()

@property (nonatomic, strong, readwrite) HXWKWebView *wkWebView;
@property (nonatomic, strong) HXWKWebView *nextWkWebView;
@property (nonatomic, strong) HXWKWebView *productWebView;

@end

@implementation HXWKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setUpWKWebView];
    [self setUpNavigation];
    
    NSURL *rl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%f",self.url,[[NSDate date] timeIntervalSince1970] * 1000]];
    [self loadExamplePage:self.wkWebView fragment:[rl fragment]];
    
    // 预加载
    self.nextWkWebView = [[HXWKWebView shareInstance] copy];
    self.productWebView = [[HXWKWebView shareInstance] copy];
}

- (void)loadExamplePage:(HXWKWebView*)webView fragment:(NSString *)fragment {
//    NSLog(@"4444444444");
    NSString *tempPath = NSTemporaryDirectory();
    NSString *thePath = [NSString stringWithFormat:@"%@/scoreH5/",tempPath];
    
    NSString* htmlPath = [thePath stringByAppendingString:@"index.html"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:htmlPath] || !fragment || SYSTEM_VERSION_LESS_THAN(@"9.0")) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
//        NSLog(@"webView 调用了网络请求");
        return;
    }
    
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    
    baseURL =[NSURL URLWithString:[NSString stringWithFormat:@"#%@",fragment] relativeToURL:baseURL];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavigationBarBackgroundImage];
    [self hiddenNavgationBarLine:NO];
    [self registerHandler];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setNavigationBarBackgroundImage];
}

- (HXWKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[HXWKWebView shareInstance] copy];
        _wkWebView.delegate = self;
    }
    return _wkWebView;
}

- (void)setUpWKWebView {
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}

- (void)registerHandler {
    
}

#pragma mark - HXWKWebViewDelegate

- (void)targetToViewController:(HXWKWebView *)hxWKWebView withData:(id)data block:(WVJBResponseCallback)responseCallback {
    NSString *targetType = [data objectForKey:@"targetType"];
    NSString *title = [data objectForKey:@"title"];
    NSString *url = [data objectForKey:@"url"];
    
    if ([targetType isEqualToString:@"dismiss"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([targetType isEqualToString:@"productDetail"]) {
        // 在打开之前，清掉上一个页面的浏览痕迹
        HXScoreProductDetailViewController *controller = [[HXScoreProductDetailViewController alloc] init];
        controller.title = title;
        controller.url = [NSString stringWithFormat:@"%@/%@",url,K_CURRENT_TIMESTAMP];
        controller.isTransparente = NO;
        controller.hidesBottomBarWhenPushed = YES;
        controller.wkWebView = self.productWebView;
        controller.wkWebView.delegate = controller;
        [controller.view addSubview:self.productWebView];
        
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if ([targetType isEqualToString:@"shopCart"]) {
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[HXShoppingCartViewController class]]) {
                if ([self.webShopDelegate respondsToSelector:@selector(refreshShopCar)]) {
                    [self.webShopDelegate refreshShopCar];
                }
                [self.navigationController popToViewController:temp animated:YES];
                return ;
            }
        }
        HXShoppingCartViewController *controller = [[HXShoppingCartViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if ([targetType isEqualToString:@"banner"]) {
        if (!([url hasPrefix:@"https://"] || [url hasPrefix:@"http://"])) {
            url = [NSString stringWithFormat:@"https://%@",url];
        }
    }
    
    if ([targetType isEqualToString:@"login"]) {
//        if ([AppManager manager].isOnline) {
//            return;
//        }

        [[AppManager manager] signOutProgressHandler:nil userInfo:nil];
        [self isSign];
        return;
    }
    
    // 在打开之前，清掉上一个页面的浏览痕迹
    [self.nextWkWebView callHandler:@"JS_Destroy" data:@{} responseCallback:^(id responseData) {
        NSLog(@"JS_Destroy :%@",responseData);
    }];
    HXWKWebViewViewController *controller = [[HXWKWebViewViewController alloc] init];
    controller.webShopDelegate = self.webShopDelegate;
    controller.title = title;
    controller.url = url;
    controller.isTransparente = NO;
    controller.hidesBottomBarWhenPushed = YES;
    controller.wkWebView = self.nextWkWebView;
    controller.wkWebView.delegate = controller;
    
    [self.navigationController pushViewController:controller animated:YES];
    responseCallback(@"回传给js");
}

- (void)isSign {
    [Helper pushLogin:self];
}

#pragma mark - Private Methods

- (void)onBack {
    [self.wkWebView callHandler:@"JS_Destroy" data:@{} responseCallback:^(id responseData) {
        NSLog(@"JS_Destroy :%@",responseData);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"HXWKWebViewViewController dealloc.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
