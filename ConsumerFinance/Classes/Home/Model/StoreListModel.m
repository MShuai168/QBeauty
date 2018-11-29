//
//  StoreListModel.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/29.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "StoreListModel.h"

@implementation StoreListModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    StoreListModel *model = [[StoreListModel alloc] init];
    
    model.id = [dict[@"id"] intValue];
    model.logo = dict[@"logo"];
    model.shopName = dict[@"shopName"];
    model.address = dict[@"address"];
    model.tel = dict[@"tel"];
    model.startTime = dict[@"startTime"];
    model.endTime = dict[@"endTime"];
    model.distanceStr = dict[@"distanceStr"];
    
    return model;
}

@end
