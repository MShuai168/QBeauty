//
//  HXMyViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyViewModel.h"

@implementation HXMyViewModel
-(void)archiveCreditActivationInformationWithReturnBlock:(ReturnValueBlock)returnBlock {
    NSDictionary *head = @{@"tradeCode" : @"0232",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{
                           @"userUuid":userUuid
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         self.creditModel = [HXCreditLimitModel mj_objectWithKeyValues:[object.body objectForKey:@"creditInfo"]];
                                                         self.creditModel.isActivate = [object.body objectForKey:@"isActivate"]?[object.body objectForKey:@"isActivate"]:@"";
                                                         self.creditModel.remainedMoney = [object.body objectForKey:@"remainedMoney"]?[object.body objectForKey:@"remainedMoney"]:@"";
                                                         if ([[object.body objectForKey:@"isActivate"] boolValue]) {
                                                             self.isHiddenActivateView = YES;
                                                             
                                                         }else {
                                                             
                                                             self.isHiddenActivateView = NO;
                                                         }
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
}

-(void)creditActivationWithReturnBlock:(ReturnValueBlock)returnBlock {
    
    NSDictionary *head = @{@"tradeCode" : @"0230",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{
                           @"userUuid":userUuid
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         returnBlock();
                                                         
                                                     }else {
                                                         [MBProgressHUD hideHUDForView:self.controller.view];
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                     
                                                 }];
    
    
    
}
@end
