//
//  PrepaidCardModel.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/31.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "PrepaidCardModel.h"

//储值卡列表
@implementation PrepaidCardModel
+ (id)initWithDictionary:(NSDictionary *)dict {
    PrepaidCardModel *model = [[PrepaidCardModel alloc] init];
    model.money = dict[@"money"];
    model.cardId = dict[@"cardId"];
    model.shopName = dict[@"shopName"];
    model.expired_time = [dict[@"expired_time"] integerValue];
    model.imgUrl = dict[@"imgUrl"];
    model.purchaseTime = [dict[@"purchaseTime"] integerValue];
    return model;
}
@end



//计次卡列表
@implementation MeteringCardModel
+ (id)initWithDictionary:(NSDictionary *)dict {
    MeteringCardModel *model = [[MeteringCardModel alloc] init];
    model.id = [dict[@"id"] intValue];
    model.cardName = dict[@"cardName"];
    model.shopName = dict[@"shopName"];
    model.expiredTime = dict[@"expiredTime"];
    model.imgUrl = dict[@"imgUrl"];
    return model;
}
@end


//计次卡详情
@implementation MeteringCardDetailModel
+ (id)initWithDictionary:(NSDictionary *)dict {
    MeteringCardDetailModel *model = [[MeteringCardDetailModel alloc] init];
    model.projectName = dict[@"projectName"];
    model.totalTime = [dict[@"totalTime"] intValue];
    model.surTime = [dict[@"surTime"] intValue];
    return model;
}
@end
