//
//  HomeDetailActivityModel.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDetailActivityModel : NSObject

@property (nonatomic, assign) int id;  //活动ID
@property (nonatomic, copy) NSString *icon;  //活动icon
@property (nonatomic, copy) NSString *name; //活动名称
@property (nonatomic, copy) NSString *tag; //特色标签，多个标签用英文逗号隔开

+ (id)initWithDictionary:(NSDictionary *)dict;

@end



@interface HomeActivityDetailModel : NSObject

@property (nonatomic, copy) NSString *imgUrl;  //图片url

+ (id)initWithDictionary:(NSDictionary *)dict;

@end




@interface ActivityDetailSecondModel : NSObject

@property (nonatomic, assign) NSInteger beginTime;  //活动开始时间戳
@property (nonatomic, assign) NSInteger overTime;  //活动截止时间戳
@property (nonatomic, copy) NSString *serviceContent;  //服务内容
@property (nonatomic, copy) NSString *instructions;  //使用说明

+ (id)initWithDictionary:(NSDictionary *)dict;

@end


