//
//  HXBillViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBillViewModel.h"
#import "HXBillModel.h"

@implementation HXBillViewModel
-(void)archiveBillInformationWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail {
    
    NSDictionary *head = @{@"tradeCode" : @"0197",
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
                                                             HXBillModel * model = [HXBillModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [dataArr addObject:model];
                                                             }
                                                         }
                                                         self.billArr = dataArr;
                                                         returnBlock();
                                                     }else {
                                                         fail();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     fail();
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
}
-(void)showItemView:(UIView *)view  type:(NSInteger)type{
    if (self.stateView) {
        [self.stateView removeFromSuperview];
    }
    self.stateView = [self creatStatesView:view showType:type offset:0 showInformation:^{
        if ([self.controller respondsToSelector:NSSelectorFromString(@"request")]){
            SEL selector = NSSelectorFromString(@"request");
            IMP imp = [self.controller methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self.controller, selector);
            
        }
    }];
    
}
@end
