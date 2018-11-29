//
//  HXMyNumberModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/10.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXMyNumberModel : NSObject
@property (nonatomic,strong)NSString * billNum;//账单数
@property (nonatomic,strong)NSString * deliveredNum;//待收货订单数
@property (nonatomic,strong)NSString * deliveringNum;//待发货订单数
@property (nonatomic,strong)NSString *  evaluateNum;//评价数
@property (nonatomic,strong)NSString *  mallOrderNum;//趣淘订单数
@property (nonatomic,strong)NSString *  orderNum;//订单数
@property (nonatomic,strong)NSString *  obligationNum;//待支付订单数
@property (nonatomic,strong)NSString *  reservationNum;//预约数
@property (nonatomic,strong)NSString * noticeNum;

@property (nonatomic, copy) NSString *couponNum; //优惠券数目
@property (nonatomic, copy) NSString *accountCardNum; //计次卡数目
@property (nonatomic, copy) NSString *valueCardNum; //储值卡数目
//@property (nonatomic, copy) NSString *mdNum; //门店订单数目
@property (nonatomic, assign) CGFloat balance;  //余额

@end
