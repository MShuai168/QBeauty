//
//  HXSetTradePWDViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXSetTradePWDViewModel.h"

@implementation HXSetTradePWDViewModel
-(void)submitPassWord:(NSString *)passWord returunBlock:(ReturnValueBlock)returunBlock {
    
    NSDictionary *head = @{@"tradeCode" : @"0185",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"userUuid" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
                           @"password":passWord
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         returunBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
}
@end
