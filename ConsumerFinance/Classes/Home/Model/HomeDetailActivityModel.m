//
//  HomeDetailActivityModel.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HomeDetailActivityModel.h"

@implementation HomeDetailActivityModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    HomeDetailActivityModel *model = [[HomeDetailActivityModel alloc] init];
    model.id = [dict[@"id"] intValue];
    model.name = dict[@"name"];
    model.icon = dict[@"icon"];
    model.tag = dict[@"tag"];
    return model;
}

@end


@implementation HomeActivityDetailModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    HomeActivityDetailModel *model = [[HomeActivityDetailModel alloc] init];
    model.imgUrl = dict[@"imgUrl"];
    return model;
}

@end


@implementation ActivityDetailSecondModel

+ (id)initWithDictionary:(NSDictionary *)dict {
    ActivityDetailSecondModel *model = [[ActivityDetailSecondModel alloc] init];
    model.beginTime = [dict[@"beginTime"] integerValue];
    model.overTime = [dict[@"overTime"] integerValue];
    model.serviceContent = dict[@"serviceContent"];
    model.instructions = dict[@"instructions"];
    return model;
}

@end

