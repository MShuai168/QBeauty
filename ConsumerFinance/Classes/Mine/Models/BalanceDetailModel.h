//
//  BalanceDetailModel.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/31.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceDetailModel : NSObject

@property (nonatomic, assign) NSInteger created; //时间
@property (nonatomic, copy) NSString *changeAmount;  //变更金额
@property (nonatomic, copy) NSString *changeSource; //变更来源
@property (nonatomic, assign) int type; //类型

+ (id)initWithDictionary:(NSDictionary *)dict;

@end
