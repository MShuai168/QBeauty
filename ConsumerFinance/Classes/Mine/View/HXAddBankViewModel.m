//
//  HXAddBankViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXAddBankViewModel.h"


@implementation HXAddBankViewModel
-(void)archiveMessageWithReturnBlock:(ReturnValueBlock)returnBlock {
    
    NSDictionary *head = @{@"tradeCode" : @"0189",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"userUuid" : userUuid,
                           @"bankCode" :self.suportModel.bankCode,
                           @"idCard" :self.idCardStr?self.idCardStr:@"",
                           @"cardNo" :self.cardNumber?self.cardNumber:@"",
                           @"name" :self.nameStr?self.nameStr:@"",
                           @"cellPhone" :self.iphoneNumber?self.iphoneNumber:@"",
                           @"orderNo":self.orderNo.length!=0?self.orderNo:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         self.flowOrderID = [object.body objectForKey:@"flowOrderID"];
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
    
}
-(void)submitBankInformationWithReturnBlock:(ReturnValueBlock)returnBlock {
    
    NSDictionary *head = @{@"tradeCode" : @"0190",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"userUuid" :userUuid,
                           @"bankCode" :self.suportModel.bankCode,
                           @"idCard" :self.idCardStr?self.idCardStr:@"",
                           @"cardNo" :self.cardNumber?self.cardNumber:@"",
                           @"name" :self.nameStr?self.nameStr:@"",
                           @"cellPhone" :self.iphoneNumber?self.iphoneNumber:@"",
                           @"provinceId":self.provinceId,
                           @"cityId" :self.citiId,
                           @"smsCode":self.messageCode,
                           @"flowOrderID":self.flowOrderID?self.flowOrderID:@"",
                           @"orderNo":self.orderNo.length!=0?self.orderNo:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         
                                                         
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
}
-(void)archiveBankListWithReturnBlock:(ReturnValueBlock)returnBlock {
    
    NSDictionary *head = @{@"tradeCode" : @"0195",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{
                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray * arr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"bankList"]) {
                                                             HXSuportBankModel * model = [HXSuportBankModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [arr addObject:model];
                                                             }
                                                             
                                                         }
                                                         if (arr.count !=0) {
                                                             
                                                             self.supportBankArr = arr;
                                                         }
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
    
}

-(void)archiveSuportBankInformation {
    NSArray * bankArr = @[@"中国工商银行",@"中国建设银行",@"中国银行",@"中国农业银行",@"交通银行",@"中信银行",@"中国光大银行",@"中国民生银行",@"兴业银行",@"华夏银行",@"上海浦东发展银行",@"广东发展银行",@"平安银行"];
    
    NSArray * bankCode = @[@"B005",@"B006",@"B007",@"B008",@"B009",@"B012",@"B013",@"B014",@"B015",@"B016",@"B017",@"B019",@"B021"];
    
     NSArray * icon = @[@"ICBC",@"CBC",@"BOC",@"ABC",@"BCM",@"CCB",@"CEB",@"CMBC",@"CIB",@"HXB",@"SPDB",@"CGB",@"PAB"];
    NSMutableArray * supportArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<bankArr.count; i++) {
        HXSuportBankModel * model = [[HXSuportBankModel alloc] init];
        model.bankName = [bankArr objectAtIndex:i];
        model.logoIcon = [icon objectAtIndex:i];
        model.bankCode = [bankCode objectAtIndex:i];
        [supportArr addObject:model];
    }
    self.supportBankArr = supportArr;
    
}
@end
