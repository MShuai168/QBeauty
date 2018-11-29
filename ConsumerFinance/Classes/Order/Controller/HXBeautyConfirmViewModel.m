////
////  HXBeautyConfirmViewModel.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/8/21.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBeautyConfirmViewModel.h"
//
//@implementation HXBeautyConfirmViewModel
//-(id)initWithController:(UIViewController *)controller {
//    self = [super initWithController:controller];
//    if (self) {
//        
//    }
//    return self;
//}
//-(void)archivewOrderConfirmStates {
//    NSDictionary *head = @{@"tradeCode" : @"0257",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"orderId":self.orderInfo.id ?self.orderInfo.id :@""};
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
//                                                         self.orderInfo.yfqStatus = yfqStatus;
//                                                         
//                                                         [self.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//                                                             [self.controller.navigationController pushViewController:controller animated:YES];
//                                                         } with:self.orderType];
//                                                     }
//                                                     
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//    
//    
//    
//    
//}
//@end
