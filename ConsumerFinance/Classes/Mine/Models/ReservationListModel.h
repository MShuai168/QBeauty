//
//  ReservationListModel.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/20.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReservationListModel : NSObject
@property (nonatomic, assign) int id;
//@property (nonatomic, copy) NSString *serviceName; //预约服务名称
@property (nonatomic, copy) NSString *reserveStatusName;//预约状态
@property (nonatomic, assign) NSInteger gmtStart;  //预约开始时间
@property (nonatomic, copy) NSString *shopName;  //预约店铺名称

+ (id)initWithDictionary:(NSDictionary *)dict;
@end


@interface ReservationDetailModel : NSObject
@property (nonatomic, copy) NSString *productName;  //产品或服务名称
@property (nonatomic, copy) NSString *productImage; //产品或服务图片地址
@property (nonatomic, assign) CGFloat price;   //预约开始时间

+ (id)initWithDictionary:(NSDictionary *)dict;
@end
