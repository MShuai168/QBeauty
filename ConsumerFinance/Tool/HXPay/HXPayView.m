//
//  HXPayView.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/10/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPayView.h"
#import "HXWKWebView.h"
#import <WebKit/WebKit.h>

#import <AlipaySDK/AlipaySDK.h>  //支付宝支付
#import <WXApi.h> //微信支付


@interface HXPayView()<HXWKWebViewDelegate>

@property (nonatomic, strong) HXWKWebView *wkWebView;
@property (nonatomic, strong) NSString *alipayUrl;
@property (nonatomic, strong) successBlock block;

@end

@implementation HXPayView

//- (void)pay:(NSString *)orderNo orderServiceBool:(BOOL)orderServiceBool successBlock:(successBlock)successBlock failBlock:(failBlock)failBlock{
//    self.orderServiceBool = orderServiceBool;
//    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
//        [KeyWindow displayMessage:@"请先安装支付宝"];
//        if (orderServiceBool) {
//            failBlock(@"",@"");
//        } else {
//            failBlock();
//        }
//        return;
//    }
//
//    NSDictionary * body = @{@"orderNo": orderNo.length!=0?orderNo:@""};
//    [[HXNetManager shareManager] get:PayUrlParamUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
//        if (IsEqualToSuccess(responseNewModel.status)) {
//            NSString *payUrl = [responseNewModel.body objectForKey:@"payURL"];
//            self.alipayUrl = [[NSString stringWithFormat:@"%@%@",@"https://pay.ebjfinance.com/alijspay.php?",payUrl] URLEncoded];
//            self.merchantOutOrderNo  = [responseNewModel.body objectForKey:@"merchantOutOrderNo"]?[responseNewModel.body objectForKey:@"merchantOutOrderNo"]:@"";
//            self.wkWebView = [[HXWKWebView alloc] init];
//            self.wkWebView.delegate = self;
//
//            NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"pay" ofType:@"html"];
//            NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//            NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
//            [self.wkWebView loadHTMLString:appHtml baseURL:baseURL];
//
//            if (successBlock) {
//                self.block = successBlock;
//            }
//        } else {
//            if (failBlock) {
//                failBlock();
//            }
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:nil];
//        if (failBlock) {
//            failBlock();
//        }
//    }];
//}


- (void)payWithType:(int)type orderNum:(NSString *)orderNo orderServiceBool:(BOOL)orderServiceBool successBlock:(successBlock)successBlock failBlock:(failBlock)failBlock {
    self.orderServiceBool = orderServiceBool;
    //type支付类型(1.支付宝   2.微信)
    if (type == 1 && ![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
        [KeyWindow displayMessage:@"请先安装支付宝"];
        if (orderServiceBool) {
            failBlock(@"",@"");
        } else {
            failBlock();
        }
        return;
    }

    if (type == 2 && ![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [KeyWindow displayMessage:@"请先安装微信"];
        if (orderServiceBool) {
            failBlock(@"",@"");
        } else {
            failBlock();
        }
        return;
    }
    
    NSDictionary *body = @{@"orderNo": orderNo.length!=0?orderNo:@"", @"payWay":@(type)};
    [[HXNetManager shareManager] get:@"scoreOrder/createPaySign" parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            NSDictionary *dic = [responseNewModel.body objectForKey:@"paySign"];
//            NSLog(@"%@", dic);
            
            if (type == 1) {
                NSString *payOrder = [dic objectForKey:@"aliSign"];
//                NSLog(@"%@",payOrder);

                [[AlipaySDK defaultService] payOrder:payOrder  fromScheme:@"cn.com.qbeautyXXX" callback:^(NSDictionary *resultDic) {
                    //未安装支付宝APP客户端吊起网页h5支付时，处理支付结果
                    NSLog(@"=====%@",resultDic);
                    if ([resultDic[@"resultStatus"] intValue] == 9000) {
//                        NSLog(@"支付成功");
                        if (successBlock) {
                            self.block = successBlock;
                        }
                        [[NSNotificationCenter  defaultCenter] postNotificationName:@"AliPaySucceed" object:nil userInfo:resultDic];
                    } else {
//                        NSLog(@"支付失败");
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
            } else if (type == 2) {
//                //这里调用后台接口获取订单的详细信息，然后调用微信支付方法
                [self WXPayWithAppid:dic[@"appid"] partnerid:dic[@"partnerid"] prepayid:dic[@"prepayid"] package:dic[@"package"] noncestr:dic[@"noncestr"] timestamp:dic[@"timestamp"] sign:dic[@"sign"]];
            }
        } else {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:nil];
        if (failBlock) {
            failBlock();
        }
    }];
}

#pragma mark 微信支付方法
- (void)WXPayWithAppid:(NSString *)appid partnerid:(NSString *)partnerid prepayid:(NSString *)prepayid package:(NSString *)package noncestr:(NSString *)noncestr timestamp:(NSString *)timestamp sign:(NSString *)sign{
     //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
    req.openID = appid;
    // 商家id，在注册的时候给的
    req.partnerId = partnerid;
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = prepayid;
    // 根据财付通文档填写的数据和签名
    req.package  = package;
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = noncestr;
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = timestamp;
    req.timeStamp = stamp.intValue;
    // 这个签名也是后台做的
    req.sign = sign;
    if ([WXApi sendReq:req]) { //发送请求到微信，等待微信返回onResp
        NSLog(@"吊起微信成功...");
    } else{
        NSLog(@"吊起微信失败...");
    }
}

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSString *js = [NSString stringWithFormat:@"callappjs.callAlipay('%@')",self.alipayUrl];
//    [webView evaluateJavaScript:js completionHandler:^(id _Nullable r, NSError * _Nullable error) {
//        if (self.orderServiceBool) {
//            self.block(self.merchantOutOrderNo);
//        } else {
//            self.block();
//        }
//    }];
//}


@end
