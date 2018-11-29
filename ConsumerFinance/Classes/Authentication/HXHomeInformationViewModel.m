////
////  HXHomeInformationViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/12.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXHomeInformationViewModel.h"
//#import "ProfileManager.h"
//#import "HXHomeInforModel.h"
//@implementation HXHomeInformationViewModel
//-(void)submitInformationWithHoutse:(NSString *)houseStr income:(NSString *)income
//                       returnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0109",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"houseProperty":[ProfileManager getEstateCodeWithString:houseStr],
//                           @"income":income
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         
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
//}
//-(void)archiveHomeInformationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    
//    NSDictionary *head = @{@"tradeCode" : @"0110",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.model = [HXHomeInforModel mj_objectWithKeyValues:[object.body objectForKey:@"freelance"]];
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
//}
//@end
