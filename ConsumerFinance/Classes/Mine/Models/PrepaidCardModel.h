//
//  PrepaidCardModel.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/31.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

//储值卡列表
@interface PrepaidCardModel : NSObject
@property (nonatomic, copy) NSString *money;  //金额
@property (nonatomic, copy) NSString *cardId;  //卡id
@property (nonatomic, copy) NSString *shopName;  //门店名称
@property (nonatomic, assign) NSInteger expired_time; //到期时间
@property (nonatomic, copy) NSString *imgUrl;  //储值卡背景图
@property (nonatomic, assign) NSInteger purchaseTime;  //购买时间
+ (id)initWithDictionary:(NSDictionary *)dict;
@end


//计次卡列表
@interface MeteringCardModel : NSObject
@property (nonatomic, assign) int id;  //卡id
@property (nonatomic, copy) NSString *cardName;  //卡名
@property (nonatomic, copy) NSString *shopName;  //门店名称
@property (nonatomic, copy) NSString *expiredTime; //到期时间
@property (nonatomic, copy) NSString *imgUrl;  //次卡背景图
+ (id)initWithDictionary:(NSDictionary *)dict;
@end


//计次卡详情
@interface MeteringCardDetailModel : NSObject
@property (nonatomic, copy) NSString *projectName;  //产品名称
@property (nonatomic, assign) int totalTime;  //总次数
@property (nonatomic, assign) int surTime; //剩余次数
+ (id)initWithDictionary:(NSDictionary *)dict;
@end

