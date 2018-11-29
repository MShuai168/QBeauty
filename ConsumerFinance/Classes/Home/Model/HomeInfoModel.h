//
//  HomeInfoModel.h
//  ConsumerFinance
//
//  Created by Jney on 16/8/17.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeInfoModel : NSObject
@property (nonatomic,strong) NSString *remainedMoney;
@property (nonatomic,strong) NSString *nextRepayDate;
@property (nonatomic,strong) NSString *nextPayMoney;
@property (nonatomic,strong) NSString *mayApply;//订单可申请标识

@end
