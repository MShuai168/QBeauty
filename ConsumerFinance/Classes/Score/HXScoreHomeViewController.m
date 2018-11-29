//
//  HXScoreHomeViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXScoreHomeViewController.h"
#import "HXWKWebViewViewController.h"
#import "HXWKWebView.h"
#import "UINavigationBar+Category.h"
//#import "HXScoreProductDetailViewController.h"
#import "HXMyMemberViewController.h"
#import "HXMyPointsViewController.h"
#import "HXRecordViewController.h"
#import "HXEarnScoreViewController.h"
#import "HXShoppingCartViewController.h"

@interface HXScoreHomeViewController ()

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation HXScoreHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"趣淘";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self needRefresh];
}

- (void)needRefresh {
    NSString *oldSign = [[NSUserDefaults standardUserDefaults] objectForKey:@"checkRefreshSign"];
    if (![AppManager manager].isOnline) {
        [self refresh:[MD5Encryption md5by32:[NSString stringWithFormat:@"%@",[AppManager manager].hxUserInfo.token]] oldSign:oldSign];
        return;
    }
//    NSLog(@"XXX:%@", [AppManager manager].hxUserInfo.token);  
    
    [[HXNetManager shareManager] get:@"display/getSum" parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            NSString *score = [responseNewModel.body objectForKey:@"score"];
            NSString *carSum = [responseNewModel.body objectForKey:@"carSum"];
            NSString *exchangeSum = [responseNewModel.body objectForKey:@"exchangeSum"];
            NSString *sign = [MD5Encryption md5by32:[NSString stringWithFormat:@"%@%@%@%@",[AppManager manager].hxUserInfo.token,score,carSum,exchangeSum]];
            
            [self refresh:sign oldSign:oldSign];
        }
    } failure:^(NSError *error) {

    }];
}

- (void)refresh:(NSString *)sign oldSign:(NSString *)oldSign {
    if (![oldSign isEqualToString:sign]) {
        [[NSUserDefaults standardUserDefaults] setObject:sign forKey:@"checkRefreshSign"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.wkWebView callHandler:@"JS_Refresh" data:@{} responseCallback:^(id responseData) {
            NSLog(@"JS_Refresh :%@",responseData);
        }];
    }
}

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
}

- (void)targetToViewController:(HXWKWebView *)hxWKWebView withData:(id)data block:(WVJBResponseCallback)responseCallback {
    NSString *targetType = [data objectForKey:@"targetType"];
//    进入我的会员
    if ([targetType isEqualToString:@"myMember"]) {
        HXMyMemberViewController *controller = [[HXMyMemberViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
//    进入我的积分
    if ([targetType isEqualToString:@"myScore"]) {
        HXMyPointsViewController *controller = [[HXMyPointsViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
//    进入兑换记录
    if ([targetType isEqualToString:@"exchangeRecords"]) {
        HXRecordViewController *controller = [[HXRecordViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
//    进入获取积分
    if ([targetType isEqualToString:@"getScore"]) {
        HXEarnScoreViewController *controller = [[HXEarnScoreViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    [super targetToViewController:hxWKWebView withData:data block:responseCallback];
}


// TODO: 暂时没有变透明需求
//- (void)scrollOffsetY:(HXWKWebView *)hxWKWebView withData:(id)data block:(WVJBResponseCallback)responseCallback {
//    CGFloat offset = [[data objectForKey:@"offset"] floatValue];
//    
//    UIColor * color = [UIColor colorWithWhite:1 alpha:1];
//    
//    if (offset > 50) {
//        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offset) / 64));
//        [self setNavigationBarTransparent:alpha];
//        [self.navigationController.navigationBar HX_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//    } else {
//        [self.navigationController.navigationBar HX_setBackgroundColor:[color colorWithAlphaComponent:0]];
//        [self setNavigationBarTransparent:0];
//    }
//}

- (void)rightButtonClick:(UIButton *)button {
    [self.wkWebView callHandler:@"JS_Sign" data:@{} responseCallback:^(id responseData) {
        
    }];
}

- (void)dealloc {
    NSLog(@"HXScoreHomeViewController dealloc.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
