//
//  ReservationListModel.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/20.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "ReservationListModel.h"

@implementation ReservationListModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    ReservationListModel *model = [[ReservationListModel alloc] init];
    model.id = [dict[@"id"] intValue];
//    model.serviceName = dict[@"serviceName"];
    model.reserveStatusName = dict[@"reserveStatusName"];
    model.gmtStart = [dict[@"gmtStart"] integerValue];
    model.shopName = dict[@"shopName"];
    return model;
}

@end



@implementation ReservationDetailModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    ReservationDetailModel *model = [[ReservationDetailModel alloc] init];
    model.productName = dict[@"productName"];
    model.productImage = dict[@"productImage"];
    model.price = [dict[@"price"] floatValue];
    return model;
}

@end
