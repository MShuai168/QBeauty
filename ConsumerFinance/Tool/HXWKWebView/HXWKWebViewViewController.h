//
//  HXWebViewViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXWKWebView.h"
@protocol WebShopDelegate;
@interface HXWKWebViewViewController : UIViewController<HXWKWebViewDelegate>

@property (nonatomic, strong, readonly) HXWKWebView *wkWebView;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL isTransparente;
@property (nonatomic, weak) id<WebShopDelegate> webShopDelegate;

- (void)setUpWKWebView;

@end

@protocol WebShopDelegate<NSObject>

-(void)refreshShopCar;

@end
