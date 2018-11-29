////
////  HXBillingdetailsViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/31.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBillingdetailsViewModel.h"
//#import "HXBillDetailsModel.h"
//#import "HXBankListModel.h"
//
//@implementation HXBillingdetailsViewModel
//-(id)initWithController:(UIViewController *)controller {
//    self = [super initWithController:controller];
//    if (self) {
//        self.totalMoney = @"0.00";
//        self.interest =@"0.00";
//        self.squareBool = YES;
//    }
//    return self;
//}
//-(void)archivePassWordHaveBoolWithReturnBlock:(ReturnValueBlock)returnblock{
//    
//    NSDictionary *head = @{@"tradeCode" : @"0183",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : userUuid
//                           };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                    
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.hasPassWordBool = [object.body objectForKey:@"hasPassword"];
//                                                     }
//                                                     returnblock();
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     
//                                                     returnblock();
//                                                 }];
//    
//    
//    
//}
//
//-(void)archiveDetailWithReturnBlock:(ReturnValueBlock)returnblock failBlock:(FailureBlock)failBlock{
//    
//    NSDictionary *head = @{@"tradeCode" : @"0136",
//                           @"tradeType" : @"appService"};
//
//    NSDictionary *body = @{@"userUuid" : userUuid,
//                           @"orderNo" :self.orderNo.length!=0?self.orderNo:@""
//
//                           };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.orderMoney = [object.body objectForKey:@"orderMoney"];
//                                                         self.createDate = [object.body objectForKey:@"createDate"];
//                                                         self.orderNo = [object.body objectForKey:@"orderNo"]?[[object.body objectForKey:@"orderNo"] stringValue]:@"";
//                                                         self.isGreen = [[object.body objectForKey:@"isGreen"] isEqualToString:@"1"]?YES:NO;
//                                                         self.repayMoneStr = [object.body objectForKey:@"msg"];
//                                                         self.repayAmt = [object.body objectForKey:@"repayAmt"];
//                                                         self.responseTime = object.head.responseTime;
//                                                         NSMutableArray * dataArr = [[NSMutableArray alloc] init];
//                                                         BOOL first = NO;
//                                                         for (NSDictionary * dic in [object.body objectForKey:@"voList"]) {
//                                                             HXBillDetailsModel * model = [HXBillDetailsModel mj_objectWithKeyValues:dic];
//                                                             if (![model.isChooosed boolValue]) {
//                                                                 self.squareBool = NO;
//                                                             }
//                                                             if ([model.canChoose boolValue]) {
//                                                                 if (!first) {
//                                                                     model.firstSelect = YES;
//                                                                     first = YES;
//                                                                 }
//                                                             }
//                                                             if (model) {
//                                                                 
//                                                                 [dataArr addObject:model];
//                                                             }
//                                                         }
//                                                         self.voListArr = dataArr;
//
//                                                         
//                                                         returnblock();
//                                                     }else {
//                                                         
//                                                         failBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                   
//                                                     failBlock();
//                                                     
//                                                 }];
//    
//}
//
//-(void)archiveBankListWithReturnBlock:(ReturnValueBlock)returnBlock {
//    
//    NSDictionary *head = @{@"tradeCode" : @"0215",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : userUuid,
//                           @"orderNo":self.orderNo.length!=0?self.orderNo:@""
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
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
//-(void)archiveBaseInformationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0188",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : userUuid
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
//}
//-(void)archiveTotalMoney:(HXBillDetailsModel *)model {
//    if (model.money && [model.money floatValue]!=0) {
//        
//        self.totalMoney = [NSString stringWithFormat:@"%.2f",[self.totalMoney floatValue] + [model.money floatValue]];
//    }
//    if (model.interest && [model.interest floatValue]!=0) {
//        
//        self.interest = [NSString stringWithFormat:@"%.2f",[self.interest floatValue] + [model.interest floatValue]];
//    }
//    
//}
//
//@end
