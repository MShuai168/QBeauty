//
//  HXRepaymentViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRepaymentViewModel.h"
#import "HXRepaymentModel.h"

@implementation HXRepaymentViewModel
-(void)archiveRepaymentReturnValue:(ReturnValueBlock)returnValue faile:(FailureBlock)fail{
    
    NSDictionary *head = @{@"tradeCode" : @"0196",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"userUuid" : userUuid
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray * dataArr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"voList"]) {
                                                             HXRepaymentModel * model = [HXRepaymentModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [dataArr addObject:model];
                                                             }
                                                         }
                                                         self.repaymentArr = dataArr;
                                                         returnValue();
                                                     }else {
                                                         fail();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     fail();
                                                     
                                                 }];
    
    
}
@end
