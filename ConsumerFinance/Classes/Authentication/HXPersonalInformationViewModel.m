////
////  HXPersonalInformationViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/9.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXPersonalInformationViewModel.h"
//#import "PersonalInformationViewController.h"
//#import "FileManager.h"
//#import "AddressBookManager.h"
//@implementation HXPersonalInformationViewModel
//-(void)archiveinformationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0162",
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
//                                                        self.model = [HXPersonDetailModel mj_objectWithKeyValues:[object.body objectForKey:@"detail"]];
//                                                         self.contractListArr = [object.body objectForKey:@"contractList"];
//                                                         self.personalModel.certificationStr = self.model.identityTag ? [self identityWithTag:self.model.identityTag] :@"";
//                                                         [self identityStates:self.model.identityTag];
//                                                         self.personalModel.educationStr = self.model.education?[self educationTypeWithTag:self.model.education]:@"";
//                                                         self.personalModel.marriageStr = self.model.maritalStatus ? [self marriageWithTag:self.model.maritalStatus]:@"";
//                                                         self.personalModel.name = self.model.realName;
//                                                         self.personalModel.commenAddress = self.model.commonAddress;
//                                                         
//                                                         self.personalModel.provinceModel  = [[FileManager manager] getProvinceModel:self.model.provinceId];
//                                                         self.personalModel.cityModel = [[FileManager manager] getCityModel:self.model.cityId];
//                                                         if (self.personalModel.provinceModel.areaName.length !=0 ||self.personalModel.cityModel.areaName.length!=0) {
//                                                             
//                                                             self.personalModel.addressStr = [NSString stringWithFormat:@"%@ %@",self.personalModel.provinceModel.areaName?self.personalModel.provinceModel .areaName:@"",self.personalModel.cityModel.areaName?self.personalModel.cityModel.areaName:@""] ;
//                                                         }
//                                                         for (NSDictionary *dic in self.contractListArr) {
//                                                             [self contantFirstdic:dic];
//                                                         }
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
//
//
//-(void)submitPersonInformationWithReturnBlock:(ReturnValueBlock)returnBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0163",
//                           @"tradeType" : @"appService"};
//    NSString * typeNumber;
//    if ([[self identityWithName:self.personalModel.certificationStr] isEqualToString:@"01"]||[[self identityWithName:self.personalModel.certificationStr] isEqualToString:@"02"]) {
//        typeNumber = @"06";
//    }else if ([[self identityWithName:self.personalModel.certificationStr] isEqualToString:@"03"]){
//        typeNumber = @"05";
//    }else if ([[self identityWithName:self.personalModel.certificationStr] isEqualToString:@"04"]){
//        typeNumber = @"07";
//    }else {
//        typeNumber = @"";
//    }
//    NSDictionary *body = @{@"userId" : [[AppManager manager] userInfo].userId?[[AppManager manager] userInfo].userId:@"",
//                           @"education":self.personalModel.educationStr?[self educationTypeWithName:self.personalModel.educationStr]:@"",
//                           @"identityTag":[self identityWithName:self.personalModel.certificationStr],
//                           @"maritalStatus":[self marriageWithName:self.personalModel.marriageStr],
//                           @"cityId":self.personalModel.cityModel.areaCode?self.personalModel.cityModel.areaCode:@"",
//                           @"provinceId":self.personalModel.provinceModel.areaCode?self.personalModel.provinceModel.areaCode:@"",
//                           @"commonAddress":self.personalModel.commenAddress?self.personalModel.commenAddress:@"",
//                           @"contract":@[@{@"name":self.personalModel.firstName?self.personalModel.firstName:@"",
//                                           @"phoneNumber":self.personalModel.firstNumber?self.personalModel.firstNumber:@"",
//                                           @"type":[self contractTypeWithName:self.personalModel.firstSelctName]},
//                                         @{@"name":self.personalModel.secondName?self.personalModel.secondName:@"",
//                                           @"phoneNumber":self.personalModel.secondNumber?self.personalModel.secondNumber:@"",
//                                           @"type":typeNumber},
//                                         @{@"name":self.personalModel.thirdName?self.personalModel.thirdName:@"",
//                                           @"phoneNumber":self.personalModel.thirdNumber?self.personalModel.thirdNumber:@"",
//                                           @"type":@"07"},
//                                         
//                                ]
//                           
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.model = [HXPersonDetailModel mj_objectWithKeyValues:[object.body objectForKey:@"detail"]];
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
//- (void)postToServer{
//    
//    __block NSArray *contact = [NSArray array];
//    /*
//     NSString * push = [[NSUserDefaults standardUserDefaults] objectForKey:@"pullFlag"];
//     
//     if ([push isEqualToString:@"1"]) {
//     contact = nil;
//     
//     }else{
//     [[AddressBookManager manager] getAddressBookContent:^(NSDictionary *addressBook) {
//     contact = addressBook[@"contacts"];
//     }];
//     }
//     
//     */
//    
//    [[AddressBookManager manager] getAddressBookContent:^(NSDictionary *addressBook) {
//        contact = addressBook[@"contacts"];
//    }];
//    
//    NSDictionary *head = @{@"tradeCode"                     : @"0139",
//                           @"tradeType"                     : @"appService"};
//    /*
//     NSDictionary *body = contact ? @{@"userUuid"                      : user.  Uuid,
//     @"orderNo"                       : self.orderInfo.orderNo ?: @"",
//     @"pullInfo"                      : contact ?: @"",
//     @"gpsCode"                       : location ?: @""
//     } : @{@"userUuid"                      : userUuid,
//     @"orderNo"                       : self.orderInfo.orderNo ?: @"",
//     @"gpsCode"                       : location ?: @""
//     };
//     */
//    NSDictionary *body =  @{@"userUuid"  : userUuid,
//                                                    @"contacts"  : contact ?: @""
//                                                    };
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         
//                                                        
//                                                         
//                                                     }
//                                                     
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                    
//                                            
//                                                     
//                                                 }];
//    
//    
//}
//
//
//
//-(void)identityStates:(NSString *)tag {
//    NSArray * arr;
//    if ([tag isEqualToString:@"01"]) {
//        arr = @[@"同事",@"朋友"];
//    }else if ([tag isEqualToString:@"02"]) {
//        arr = @[@"同事",@"朋友"];
//    }else if ([tag isEqualToString:@"03"]) {
//        arr = @[@"同学"];
//    }else if ([tag isEqualToString:@"04"]) {
//        arr = @[@"朋友"];
//    }else {
//        arr = @[@"同事",@"朋友"];
//    }
//    self.identityArr = arr;
//}
//#pragma mark -- 根据id查询对应名称
//-(NSString *)identityWithTag:(NSString *)tag {
//    if ([tag isEqualToString:@"01"]) {
//        return @"企业主";
//    }else if ([tag isEqualToString:@"02"]) {
//        return @"上班族";
//    }else if ([tag isEqualToString:@"03"]) {
//        return @"学生党";
//    }else if ([tag isEqualToString:@"04"]) {
//        return @"自由职业者";
//    }else {
//        return @"";
//    }
//    
//}
//-(NSString *)marriageWithTag:(NSString *)tag {
//    if ([tag isEqualToString:@"10"]) {
//        return @"已婚";
//    }else if ([tag isEqualToString:@"20"]) {
//        return @"未婚";
//    }else if ([tag isEqualToString:@"21"]) {
//        return @"离异";
//    }else if ([tag isEqualToString:@"25"]) {
//        return @"丧偶";
//    }else if ([tag isEqualToString:@"30"]) {
//        return @"再婚";
//    }else {
//        return @"";
//    }
//}
//
//-(NSString *)identityWithName:(NSString *)name {
//    if ([name isEqualToString:@"企业主"]) {
//        return @"01";
//    }else if ([name isEqualToString:@"上班族"]) {
//        return @"02";
//    }else if ([name isEqualToString:@"学生党"]) {
//        return @"03";
//    }else if ([name isEqualToString:@"自由职业者"]) {
//        return @"04";
//    }else {
//        return @"";
//    }
//}
//
//-(NSString *)marriageWithName:(NSString *)name {
//    if ([name isEqualToString:@"已婚"]) {
//        return @"10";
//    }else if ([name isEqualToString:@"未婚"]) {
//        return @"20";
//    }else if ([name isEqualToString:@"离异"]) {
//        return @"21";
//    }else if ([name isEqualToString:@"丧偶"]) {
//        return @"25";
//    }else if ([name isEqualToString:@"再婚"]) {
//        return @"30";
//    }else {
//        return @"";
//    }
//}
///// 父亲"01"// 母亲"02"// 配偶 "03"// 子女"04"// 兄妹"08"// 同学"05"// 同事"06"// 朋友"07"
//-(NSString *)contractTypeWithTag:(NSString *)tag {
//    if ([tag isEqualToString:@"01"]) {
//        return @"父亲";
//    }else if ([tag isEqualToString:@"02"]) {
//        return @"母亲";
//    }else if ([tag isEqualToString:@"03"]) {
//        return @"配偶";
//    }else if ([tag isEqualToString:@"04"]) {
//        return @"子女";
//    }else if ([tag isEqualToString:@"08"]) {
//        return @"兄妹";
//    }else if ([tag isEqualToString:@"05"]) {
//        return @"同学";
//    }else if ([tag isEqualToString:@"06"]) {
//        return @"同事";
//    }else if ([tag isEqualToString:@"07"]) {
//        return @"朋友";
//    }else {
//        return @"";
//    }
//    
//}
//-(NSString *)contractTypeWithName:(NSString *)name {
//    if ([name isEqualToString:@"父亲"]) {
//        return @"01";
//    }else if ([name isEqualToString:@"母亲"]) {
//        return @"02";
//    }else if ([name isEqualToString:@"配偶"]) {
//        return @"03";
//    }else if ([name isEqualToString:@"子女"]) {
//        return @"04";
//    }else if ([name isEqualToString:@"兄妹"]) {
//        return @"08";
//    }else if ([name isEqualToString:@"同学"]) {
//        return @"05";
//    }else if ([name isEqualToString:@"同事"]) {
//        return @"06";
//    }else if ([name isEqualToString:@"朋友"]) {
//        return @"07";
//    }else {
//        return @"";
//    }
//    
//}
//
//-(NSString *)educationTypeWithName:(NSString *)name {
//    if ([name isEqualToString:@"大专以下"]) {
//        return @"1";
//    }else if ([name isEqualToString:@"大专"]) {
//        return @"2";
//    }else if ([name isEqualToString:@"本科"]) {
//        return @"3";
//    }else if ([name isEqualToString:@"研究生及以上"]) {
//        return @"4";
//    }else {
//        return @"";
//    }
//    
//}
//-(NSString *)educationTypeWithTag:(NSString *)tag {
//    if ([tag isEqualToString:@"1"]) {
//        return @"大专以下";
//    }else if ([tag isEqualToString:@"2"]) {
//        return @"大专";
//    }else if ([tag isEqualToString:@"3"]) {
//        return @"本科";
//    }else if ([tag isEqualToString:@"4"]) {
//        return @"研究生及以上";
//    }else {
//        return @"";
//    }
//    
//}
//
//
//-(void)contantFirstdic:(NSDictionary *)dic{
//    if (dic == nil) {
//        return;
//    }
//    NSString * contract = [self contractTypeWithTag:[dic objectForKey:@"type"]];
//    NSArray * nameArr = @[@"兄妹",@"子女",@"配偶",@"母亲",@"父亲"];
//    if ([nameArr containsObject:contract]) {
//        self.personalModel.firstNumber = [dic objectForKey:@"phoneNumber"];
//        self.personalModel.firstName =[dic objectForKey:@"name"];
//        self.personalModel.firstSelctName = contract;
//    }
//    if ([self.model.identityTag isEqualToString:@"01"] ||[self.model.identityTag isEqualToString:@"02"]) {
//        if([contract isEqualToString:@"同事"]){
//            self.personalModel.secondNumber = [dic objectForKey:@"phoneNumber"];
//            self.personalModel.secondName =[dic objectForKey:@"name"];
//            
//        }else if([contract isEqualToString:@"朋友"]) {
//            self.personalModel.thirdNumber = [dic objectForKey:@"phoneNumber"];
//            self.personalModel.thirdName =[dic objectForKey:@"name"];
//            
//        }
//    }
//    if ([self.model.identityTag isEqualToString:@"03"]) {
//        if([contract isEqualToString:@"同学"]){
//            self.personalModel.secondNumber = [dic objectForKey:@"phoneNumber"];
//            self.personalModel.secondName =[dic objectForKey:@"name"];
//            
//        }
//    }
//    if ([self.model.identityTag isEqualToString:@"04"]) {
//        if([contract isEqualToString:@"朋友"]){
//            self.personalModel.secondNumber = [dic objectForKey:@"phoneNumber"];
//            self.personalModel.secondName =[dic objectForKey:@"name"];
//            
//        }
//    }
//    
//}
//#pragma mark -- setter and getter
//
//-(HXPersonalModel *)personalModel {
//    if (_personalModel==nil) {
//        _personalModel = [[HXPersonalModel alloc] init];
//        _personalModel.firstSelctName = @"父亲";
//    }
//    return _personalModel;
//}
//@end
