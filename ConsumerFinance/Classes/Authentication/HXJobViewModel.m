////
////  HXJobViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/11.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXJobViewModel.h"
//#import "PhotoSave.h"
//#import "HXPhotoModel.h"
//#define ImageTag 501
//@implementation HXJobViewModel
//-(void)submitJobInformationWithJobModel:(HXJobInforModel *)jobModel photoArr:(NSMutableArray *)arr returnBlock:(ReturnValueBlock )returnBlock {
//    NSString * iphone = [NSString stringWithFormat:@"%@-%@",jobModel.areaNumber,jobModel.iphoneNumber];
//    NSDictionary *head = @{@"tradeCode" : @"0111",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"name":jobModel.unitStr?jobModel.unitStr:@"",
//                           @"address":jobModel.unitcommenAddress?jobModel.unitcommenAddress:@"",
//                           @"telephone":iphone?iphone:@"",
//                           @"cityId":jobModel.cityModel.areaCode?jobModel.cityModel.areaCode:@"",
//                           @"provinceId":jobModel.provinceModel.areaCode?jobModel.provinceModel.areaCode:@"",
//                           @"type":[self natureWithName:jobModel.nature],
//                           @"monthlySalary":jobModel.revenue?jobModel.revenue:@"",
//                           @"entryTime":jobModel.entryTime?jobModel.entryTime:@"",
//                           @"companyImg":arr ? arr :@[]
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
//    
//}
//-(void)submitPhotoWithPhotoArr:(NSMutableArray *)arr returnBlock:(ReturnValueBlock )returnBlock failBlock:(FailureBlock)failBlock{
//    
//    NSMutableArray * keyList = [[NSMutableArray alloc] init];
//    for (HXPhotoModel * model  in arr) {
//        if (model.key.length==0) {
//            continue;
//        }
//        [keyList addObject:model.key];
//    }
//    
//    NSDictionary *head = @{@"tradeCode" : @"0240",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : @"aebb571c0e5a490b8af1c0e2ca8d1561",
//                           @"type" :@"6",
//                           @"keyList":keyList ? keyList :@[]
//                           };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         
//                                                         
//                                                         returnBlock();
//                                                     }else {
//                                                         failBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     failBlock();
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//    
//}
//-(void)submitOtherPhotoWithPhotoArr:(NSMutableArray *)arr returnBlock:(ReturnValueBlock )returnBlock failBlock:(FailureBlock)failBlock{
//    NSMutableArray * keyList = [[NSMutableArray alloc] init];
//    for (HXPhotoModel * model  in arr) {
//        if (model.key.length==0) {
//            continue;
//        }
//        [keyList addObject:model.key];
//    }
//    NSLog(@"count ==============%d",keyList.count);
//    NSString * type = self.type;
//    NSDictionary *head = @{@"tradeCode" : @"0249",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : userUuid,
//                           @"type" :type.length!=0?type:@"",
//                           @"orderNo" :self.orderNumber ?self.orderNumber :@"",
//                           @"keyList":keyList ? keyList :@[]
//                           };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         
//                                                         returnBlock();
//                                                     }else {
//                                                         failBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     failBlock();
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//    
//    
//    
//}
//-(void)archiveJobInformationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0112",
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
//                                                         self.model = [HXJobInformationModel mj_objectWithKeyValues:[object.body objectForKey:@"compay"]];
//                                                         self.realName = [object.body objectForKey:@"realName"]?[object.body objectForKey:@"realName"]:@"";
//                                                         self.companyImgArr = [object.body objectForKey:@"companyImg"];
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
//-(void)archivePhotoType:(NSString *)type ordrNumber:(NSString *)orderNumber returnBlock:(ReturnValueBlock )returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0270",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : userUuid,
//                           @"type" :type.length!=0?type:@"",
//                           @"orderNo":orderNumber.length!=0?orderNumber:@"",
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         NSMutableArray * photoArr = [[NSMutableArray alloc] init];
//                                                         NSMutableArray * selectPhotoArr = [[NSMutableArray alloc] init];
//                                                         if ([object.body objectForKey:@"onAnshupTempList"]) {
//                                                             NSMutableArray * arr = [object.body objectForKey:@"onAnshupTempList"];
//                                                             for (int i = 0; i<arr.count; i++) {
//                                                                 NSMutableDictionary * dic = [arr objectAtIndex:i];
//                                                                 HXPhotoModel * model = [[HXPhotoModel alloc] init];
//                                                                 model.key = [dic objectForKey:@"key"]?[dic objectForKey:@"key"]:@"";
//                                                                 model.photoUrl = [dic objectForKey:@"url"]?[dic objectForKey:@"url"]:@"";
//                                                                 model.progress = 1.00;
//                                                                 model.comPhotoUrl = [dic objectForKey:@"detailUrl"]?[dic objectForKey:@"detailUrl"]:@"";
//                                                                 model.states = PhotoStatesSuccess;
//                                                                 model.serverSuccess = YES;
//                                                                 [photoArr addObject:model];
//                                                             }
//                                                         }
//                                                         if ([object.body objectForKey:@"onYfqTempList"]) {
//                                                             NSMutableArray * arr = [object.body objectForKey:@"onYfqTempList"];
//                                                             for (int i = 0; i<arr.count; i++) {
//                                                                 NSMutableDictionary * dic = [arr objectAtIndex:i];
//                                                                 HXPhotoModel * model = [[HXPhotoModel alloc] init];
//                                                                 model.key = [dic objectForKey:@"key"]?[dic objectForKey:@"key"]:@"";
//                                                                 model.photoUrl = [dic objectForKey:@"url"]?[dic objectForKey:@"url"]:@"";
//                                                                 model.comPhotoUrl = [dic objectForKey:@"detailUrl"]?[dic objectForKey:@"detailUrl"]:@"";
//                                                                 model.photoTag = i+ImageTag;
//                                                                 model.states = PhotoStatesSuccess;
//                                                                 model.haveUpload = YES;
//                                                                 [selectPhotoArr addObject:model];
//                                                             }
//                                                         }
//                                                         
//                                                         
//                                                         returnBlock(selectPhotoArr,photoArr);
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
//    
//}
//-(void)archiveKindType {
//    switch (self.catory) {
//        case CertificateWork:
//        {
//            self.type = @"14";
//            
//        }
//            break;
//        case CertificatePayment:
//        {
//            self.type = @"8";
//        }
//            break;
//        case CertificateSales:
//        {
//            self.type = @"9";
//            
//        }
//            break;
//        case CertificateStream:
//        {
//            self.type = @"11";
//        }
//            break;
//        case CertificateFinancial:
//        {
//            self.type = @"10";
//            
//        }
//            break;
//        case CertificateStudent:
//        {
//            self.type = @"13";
//        }
//            break;
//        case CertificateIdentify:
//        {
//            self.type = @"12";
//        }
//            break;
//        default:
//            break;
//    }
//    
//}
//
//-(NSString *)natureWithTag:(NSString *)tag {
//    if ([tag isEqualToString:@"00"]) {
//        return @"政府机关";
//    }else if ([tag isEqualToString:@"10"]) {
//        return @"事业单位";
//    }else if ([tag isEqualToString:@"20"]) {
//        return @"国企";
//    }else if ([tag isEqualToString:@"30"]) {
//        return @"外企";
//    }else if ([tag isEqualToString:@"40"]) {
//        return @"合资";
//    }else if ([tag isEqualToString:@"50"]) {
//        return @"民营";
//    }else if ([tag isEqualToString:@"60"]) {
//        return @"私企";
//    }else if ([tag isEqualToString:@"70"]) {
//        return @"个体";
//    }else {
//        return @"";
//    }
//}
//-(NSString *)natureWithName:(NSString *)name {
//    if ([name isEqualToString:@"政府机关"]) {
//        return @"00";
//    }else if ([name isEqualToString:@"事业单位"]) {
//        return @"10";
//    }else if ([name isEqualToString:@"国企"]) {
//        return @"20";
//    }else if ([name isEqualToString:@"外企"]) {
//        return @"30";
//    }else if ([name isEqualToString:@"合资"]) {
//        return @"40";
//    }else if ([name isEqualToString:@"民营"]) {
//        return @"50";
//    }else if ([name isEqualToString:@"私企"]) {
//        return @"60";
//    }else if ([name isEqualToString:@"个体"]) {
//        return @"70";
//    }else {
//        return @"";
//    }
//}
//-(void)archiveNameAndTitle {
//    switch (self.catory) {
//        case CertificateWork:
//        {
//            self.title =@"工作证明";
//            self.content = @"工作证明：劳动合同、就职证明、工作实景等";
//            
//        }
//            break;
//        case CertificatePayment:
//        {
//            self.title =@"首付凭证";
//            self.content = @"首付凭证：购买产品预付的首付款发票等凭证";
//        }
//            break;
//        case CertificateSales:
//        {
//            self.title =@"销售凭证";
//            self.content = @"销售凭证：商品订购单、通知单、发票、现场实景等";
//            
//        }
//            break;
//        case CertificateStream:
//        {
//            self.title =@"个人流水";
//            self.content = @"个人流水：工资流水、个人交易明细等";
//        }
//            break;
//        case CertificateFinancial:
//        {
//            self.title =@"财力证明";
//            self.content = @"财力证明：房产证、定期存款、寿险保单、理财证明等";
//            
//        }
//            break;
//        case CertificateIdentify:
//        {
//            self.title =@"身份证明";
//        }
//            break;
//        case CertificateStudent: {
//            self.title = @"学生证明";
//            self.content = @"请上传凭证：如学生证、校园一卡通、学信网截图";
//        }
//        default:
//            break;
//    }
//    
//}
//
//@end
