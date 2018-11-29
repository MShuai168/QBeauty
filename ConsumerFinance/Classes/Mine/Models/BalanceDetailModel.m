//
//  BalanceDetailModel.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/31.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "BalanceDetailModel.h"

@implementation BalanceDetailModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    BalanceDetailModel *model = [[BalanceDetailModel alloc] init];
    model.created = [dict[@"created"] integerValue];
    model.changeAmount = dict[@"changeAmount"];
    model.changeSource = dict[@"changeSource"];
    model.type = [dict[@"type"] intValue];
    return model;
}

@end
