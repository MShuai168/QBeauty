//
//  StoreOrderListModel.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/30.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "StoreOrderListModel.h"

@implementation StoreOrderListModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    StoreOrderListModel *model = [[StoreOrderListModel alloc] init];
    
    model.id = [dict[@"id"] intValue];
    model.gmtCreate = [dict[@"gmtCreate"] integerValue];
    model.shopName = dict[@"shopName"];
    model.productName = dict[@"productName"];
    model.realFee = [dict[@"realFee"] floatValue];
    model.orderStatusName = dict[@"orderStatusName"];
//    model.productNum = [dict[@"productNum"] intValue];
    
    return model;
}

@end



@implementation StoreOrderDetailModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    StoreOrderDetailModel *model = [[StoreOrderDetailModel alloc] init];
    model.productName = dict[@"productName"];
    model.salesCount = [dict[@"salesCount"] intValue];
    model.price = [dict[@"price"] floatValue];
    model.isTk = [dict[@"isTk"] boolValue];
    model.tkCount = [dict[@"tkCount"] intValue];
//    model.isFree = [dict[@"isFree"] boolValue];
    
    return model;
}

@end
