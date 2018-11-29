//
//  AppDelegate.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/6.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "AppManager.h"
#import "HXWKWebView.h"

#import <AVFoundation/AVFoundation.h>
#import <WechatOpenSDK/WXApi.h>
#import <SSZipArchive/SSZipArchive.h>

#import "GuideViewController.h"
#import <AlipaySDK/AlipaySDK.h>  //AliPay


@interface AppDelegate ()<WXApiDelegate>

@property (nonatomic, strong) MainTabBarController *mainController;

#define WeiXin_APPKEY @"wx211ca77260668beb"  //微信APPKEY
//#define BaiduMap_APPKEY @"M0TyqC6GZN1MoLdPtcHRIVRW" //百度地图APPKEY

@end

@implementation AppDelegate

#pragma mark - 打开App
- (void) openApp {
//    //判断是不是第一次启动,显示导航页
//    // 得到当前应用的版本号
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentAppVersion = infoDictionary[@"CFBundleShortVersionString"];
//    // 取出之前保存的版本号
//    NSString *appVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"appVersion"];
////     如果 appVersion 为 nil 说明是第一次启动；如果 appVersion 不等于 currentAppVersion 说明是更新了
//    if (appVersion == nil || appVersion != currentAppVersion) {
//        // 保存最新的版本号
//        [[NSUserDefaults standardUserDefaults] setValue:currentAppVersion forKey:@"appVersion"];
//        GuideViewController *VC = [[GuideViewController alloc] init];
//        self.window.rootViewController = VC;
//    } else {
        self.mainController = [[MainTabBarController alloc] init];
        self.window.rootViewController = self.mainController.tabBarController;
//    }

    [HXWKWebView shareInstance];
    
//    /** 更新 */
//    [[AppManager manager] checkAppUpdate];
}

#pragma mark - 设置友盟统计
- (void) registerUMStatistics{
    UMConfigInstance.appKey    = UMAppkey;
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.eSType    = E_UM_NORMAL;
    [MobClick startWithConfigure:UMConfigInstance];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /** 延迟启动图的显示时间 */
    [NSThread sleepForTimeInterval:2.0f];
    
    /** window初始化 */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /** 打开App */
    [self openApp];
    
    /** 设置友盟统计 */
//    [self registerUMStatistics];
    
    /** 监听网络连接 */
    [AFNetManager isConnectionAvailable];
    
    // share
//    [WeiboSDK enableDebugMode:NO];
//    [WeiboSDK registerApp:@"2590679679"];
    [WXApi registerApp:WeiXin_APPKEY];
//    [[TencentOAuth alloc] initWithAppId:@"1106449407" andDelegate:self];
    
    
    return YES;
}


// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包APP客户端进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
//            [[NSNotificationCenter  defaultCenter] postNotificationName:@"AliPaySucceed" object:nil userInfo:nil];
            if ([resultDic[@"resultStatus"] intValue] == 9000) {
//                NSLog(@"支付成功");
                [[NSNotificationCenter  defaultCenter] postNotificationName:@"AliPaySucceed" object:nil userInfo:nil];
            } else {
//                NSLog(@"支付失败");
                NSString *returnStr;
                switch ([resultDic[@"resultStatus"] integerValue]) {
                    case 8000:
                        returnStr = @"订单正在处理中";
                        break;
                    case 4000:
                        returnStr = @"订单支付失败";
                        break;
                    case 6001:
                        returnStr = @"订单取消支付";
                        break;
                    case 6002:
                        returnStr = @"网络连接出错";
                        break;
                    default:
                        break;
                }
                [KeyWindow displayMessage:returnStr];
            }
        }];
/*
//没啥卵用，不知道在什么情况下才调用该方法
        【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
*/
//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
    }
    
    //此处是微信支付
    if ([url.scheme isEqualToString:WeiXin_APPKEY]) {
        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    return YES;
}

#pragma mark - weixin
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        switch (resp.errCode) {
            case WXSuccess:
                [KeyWindow displayMessage:@"分享成功"];
                break;
            case WXErrCodeUserCancel:
                [KeyWindow displayMessage:@"分享取消"];
                break;
            case WXErrCodeSentFail:
                [KeyWindow displayMessage:@"分享失败"];
                break;
            case WXErrCodeAuthDeny:
                [KeyWindow displayMessage:@"分享授权失败"];
                break;
            case WXErrCodeUnsupport:
                [KeyWindow displayMessage:@"微信不支持"];
                break;
                
            default:
                break;
        }
    }
    
    //微信回调,有支付结果的时候会回调这个方法
    if([resp isKindOfClass:[PayResp class]]){
        //支付结果回调
        switch (resp.errCode) {
            case WXSuccess:{
                //支付返回结果，实际支付结果需要去自己的服务器端查询
//                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"success"];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [[NSNotificationCenter  defaultCenter] postNotificationName:@"AliPaySucceed" object:nil userInfo:nil];
                break;
            }
            default:{
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
}

@end
