//
//  CouponListModel.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/31.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "CouponListModel.h"

@implementation CouponListModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    CouponListModel *model = [[CouponListModel alloc] init];
    model.benefit = dict[@"benefit"];
    model.id = [dict[@"id"] intValue];
    model.couponName =  dict[@"couponName"];
    model.effectiveTime = dict[@"effectiveTime"];
    model.sytjName = dict[@"sytjName"];
    model.type = dict[@"type"];
    return model;
}

@end
