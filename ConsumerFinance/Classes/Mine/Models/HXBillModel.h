//
//  HXBillModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBillModel : NSObject
@property (nonatomic,strong)NSString * name;//上部名称
@property (nonatomic,strong)NSString * refundDate;//还款时间
@property (nonatomic,strong)NSString * money;//金额
@property (nonatomic,strong)NSString * detail;//右下方红字
@property (nonatomic,strong)NSString * currentPeriods;//例如：1/4期
@property (nonatomic,strong)NSString * orderNo;//订单号
@end
