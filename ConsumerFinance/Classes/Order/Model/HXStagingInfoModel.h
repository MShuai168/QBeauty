//
//  HXStagingInfoModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXStagingInfoModel : NSObject

@property (nonatomic, strong) NSString *orderId; // 订单id
@property (nonatomic, strong) NSString *stagesMoney; // 分期金额
@property (nonatomic, strong) NSString *riskMargin; // 服务费率
@property (nonatomic, strong) NSString *serviceCharge; // 服务费
@property (nonatomic, strong) NSArray *voList; // 分期金额集合
@property (nonatomic, strong) NSString *merAnshuoId; // 安硕id
@property (nonatomic, strong) NSString *creditType; // 额度类型(10:专项额度,20:信用额度)
@property (nonatomic, strong) NSString *creditScore; // 额度分

@end

@interface HXStagingDetailModel: NSObject

@property (nonatomic, strong) NSString *rate; // 利率
@property (nonatomic, strong) NSString *loamTerm; // 选择期数
@property (nonatomic, strong) NSString *repaymentByMonth; // 月供
@property (nonatomic, strong) NSString *freePeriod; // 贴息期数

@end
