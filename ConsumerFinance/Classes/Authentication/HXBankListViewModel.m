////
////  HXBankListViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/6/12.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBankListViewModel.h"
//#import "HXBankListModel.h"
//
//@implementation HXBankListViewModel
//-(void)archiveBaseInformationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0188",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.nameStr = [object.body objectForKey:@"name"];
//                                                         self.idCardNumber = [object.body objectForKey:@"idCard"];
//                                                         self.authBool = [object.body objectForKey:@"isAuth"];
//                                                         returnBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//    
//    
//    
//}
//
//-(void)archiveBankListWithReturnBlock:(ReturnValueBlock)returnBlock {
//    
//    NSDictionary *head = @{@"tradeCode" : @"0192",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : userUuid,
//                           };
////    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         NSMutableArray * arr = [[NSMutableArray alloc] init];
//                                                         for (NSDictionary * dic in [object.body objectForKey:@"volist"]) {
//                                                             
//                                                             HXBankListModel * model = [HXBankListModel mj_objectWithKeyValues:dic];
//                                                             if (model) {
//                                                                 
//                                                                 [arr addObject:model];
//                                                             }
//                                                         }
//                                                         self.bankArr = arr;
//                                                         
//                                                         returnBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//    
//    
//    
//}
//-(void)deledateCardWithCardId:(NSString *)cardId returnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0191",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"userBankId":cardId
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
// 
//                                                         returnBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//    
//    
//    
//}
//
//- (void)archiveOpenBankBoolWithReturnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock {
//    
//    NSDictionary *head = @{@"tradeCode" : @"0214",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : userUuid
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         returnBlock();
//                                                     } else {
//                                                         failureBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     failureBlock();
//                                                 }];
//    
//    
//}
//@end
