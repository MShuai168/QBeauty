//
//  WebBrowserViewProgress.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/5/2.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const CGFloat InitialProgressValue;
extern const CGFloat InteractiveProgressValue;
extern const CGFloat FinalProgressValue;

typedef void (^WebBrowserViewProgressBlock)(CGFloat progress);
@protocol WebBrowserViewProgressDelegate;


@interface WebBrowserViewProgress : NSObject<UIWebViewDelegate>
@property (nonatomic, weak) id<WebBrowserViewProgressDelegate>progressDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) WebBrowserViewProgressBlock progressBlock;
@property (nonatomic, readonly) CGFloat progress; // 0.0..1.0
- (void)reset;
@end


@protocol WebBrowserViewProgressDelegate <NSObject>
- (void)webViewProgress:(WebBrowserViewProgress *)webViewProgress updateProgress:(CGFloat)progress;
@end
