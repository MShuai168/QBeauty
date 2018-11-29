//
//  WebBrowserView.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/5/2.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKScriptMessageHandler.h>

@class WebBrowserView;

@protocol WebBrowserViewDelegate <NSObject>
@optional
- (void)webViewDidStartLoad:(WebBrowserView *)webView;
- (void)webViewDidFinishLoad:(WebBrowserView *)webView;
- (void)webView:(WebBrowserView *)webView didFailLoadWithError:(NSError *)error;
- (void)webViewProgress:(WebBrowserView *)webView updateProgress:(CGFloat)progress;
- (BOOL)webView:(WebBrowserView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
@end


/**
 *  无缝切换UIWebView   
 *  会根据系统版本自动选择 使用WKWebView 还是 UIWebView
 */
@interface WebBrowserView : UIView
/**
 *  初始化WebBrowserView
 *
 *  @param frame          相对于父视图的所在位置
 *  @param usingUIWebView 是否使用UIWebView
 *
 *  @return WebBrowserView对象
 */
- (instancetype)initWithFrame:(CGRect)frame usingUIWebView:(BOOL)usingUIWebView;
/**
 *  WebBrowserViewDelegate
 */
@property(nonatomic, weak)id<WebBrowserViewDelegate> delegate;
/**
 *  内部使用的webView
 */
@property (nonatomic, readonly) id realWebView;
/**
 *  是否是使用 UIWebView
 */
@property (nonatomic, readonly) BOOL usingUIWebView;
/**
 *  预估网页加载进度
 */
@property (nonatomic, readonly) CGFloat estimatedProgress;
/**
 *  添加js回调oc通知方式，适用于 iOS8 之后
 */
- (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name;
/**
 *  注销 注册过的js回调oc通知方式，适用于 iOS8 之后
 */
- (void)removeScriptMessageHandlerForName:(NSString *)name;
/**
 *  加载层数
 *
 *  @return 层数
 */
- (NSInteger)countOfHistory;
/**
 *  返回到第几步
 *
 *  @param step 步数
 */
- (void)gobackWithStep:(NSInteger)step;
/**
 *  UI 或者 WK 的API
 */
@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly, copy) NSString  *title;
@property (nonatomic, readonly) NSURLRequest    *currentRequest;
@property (nonatomic, readonly) NSURL           *URL;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;

- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

- (id)goBack;
- (id)goForward;
- (id)reload;
- (id)reloadFromOrigin;
- (void)stopLoading;
/**
 *  通过javascript获取界面元素
 *
 *  @param javaScriptString  想要得到javaScriptString中的什么值
 *  @param completionHandler 拿到值后的回调
 */
- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler;
/**
 *  不建议使用这个办法  因为会在内部等待webView 的执行结果
 *
 *  @param javaScriptString 想要得到javaScriptString中的什么值
 *
 *  @return 通过javascript获取界面元素
 */
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString __deprecated_msg("Method deprecated. Use [evaluateJavaScript:completionHandler:]");
/**
 *  是否根据视图大小来缩放页面  默认为YES
 */
@property (nonatomic) BOOL scalesPageToFit;
/**
 *  控制用户是否可以选择页面元素内容,在页面元素中进行长按操作,safari会弹出菜单,来允许进行选择行为.NO禁用此行为代码(default=YES)
 *  在webViewDidFinishLoad:webView中使用
 */
@property (nonatomic) BOOL webkitUserSelectEnable;
/**
 *  禁用长按触控对象弹出的菜单,当你长按一个触控对象时,如链接,safari会弹出包含链接信息的菜单.NO禁用此行为CSS代码(default=YES)
 *  在webViewDidFinishLoad:webView中使用
 */
@property (nonatomic) BOOL webkitTouchCalloutEnable;

@end
