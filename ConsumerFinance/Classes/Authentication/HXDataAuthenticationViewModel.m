////
////  HXDataAuthenticationViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/9.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXDataAuthenticationViewModel.h"
//#import "HXCreditLimitModel.h"
//
//@implementation HXDataAuthenticationViewModel
//#pragma mark --获取基本信息
//-(void)archiveDataAtuthenStatesWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0160",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"orderNo":self.orderInfo.orderNo.length!=0?self.orderInfo.orderNo:@""
//                           };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.model = [HXDataAuthenModel mj_objectWithKeyValues:[object.body objectForKey:@"user"]];
//                                                         if ([self.model.identity_tag isEqualToString:@"01"] ||[self.model.identity_tag isEqualToString:@"02"]) {
//                                                             self.style = WorkStyle;
//                                                         }else if ([self.model.identity_tag isEqualToString:@"03"]){
//                                                             self.style = StudentStyle;
//                                                         }else if ([self.model.identity_tag isEqualToString:@"04"]){
//                                                             self.style = FreeStyle;
//                                                         }else {
//                                                             self.style = DefaultStyle;
//                                                         }
//                                                         self.photoUploadBool = [self.model.isOtherAuth boolValue];
//                                                         [self changeStates];
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
//-(void)changeStates {
//    NSArray * nameArr;
//    NSArray * statesArr;
//    switch (self.style) {
//        case DefaultStyle:
//        {
//            if (_orderAuth) {
//                nameArr = @[@[@"实名认证",@"运营商认证",@"个人信息",@"影像信息"],@[@"邮箱认证",@"征信报告"]];
//                statesArr = @[@[self.model.isAuth?self.model.isAuth:@"0",self.model.isOperatorAuth?self.model.isOperatorAuth:@"0",self.model.isPersonalAuth?self.model.isPersonalAuth:@"0",@"0"],@[self.model.isMailAuth?self.model.isMailAuth:@"0",self.model.isCreditAuth?self.model.isCreditAuth:@"0"]];
//            }else {
//                nameArr = @[@[@"实名认证",@"运营商认证",@"个人信息"],@[@"邮箱认证",@"征信报告"]];
//                statesArr = @[@[self.model.isAuth?self.model.isAuth:@"0",self.model.isOperatorAuth?self.model.isOperatorAuth:@"0",self.model.isPersonalAuth?self.model.isPersonalAuth:@"0"],@[self.model.isMailAuth?self.model.isMailAuth:@"0",self.model.isCreditAuth?self.model.isCreditAuth:@"0"]];
//            }
//        }
//            break;
//        case WorkStyle:
//        {
//            if (_orderAuth) {
//                nameArr = @[@[@"实名认证",@"运营商认证",@"个人信息",@"工作信息",@"影像信息"],@[@"邮箱认证",@"征信报告"]];
//                statesArr = @[@[self.model.isAuth?self.model.isAuth:@"0",self.model.isOperatorAuth?self.model.isOperatorAuth:@"0",self.model.isPersonalAuth?self.model.isPersonalAuth:@"0",self.model.isWorkAuth?self.model.isWorkAuth:@"0",@"0"],@[self.model.isMailAuth?self.model.isMailAuth:@"0",self.model.isCreditAuth?self.model.isCreditAuth:@"0"]];
//            }else {
//                nameArr = @[@[@"实名认证",@"运营商认证",@"个人信息",@"工作信息"],@[@"邮箱认证",@"征信报告"]];
//                statesArr = @[@[self.model.isAuth?self.model.isAuth:@"0",self.model.isOperatorAuth?self.model.isOperatorAuth:@"0",self.model.isPersonalAuth?self.model.isPersonalAuth:@"0",self.model.isWorkAuth?self.model.isWorkAuth:@"0"],@[self.model.isMailAuth?self.model.isMailAuth:@"0",self.model.isCreditAuth?self.model.isCreditAuth:@"0"]];
//            }
//            
//        }
//            break;
//        case StudentStyle:
//        {
//            if (_orderAuth) {
//                nameArr = @[@[@"实名认证",@"运营商认证",@"个人信息",@"学籍信息",@"影像信息"],@[@"邮箱认证",@"征信报告"]];
//                statesArr = @[@[self.model.isAuth?self.model.isAuth:@"0",self.model.isOperatorAuth?self.model.isOperatorAuth:@"0",self.model.isPersonalAuth?self.model.isPersonalAuth:@"0",self.model.isSchoolAuth?self.model.isSchoolAuth:@"0",@"0"],@[self.model.isMailAuth?self.model.isMailAuth:@"0",self.model.isCreditAuth?self.model.isCreditAuth:@"0"]];
//                
//            }else {
//                nameArr = @[@[@"实名认证",@"运营商认证",@"个人信息",@"学籍信息"],@[@"邮箱认证",@"征信报告"]];
//                statesArr = @[@[self.model.isAuth?self.model.isAuth:@"0",self.model.isOperatorAuth?self.model.isOperatorAuth:@"0",self.model.isPersonalAuth?self.model.isPersonalAuth:@"0",self.model.isSchoolAuth?self.model.isSchoolAuth:@"0"],@[self.model.isMailAuth?self.model.isMailAuth:@"0",self.model.isCreditAuth?self.model.isCreditAuth:@"0"]];
//            }
//            
//        }
//            break;
//        case FreeStyle:
//        {
//            if (_orderAuth) {
//                nameArr = @[@[@"实名认证",@"运营商认证",@"个人信息",@"家庭信息",@"影像信息"],@[@"邮箱认证",@"征信报告"]];
//                statesArr = @[@[self.model.isAuth?self.model.isAuth:@"0",self.model.isOperatorAuth?self.model.isOperatorAuth:@"0",self.model.isPersonalAuth?self.model.isPersonalAuth:@"0",self.model.isHomeAuth?self.model.isHomeAuth:@"0",@"0"],@[self.model.isMailAuth?self.model.isMailAuth:@"0",self.model.isCreditAuth?self.model.isCreditAuth:@"0"]];
//                
//            }else {
//                nameArr = @[@[@"实名认证",@"运营商认证",@"个人信息",@"家庭信息"],@[@"邮箱认证",@"征信报告"]];
//                statesArr = @[@[self.model.isAuth?self.model.isAuth:@"0",self.model.isOperatorAuth?self.model.isOperatorAuth:@"0",self.model.isPersonalAuth?self.model.isPersonalAuth:@"0",self.model.isHomeAuth?self.model.isHomeAuth:@"0"],@[self.model.isMailAuth?self.model.isMailAuth:@"0",self.model.isCreditAuth?self.model.isCreditAuth:@"0"]];
//            }
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//    self.statesArr = statesArr;
//    self.nameArr = nameArr;
//    
//}
//
//-(void)cheakCarrieroperatorCodeNumber:(NSString *)code statesWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : code?code:@"",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
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
//
//-(void)submitAdjustAmountWithReturnBlock:(ReturnValueBlock)returnBlock {
//    
//    NSDictionary *head = @{@"tradeCode" :@"0231" ,
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
//                                                         HXCreditLimitModel * creditModel = [HXCreditLimitModel mj_objectWithKeyValues:[object.body objectForKey:@"creditInfo"]];
//                                                         creditModel.remainedMoney = [object.body objectForKey:@"remainedMoney"]?[object.body objectForKey:@"remainedMoney"]:@"";
//                                                         creditModel.isActivate = [object.body objectForKey:@"isActivate"]?[object.body objectForKey:@"isActivate"]:@"";
//                                                         [[NSNotificationCenter defaultCenter] postNotificationName:Notification_CreditScore object:creditModel userInfo:nil];
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
//
//-(void)creditActivationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    
//    NSDictionary *head = @{@"tradeCode" : @"0230",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{
//                           @"userUuid":userUuid
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         HXCreditLimitModel * creditModel = [HXCreditLimitModel mj_objectWithKeyValues:[object.body objectForKey:@"creditInfo"]];
//                                                         creditModel.remainedMoney = [object.body objectForKey:@"remainedMoney"]?[object.body objectForKey:@"remainedMoney"]:@"";
//                                                         creditModel.isActivate = [object.body objectForKey:@"isActivate"]?[object.body objectForKey:@"isActivate"]:@"";
//                                                         [[NSNotificationCenter defaultCenter] postNotificationName:Notification_CreditScore object:creditModel userInfo:nil];
//                                                         returnBlock();
//                                                         
//                                                     }else {
//                                                         [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                     
//                                                 }];
//    
//    
//    
//}
//
//#pragma mark -- 替换文本状态文本
//-(void)replaceTitleWithTileBlock:(void(^)(NSString * title ,NSString * description,float titleHeight))block {
//    NSString * stateStr;
//    switch (self.states) {
//        case OrderStatuesCommen:
//        {
//            stateStr = @"认证资料";
//            self.hiddSubmitBtn = YES;
//        }
//            break;
//        case OrderStatuesPass:
//        {
//            stateStr = @"审核通过";
//            self.hiddSubmitBtn = YES;
//        }
//            break;
//        case OrderStatuesGoing:
//        {
//            stateStr = @"审核中…";
//            self.hiddSubmitBtn = NO;
//        }
//            break;
//        case OrderStatuesReplenish:
//        {
//            stateStr = @"补充资料";
//            self.hiddSubmitBtn = YES;
//        }
//            break;
//        case OrderStatuesDerate:
//        {
//            self.hiddSubmitBtn = YES;
//            if (block) {
//                block(@"审核通过",@"",0);
//            }
//        }
//            break;
//        default:
//            break;
//    }
//    if (stateStr.length!=0) {
//        
//        if (block) {
//            CGFloat height =  [Helper heightOfString:self.supplyDescription font:[UIFont systemFontOfSize:13] width:SCREEN_WIDTH-60];
//            if (height<20) {
//                
//                block(stateStr,self.supplyDescription,0);
//            }else {
//                block(stateStr,self.supplyDescription,height);
//            }
//        }
//    }
//    
//}
//@end
