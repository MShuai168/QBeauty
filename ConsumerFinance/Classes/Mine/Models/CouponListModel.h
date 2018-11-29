//
//  CouponListModel.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/31.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponListModel : NSObject

@property (nonatomic, assign) int id;  //优惠券id
@property (nonatomic, copy) NSString *benefit;  //金额
@property (nonatomic, copy) NSString *couponName;  //优惠券名称
@property (nonatomic, copy) NSString *effectiveTime;  //有效时间
@property (nonatomic, copy) NSString *sytjName;   //使用条件
@property (nonatomic, copy) NSString *type; //优惠券类型：S_YHQLX_ZK-折扣优惠券、S_YHQLX_HB-红包优惠券

+ (id)initWithDictionary:(NSDictionary *)dict;

@end
