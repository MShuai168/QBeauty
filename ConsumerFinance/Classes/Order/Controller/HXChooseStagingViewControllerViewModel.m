////
////  HXChooseStagingViewControllerViewModel.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/25.
////  Copyright © 2017年 Hou. All rights reserved.
//
//#import "HXChooseStagingViewControllerViewModel.h"
//#import "HXStagingInfoModel.h"
//
//@interface HXChooseStagingViewControllerViewModel()
//
//@property (nonatomic, strong, readwrite) NSMutableArray *stagePeriods;
//@property (nonatomic, strong) HXStagingInfoModel *inforModel;
//
//@end
//
//@implementation HXChooseStagingViewControllerViewModel
//
//- (instancetype)init {
//    if (self == [super init]) {
//        _stagePeriods = [[NSMutableArray alloc] init];
//    }
//    return self;
//}
//
//- (void)getOrderStage:(returnValue)returnValue withFailureBlock:(FailureBlock)failureBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0177",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"orderId" : self.orderId
//                           };
//    [MBProgressHUD showMessage:nil toView:nil];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.inforModel = [HXStagingInfoModel mj_objectWithKeyValues:object.body];
//                                                         if (self.inforModel) {
//                                                             self.stageAmount = [self.inforModel.stagesMoney floatValue];
//                                                             self.oneTimeFee = [self.inforModel.serviceCharge floatValue];
//                                                             [_stagePeriods addObjectsFromArray:self.inforModel.voList];
//                                                             self.credits = self.inforModel.creditScore;
//                                                             self.creditType = self.inforModel.creditType;
//                                                             
//                                                             if (returnValue) {
//                                                                 returnValue();
//                                                             }
//                                                         }
//                                                     }
//                                                     
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     if (failureBlock) {
//                                                         failureBlock();
//                                                     }
//                                                 }];
//}
//
//- (void)nextOrder:(returnValue)returnValue withFailureBlock:(FailureBlock)failureBlock {
//    NSDictionary *head = @{@"tradeCode" : @"0178",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"orderId" : self.inforModel.orderId,
//                           @"serviceCharge" : self.inforModel.serviceCharge,
//                           @"riskMargin" : self.inforModel.riskMargin,
//                           @"rate" : self.selectedStagingModel.rate,
//                           @"loamTerm" : self.selectedStagingModel.loamTerm,
//                           @"freePeriod" : self.selectedStagingModel.freePeriod,
//                           @"merAnshuoId":self.inforModel.merAnshuoId
//                           };
//    [MBProgressHUD showMessage:nil toView:nil];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
//                                                         self.orderInfo.yfqStatus = yfqStatus;
//                                                         if (returnValue) {
//                                                             returnValue();
//                                                         }
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     if (failureBlock) {
//                                                         failureBlock();
//                                                     }
//                                                 }];
//}
//
//@end
