//
//  HXRepaymentModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXRepaymentModel : NSObject
@property (nonatomic,strong)NSString * orderNo; //订单号
@property (nonatomic,strong)NSString * currentPeriods; //期次
@property (nonatomic,strong)NSString * tradeAmount;//金额
@property (nonatomic,strong)NSString * createdAt;//时间
@property (nonatomic,strong)NSString * refundType;//还款类型0000(app一般还款),0001(app提前还款)
@property (nonatomic,strong)NSString * refundStatus;//还款状态（0,失败1成功）
@property (nonatomic,strong)NSString * bankId;
@end
