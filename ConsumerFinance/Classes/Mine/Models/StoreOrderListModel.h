//
//  StoreOrderListModel.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/30.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreOrderListModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, assign) NSInteger gmtCreate;  //下单时间
@property (nonatomic, copy) NSString *shopName;  //门店名称
@property (nonatomic, copy) NSString *productName; //产品名称
@property (nonatomic, assign) CGFloat realFee;  //订单金额
@property (nonatomic, copy) NSString *orderStatusName; //订单状态名称
//@property (nonatomic, assign) int productNum; //产品数量

+ (id)initWithDictionary:(NSDictionary *)dict;

@end


@interface StoreOrderDetailModel : NSObject
@property (nonatomic, copy) NSString *productName; //产品名称
@property (nonatomic, assign) int salesCount; //购买数量
@property (nonatomic, assign) CGFloat price; //单价
@property (nonatomic, assign) BOOL isTk;  //是否退款
@property (nonatomic, assign) int tkCount; //退款数量
//@property (nonatomic, assign) BOOL isFree; //是否赠送 1是0否

+ (id)initWithDictionary:(NSDictionary *)dict;

@end
