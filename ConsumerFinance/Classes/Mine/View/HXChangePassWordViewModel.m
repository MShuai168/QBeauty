//
//  HXChangePassWordViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXChangePassWordViewModel.h"

@implementation HXChangePassWordViewModel
-(void)submitPassWordWithReturnBlock:(ReturnValueBlock)returnBlock {
    NSString * pwd = [NSString stringWithFormat:@"%@%@",access_key,self.oldPassWord];
    NSString * pwdA = [NSString stringWithFormat:@"%@%@",access_key,self.firstPassWord];
    NSString *encryption_md5     = [MD5Encryption md5by32:pwd];
    NSString *encryption_md5A     = [MD5Encryption md5by32:pwdA];
    NSDictionary *head = @{@"tradeCode" : @"0009",
                           @"tradeType" : @"authService"};
    NSDictionary *body = @{@"userId"      : userUuid,
                           @"oldPassword" : encryption_md5,
                           @"againPassword" : encryption_md5A,
                           @"password" : encryption_md5A};
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [MobClick event:Event_modify_password];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if ([object.head.responseCode integerValue] == 0) {
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                 }];
    
    
    
}
@end
