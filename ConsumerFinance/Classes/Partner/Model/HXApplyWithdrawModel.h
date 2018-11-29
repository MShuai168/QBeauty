//
//  HXApplyWithdrawModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/5.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXApplyWithdrawModel : NSObject
@property (nonatomic,strong)NSString * bankName;
@property (nonatomic,strong)NSString * cardNo;
@property (nonatomic,strong)NSString * balance;
@property (nonatomic,strong)NSString * accountName;
@property (nonatomic,strong)NSString * branch;
@property (nonatomic,strong)NSString * minMoney;//最小提现金额
@end
