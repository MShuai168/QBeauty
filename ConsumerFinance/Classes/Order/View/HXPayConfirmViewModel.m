//
//  HXPayConfirmViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPayConfirmViewModel.h"

@implementation HXPayConfirmViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        self.payPasswordLockNum = @"0";
    }
    return self;
}
-(void)submitPassWord:(NSString *)passWord returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *head = @{@"tradeCode" : @"0187",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"userUuid" : userUuid,
                           @"password":passWord
                           };
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     self.payPasswordLockNum = [object.body objectForKey:@"payPasswordLockNum"];

                                                     returnBlock(object);
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                    
                                                     failBlock();
                                                     
                                                 }];
    
    
}

-(void)archivePaymentMessageWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *head = @{@"tradeCode" : @"0193",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"userUuid" : userUuid,
                           @"userBankId":self.selectBank.id,
                           @"tradeAmount":self.totalMoney?self.totalMoney:@"",
                           @"orderNo":self.orderNumber?self.orderNumber:@"",
                           @"currentPeriods":self.selectDate?self.selectDate:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)){
                                                         self.businessNo = [object.body objectForKey:@"businessNo"];
                                                         returnBlock();
                                                     }else {
                                                        failBlock(); 
                                                     }
    
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     failBlock();
                                                     
                                                 }];
    
    
    
}
-(void)submitRepayInformationWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *head = @{@"tradeCode" : @"0194",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"userUuid" : userUuid,
                           @"userBankId":self.selectBank.id,
                           @"tradeAmount":self.totalMoney?self.totalMoney:@"",
                           @"orderNo":self.orderNumber?self.orderNumber:@"",
                           @"currentPeriods":self.selectDate?self.selectDate:@"",
                           @"smsCode":self.message?self.message:@"",
                           @"businessNo":self.businessNo?self.businessNo:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)){
                                                         returnBlock();
                                                     }else {
                                                        failBlock(object);
                                                     }
                                                     
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     failBlock();
                                                     
                                                 }];
    
    
    
}


@end
