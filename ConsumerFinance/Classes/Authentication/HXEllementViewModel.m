////
////  HXEllementViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/12.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXEllementViewModel.h"
//@implementation HXEllementViewModel
//-(void)submitInformationWithJobModel:(HXJobInforModel *)jobModel photoArr:(NSMutableArray *)arr returnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0107",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"dormAddress":jobModel.unitcommenAddress?jobModel.unitcommenAddress:@"",
//                           @"discipline":jobModel.majorIn?jobModel.majorIn:@"",
//                           @"schoolName":jobModel.name?jobModel.name:@"",
//                           @"cityId":jobModel.cityModel.areaCode?jobModel.cityModel.areaCode:@"",
//                           @"provinceId":jobModel.provinceModel.areaCode?jobModel.provinceModel.areaCode:@"",
//                           @"concurrentPostEarnings":jobModel.revenue.length!=0?jobModel.revenue:@"",
//                           @"concurrentPost":jobModel.switchOn.length!=0?jobModel.switchOn:@"2",
//                           @"livingExpenses":jobModel.alimony.length!=0?jobModel.alimony:@"",
//                           @"admissionAt":jobModel.entryTime?jobModel.entryTime:@"",
//                           @"studentImg":arr ? arr :@[]
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
//}
//-(void)submitPhotoWithPhotoArr:(NSMutableArray *)arr returnBlock:(ReturnValueBlock )returnBlock{
//    
//    NSDictionary *head = @{@"tradeCode" : @"0124",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"type" :@"1",
//                           @"img":arr ? arr :@[]
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
//}
//-(void)archiveInformationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0108",
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
//                                                         self.model = [HXEllementModel mj_objectWithKeyValues:[object.body objectForKey:@"student"]];
//                                                         self.realName = [object.body objectForKey:@"realName"]?[object.body objectForKey:@"realName"]:@"";
//                                                         self.companyImgArr = [object.body objectForKey:@"studentImg"];
//                                                         returnBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//}
//-(NSString *)pluralityWithTag:(NSString *)tag {
//    if ([tag isEqualToString:@"1"]) {
//        return @"无兼职";
//    }else if([tag isEqualToString:@"2"]) {
//        return @"500以下";
//    }else if([tag isEqualToString:@"3"]) {
//        return @"500-1000";
//    }else if([tag isEqualToString:@"4"]) {
//        return @"1001-1500";
//    }else if([tag isEqualToString:@"5"]) {
//        return @"1501-2000";
//    }else if([tag isEqualToString:@"6"]) {
//        return @"2000以上";
//    }else {
//        return @"";
//    }
//}
//-(NSString *)pluralityWithName:(NSString *)name {
//    if ([name isEqualToString:@"无兼职"]) {
//        return @"1";
//    }else if([name isEqualToString:@"500以下"]) {
//        return @"2";
//    }else if([name isEqualToString:@"500-1000"]) {
//        return @"3";
//    }else if([name isEqualToString:@"1001-1500"]) {
//        return @"4";
//    }else if([name isEqualToString:@"1501-2000"]) {
//        return @"5";
//    }else if([name isEqualToString:@"2000以上"]) {
//        return @"6";
//    }else {
//        return @"";
//    }
//}
//
//-(NSString *)monthlyIncomeWithTag:(NSString *)tag {
//    if([tag isEqualToString:@"1"]) {
//        return @"500以下";
//    }else if([tag isEqualToString:@"2"]) {
//        return @"500-1000";
//    }else if([tag isEqualToString:@"3"]) {
//        return @"1001-1500";
//    }else if([tag isEqualToString:@"4"]) {
//        return @"1501-2000";
//    }else if([tag isEqualToString:@"5"]) {
//        return @"2000以上";
//    }else {
//        return @"";
//    }
//}
//-(NSString *)monthlyIncomeWithName:(NSString *)name {
//    if([name isEqualToString:@"500以下"]) {
//        return @"1";
//    }else if([name isEqualToString:@"500-1000"]) {
//        return @"2";
//    }else if([name isEqualToString:@"1001-1500"]) {
//        return @"3";
//    }else if([name isEqualToString:@"1501-2000"]) {
//        return @"4";
//    }else if([name isEqualToString:@"2000以上"]) {
//        return @"5";
//    }else {
//        return @"";
//    }
//}
//@end
