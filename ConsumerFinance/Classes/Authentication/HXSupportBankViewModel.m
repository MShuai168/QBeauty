////
////  HXSupportBankViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/6/12.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXSupportBankViewModel.h"
//#import "HXSuportBankModel.h"
//@implementation HXSupportBankViewModel
////-(void)archiveBankListWithReturnBlock:(ReturnValueBlock)returnBlock {
////    
////    NSDictionary *head = @{@"tradeCode" : @"0195",
////                           @"tradeType" : @"appService"};
////    NSDictionary *body = @{
////                           };
////    [MBProgressHUD showMessage:nil toView:self.controller.view];
////    [[AFNetManager manager] postRequestWithHeadParameter:head
////                                           bodyParameter:body
////                                                 success:^(ResponseModel *object) {
////                                                     
////                                                     [MBProgressHUD hideHUDForView:self.controller.view];
////                                                     if (IsEqualToSuccess(object.head.responseCode)) {
////                                                         NSMutableArray * arr = [[NSMutableArray alloc] init];
////                                                         for (NSDictionary * dic in [object.body objectForKey:@"bankList"]) {
////                                                             HXSuportBankModel * model = [HXSuportBankModel mj_objectWithKeyValues:dic];
////                                                             [arr addObject:model];
//// 
////                                                         }
////                                                         self.banKArr = arr;
////                                                         returnBlock();
////                                                     }
////                                                     
////                                                 } fail:^(ErrorModel *error) {
////                                                     
////                                                     [MBProgressHUD hideHUDForView:self.controller.view];
////                                                     
////                                                 }];
////    
////    
////    
////}
//@end
