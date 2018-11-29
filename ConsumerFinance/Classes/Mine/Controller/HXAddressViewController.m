//
//  HXAddressViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXAddressViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "HXWKWebViewViewController.h"
#import "AddressPickViewController.h"
#import "HXAlertViewController.h"
#import "HXShopAddressModel.h"

#import <WebKit/WebKit.h>

@interface HXAddressViewController()

@end

@implementation HXAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址";
    __weak typeof(self) weakSelf = self;
    [self.wkWebView registerHandler:@"Native_SelectedAddress" handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong __typeof (weakSelf) sself = weakSelf;
        HXShopAddressModel *model = [HXShopAddressModel mj_objectWithKeyValues:data];
        if (sself.returnAddress) {
            sself.returnAddress(model);
            responseCallback(nil);
        }
    }];
    
    [self.wkWebView registerHandler:@"Native_Delete_Address" handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong __typeof (weakSelf) sself = weakSelf;
        HXAlertViewController *alertController = [HXAlertViewController alertControllerWithTitle:@"" message:@"您确定要删除该地址？" leftTitle:@"取消" rightTitle:@"确定"];
        alertController.leftAction = ^{
            NSLog(@"左侧按钮");
            NSDictionary *dic = @{@"isDeleted":@"No"};
            responseCallback(dic.mj_JSONString);
        };
        alertController.rightAction = ^{
            NSLog(@"右侧按钮");
            NSDictionary *dic = @{@"isDeleted":@"Yes"};
            responseCallback(dic.mj_JSONString);
        };
        
        [sself presentViewController:alertController animated:YES completion:nil];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.wkWebView callHandler:@"JS_Refresh" data:@{} responseCallback:^(id responseData) {
        NSLog(@"JS_Refresh :%@",responseData);
    }];
    
}

- (void)needRefresh {
    NSString *oldSign = [[NSUserDefaults standardUserDefaults] objectForKey:@"checkRefreshSign"];
    
    if (![AppManager manager].isOnline) {
        [self refresh:[MD5Encryption md5by32:[NSString stringWithFormat:@"%@",[AppManager manager].hxUserInfo.token]] oldSign:oldSign];
        return;
    }
    
    __block float shopCarts = 0;
    [[HXNetManager shareManager] get:QueryShoppingCartUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            NSArray *array = [responseNewModel.body objectForKey:@"shoppingCart"];
            shopCarts = array.count;
            NSString *sign = [MD5Encryption md5by32:[NSString stringWithFormat:@"%@%f",[AppManager manager].hxUserInfo.token,shopCarts]];
            
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

- (void)targetToViewController:(HXWKWebView *)hxWKWebView withData:(id)data block:(WVJBResponseCallback)responseCallback {
    NSString *targetType = [data objectForKey:@"targetType"];
    if ([targetType isEqualToString:@"dismiss"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([targetType isEqualToString:@"login"]) {
        [[AppManager manager] signOutProgressHandler:nil userInfo:nil];
        [self isSign];
        return;
    }
    
    HXWKWebViewViewController *controller = [[HXWKWebViewViewController alloc] init];
    controller.title = [data objectForKey:@"title"];
    NSString *url = [data objectForKey:@"url"];
    controller.url = url;
    controller.isTransparente = NO;
    [controller.wkWebView registerHandler:@"Native_SelectCity" handler:^(id data, WVJBResponseCallback responseCallback) {
        AddressPickViewController *controller = [[AddressPickViewController alloc] init];
        controller.block = ^(AddressModel *provinceModel, AddressModel *cityModel, AddressModel *zoneModel) {
            NSDictionary *dic =@{@"provinceCode":provinceModel.areaCode,@"cityCode":cityModel.areaCode,@"areaCode":zoneModel? zoneModel.areaCode:@"",@"provinceName":provinceModel.areaName,@"cityName":cityModel.areaName,@"areaName":zoneModel?zoneModel.areaName:@""};
            responseCallback(dic.mj_JSONString);
        };
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }];
    responseCallback(@"回传给js");
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)isSign {
   [Helper pushLogin:self];
}

- (void)onBack {
    __weak typeof(self) weakSelf = self;
    [self.wkWebView callHandler:@"JS_CurrentAddress" data:nil responseCallback:^(id responseData) {
        __strong __typeof (weakSelf) sself = weakSelf;
        if (responseData) {
            HXShopAddressModel *model = [HXShopAddressModel mj_objectWithKeyValues:[responseData objectForKey:@"responseMsg"]];
            if (sself.returnAddress) {
                sself.returnAddress(model);
            }
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    NSLog(@"HXAddressViewController dealloc.");
}

@end
