//
//  HXWKWebView.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "WKWebViewJavascriptBridge.h"

@class HXWKWebView;
@protocol HXWKWebViewDelegate <NSObject, WKNavigationDelegate, WKUIDelegate>

@optional

- (void)targetToViewController:(HXWKWebView *)hxWKWebView withData:(id)data block:(WVJBResponseCallback)responseCallback;

- (void)scrollOffsetY:(HXWKWebView *)hxWKWebView withData:(id)data block:(WVJBResponseCallback)responseCallback;

@end

@interface HXWKWebView : UIView

+ (instancetype)shareInstance;

@property (nonatomic, weak) id<HXWKWebViewDelegate> delegate;

- (WKNavigation *)loadRequest:(NSURLRequest *)request;
- (WKNavigation *)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

- (void)reload;

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;
- (void)removeHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;

@end
