////
////  HXImageViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/8/22.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXImageViewModel.h"
//@interface HXImageViewModel()
//@property (nonatomic,assign)BOOL sfBool;//首付凭证
//@property (nonatomic,assign)BOOL xsBool;//销售凭证
//@property (nonatomic,assign)BOOL identyBool;//身份证明
//@property (nonatomic,assign)BOOL schoolBool;//学籍
//@property (nonatomic,assign)BOOL workBool;//工作
//@property (nonatomic,assign)BOOL clBool;//财力
//@property (nonatomic,assign)BOOL lsBool;//个人流水
//@end
//@implementation HXImageViewModel
//#pragma mark -- setter
//-(NSMutableArray *)nameArr {
//    if (_nameArr == nil) {
//        NSMutableArray * arr = [[NSMutableArray alloc] initWithObjects:@"销售凭证",@"身份证明", nil];
//        switch (self.style) {
//            case DefaultStyle:
//            {
//                
//            }
//                break;
//            case WorkStyle:{
//                
//            }
//                break;
//            case StudentStyle:{
//               [arr addObject:@"学籍证明"];
//            }
//                break;
//            case FreeStyle: {
//                
//            }
//                break;
//            default:
//                break;
//        }
//        if ([self.firstPayment doubleValue]>0) {
//            [arr insertObject:@"首付凭证" atIndex:0];
//        }
//        _nameArr = [[NSMutableArray alloc] initWithObjects:arr,@[@"工作证明",@"财力证明",@"个人流水"], nil];
//        
//    }
//    return _nameArr;
//}
//
//-(void)archiveUploadStates:(BaseTableViewCell *)cell {
//    
//    if ([cell.nameLabel.text isEqualToString:@"首付凭证"]) {
//        cell.titleLabel.text = self.sfBool?@"已上传":@"待上传";
//    }else if ([cell.nameLabel.text isEqualToString:@"销售凭证"]){
//        cell.titleLabel.text = self.xsBool?@"已上传":@"待上传";
//    }else if ([cell.nameLabel.text isEqualToString:@"身份证明"]){
//        cell.titleLabel.text = self.identyBool?@"已上传":@"待上传";
//    }else if ([cell.nameLabel.text isEqualToString:@"学籍证明"]){
//        cell.titleLabel.text = self.schoolBool?@"已上传":@"待上传";
//    }else if ([cell.nameLabel.text isEqualToString:@"工作证明"]){
//        cell.titleLabel.text = self.workBool?@"已上传":@"待上传";
//    }else if ([cell.nameLabel.text isEqualToString:@"财力证明"]){
//        cell.titleLabel.text = self.clBool?@"已上传":@"待上传";
//    }else if ([cell.nameLabel.text isEqualToString:@"个人流水"]){
//        cell.titleLabel.text = self.lsBool?@"已上传":@"待上传";
//    }else {
//        
//        cell.titleLabel.text = @"待上传";
//        
//    }
//}
//
//-(void)archivePhotoStatesWithReturnBlock:(ReturnValueBlock)returnBlock {
//    
//    NSDictionary *head = @{@"tradeCode" : @"0242",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"userUuid" : userUuid,
//                           @"orderNo":self.orderNumber.length!=0?self.orderNumber:@""
//                           };
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.sfBool = [[object.body objectForKey:@"firstPayStatus"] boolValue];
//                                                         self.xsBool = [[object.body objectForKey:@"saleStatus"] boolValue];
//                                                         self.identyBool = [[object.body objectForKey:@"idCardStatus"] boolValue];
//                                                         self.schoolBool = [[object.body objectForKey:@"schoolStatus"] boolValue];
//                                                         
//                                                         self.workBool = [[object.body objectForKey:@"workStatus"] boolValue];
//                                                         self.clBool = [[object.body objectForKey:@"moneyStatus"] boolValue];
//                                                         self.lsBool = [[object.body objectForKey:@"flowStatus"] boolValue];
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
//
//@end
