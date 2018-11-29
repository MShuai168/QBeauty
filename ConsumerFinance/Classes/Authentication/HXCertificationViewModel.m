////
////  HXCertificationViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/9.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXCertificationViewModel.h"
//#import "STAPIAccountInfo.h"
//
//#import <UMMobClick/MobClick.h>
//
//@implementation HXCertificationViewModel
//-(void)archiveCertificationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0161",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"orderNo":self.orderNo.length!=0?self.orderNo:@""
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.certifiModel = [HXCertificationModel mj_objectWithKeyValues:[object.body objectForKey:@"user"]];
//                                                         if ([object.body objectForKey:@"cardImg"]) {
//                                                             
//                                                             self.photoArr = [object.body objectForKey:@"cardImg"];
//                                                         }
//                                                         returnBlock();
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     
//                                                 }];
//}
//
//-(void)submitCertificationWithName:(NSString *)name idcard:(NSString*)idcard  returnBlock:(ReturnValueBlock)returnBlock{
//    NSDictionary *head = @{@"tradeCode" : @"0105",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"idCard" :idcard.length!=0?idcard:@"",
//                           @"realName" :name.length!=0?name:@"",
//                           @"validPeriod" :@"",
//                           @"issuingAuthority" :@"",
//                           };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.certifiModel = [HXCertificationModel mj_objectWithKeyValues:[object.body objectForKey:@"user"]];
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
//
//#pragma mark -- 判断名字身份证是否匹配
//-(void)cheakNameAndIdWithName:(NSString *)name idcard:(NSString*)idcard ReturnValue:(ReturnValueBlock)returenValueBlock {
//    
//    NSDictionary * dic = @{@"api_id":ACCOUNT_API_ID,
//                           @"api_secret":ACCOUNT_API_SECRET,
//                           @"id_number" :idcard,
//                           @"name":name
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithBodyParameter:dic url:@"https://v1-auth-api.visioncloudapi.com/police/idnumber_verification" success:^(id responseObject) {
//        [MobClick event:Event_name_authentication_success];
//        if ([[responseObject objectForKey:@"validity"] boolValue]) {
//            returenValueBlock();
//        }else {
//            [MBProgressHUD hideHUDForView:self.controller.view];
//            if (responseObject) {
//                if ([[responseObject objectForKey:@"reason"] isEqualToString:@"Gongan photo doesn’t exist"]) {
//                    [KeyWindow displayMessage:@"公安预存照片不存在"];
//                }else if([[responseObject objectForKey:@"reason"] isEqualToString:@"Name and idcard number doesn’t match"]) {
//                    
//                    [KeyWindow displayMessage:@"姓名与身份证号码不匹配"];
//                    
//                }else if([[responseObject objectForKey:@"reason"] isEqualToString:@"Invalid idcard number"]) {
//                    
//                    [KeyWindow displayMessage:@"非法身份证号码"];
//                    
//                }else {
//                    
//                    [KeyWindow displayMessage:@"身份证与姓名匹配异常"];
//                }
//            }
//        }
//        
//    } fail:^(ErrorModel *error) {
//        [MBProgressHUD hideHUDForView:self.controller.view];
//    }];
//    
//}
//
//
///*!
// * @brief 把字典转换成格式化的JSON格式的字符串
// * @param dic 字典
// * @param insert 是否插入"\"
// * @return 返回JSON格式的字符串
// */
//- (NSString *)jsonStringWithDictionary:(NSArray *)arr insert:(BOOL)insert{
//    
//    if (arr == nil) {
//        return @"";
//    }
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
//    
//    if(error) {
////        NSLog(@"dictionary解析失败：%@",error);
//        return @"";
//    }
//    
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    if (!insert) return jsonString;
//    
//    NSString *json = [jsonString copy];
//    
//    for (NSInteger i = 0, j = 0; i < [jsonString length]; i++) {
//        
//        NSString *s = [jsonString substringWithRange:NSMakeRange(i, 1)];
//        
//        if ([s isEqualToString:@"\""]) {
//            
//            NSRange range = NSMakeRange(i + j, 1);
//            
//            json = [json stringByReplacingCharactersInRange:range withString:@"\\\""];
//            
//            j++;
//        }
//    }
//    return json;
//}
//@end
