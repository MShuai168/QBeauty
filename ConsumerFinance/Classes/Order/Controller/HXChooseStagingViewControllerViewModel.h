////
////  HXChooseStagingViewControllerViewModel.h
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/25.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "HXStagingInfoModel.h"
//#import "HXBaseViewModel.h"
//
//typedef void(^returnValue)(void);
//
//@interface HXChooseStagingViewControllerViewModel : HXBaseViewModel
//
//@property (nonatomic, assign) NSString *credits; // 信用额度
//@property (nonatomic, strong) NSString *creditType; //额度类型(10:专项额度,20:信用额度)
//@property (nonatomic, strong) NSString *orderId; // 壹分期后台订单id，不是安硕返回的订单id
//
//@property (nonatomic, assign) CGFloat stageAmount; // 分期金额
//@property (nonatomic, strong, readonly) NSArray *stagePeriods; // 分期期数
//@property (nonatomic, assign) CGFloat oneTimeFee; // 一起行服务费
//@property (nonatomic, strong) HXStagingDetailModel *selectedStagingModel; // 选择的期数
//
//- (void)getOrderStage:(returnValue)returnValue withFailureBlock:(FailureBlock) failureBlock;
//
//- (void)nextOrder:(returnValue)returnValue withFailureBlock:(FailureBlock) failureBlock;
//
//@end
