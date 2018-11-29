////
////  HXSignConractViewControllerViewModel.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/26.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXSignConractViewControllerViewModel.h"
//#import "HXAgreementModel.h"
//
//@implementation HXSignConractViewControllerViewModel
//
//- (instancetype)init {
//    if (self == [super init]) {
////        _mandateUrl = @"http://sports.qq.com";
////        _protocolUrl = @"http://weibo.com";
//        
////        [self getConract];
//    }
//    return self;
//}
//
//- (void)getConract {
//    NSDictionary *head = @{@"tradeCode" : @"0130",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"orderId" : self.orderInfo.id?self.orderInfo.id:@""
//                           };
//    
//    [MBProgressHUD showMessage:nil toView:nil];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.agreementArr = [HXAgreementModel mj_objectArrayWithKeyValuesArray:[object.body objectForKey:@"agreementList"]];
//                                                         self.mandateUrl = [object.body objectForKey:@"autContract"];
//                                                         self.isGreenChanel = [[object.body objectForKey:@"type"] isEqualToString:@"10"]?YES:NO;
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                 }];
//}
//
//@end
