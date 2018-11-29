////
////  HXServiceChargeViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/11/21.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXServiceChargeViewModel.h"
//
//@implementation HXServiceChargeViewModel
//-(void)archiveServieceMoneyStatesWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0403",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{
//                           @"userUuid":userUuid,
//                           @"orderId":self.orderInfo.id.length!=0?self.orderInfo.id:@"",
//                           @"merchantOutOrderNo":self.merchantOutOrderNo.length!=0?self.merchantOutOrderNo:@""
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.payResultBool = [object.body objectForKey:@"payResult"]?[[object.body objectForKey:@"payResult"] boolValue]:NO;
//                                                         returnBlock();
//                                                     }else {
//                                                         failBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     failBlock();
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//       
//    
//}
//
//-(void)submitServieceMoneyStatesWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0404",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{
//                           @"userUuid":userUuid,
//                           @"orderId":self.orderInfo.id.length!=0?self.orderInfo.id:@""
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
//                                                         self.orderInfo.yfqStatus = yfqStatus;
//                                                         if ([self.orderInfo.yfqStatus isEqualToString:@"98"]) {
//                                                             returnBlock();
//                                                         }else {
//                                                             [self.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//                                                                 [self.controller.navigationController pushViewController:controller animated:YES];
//                                                             } with:self.orderType];
//                                                         }
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     failBlock();
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//    
//    
//    
//}
//
//-(void)archiveServiceChargeWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0405",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{
//                           @"userUuid":userUuid,
//                           @"orderId":self.orderInfo.id.length!=0?self.orderInfo.id:@""
//                           };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.orderInfo.serviceCharge = [object.body objectForKey:@"serviceCharge"];
//                                                         returnBlock();
//                                                     }else {
//                                                         failBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     failBlock();
//                                                     
//                                                 }];
//    
//    
//    
//    
//}
//@end
