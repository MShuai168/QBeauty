//
//  HXRecordDetailModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXProArrModel.h"
#import "HXLogisticsModel.h"
@interface HXRecordDetailModel : NSObject
@property (nonatomic,strong)NSString * gmtCreate;
@property (nonatomic,strong)NSString * gmtModified;
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * orderNo;
@property (nonatomic,strong)NSString * orderStatus;
@property (nonatomic,strong)NSString * payOrderId;
@property (nonatomic,strong)NSString * paymentMode;
@property (nonatomic,strong)NSString * paymentStatus;
@property (nonatomic,strong)NSArray * pro;
@property (nonatomic,strong)NSArray * logistics;
@property (nonatomic,strong)NSString * scorePaymentMode;
@property (nonatomic,strong)NSString * scorePaymentStatus;
@property (nonatomic,strong)NSString * shippingAddress;
@property (nonatomic,strong)NSString * shippingCompany;
@property (nonatomic,strong)NSString * shippingCompanyStatus;
@property (nonatomic,strong)NSString * shippingExpense;
@property (nonatomic,strong)NSString * shippingExtraStatus;
@property (nonatomic,strong)NSString * shippingNumber;
@property (nonatomic,strong)NSString * shippingPhone;
@property (nonatomic,strong)NSString * shippingReceiver;
@property (nonatomic,strong)NSString * shippingStatus;
@property (nonatomic,strong)NSString * totalAmount;
@property (nonatomic,strong)NSString * totalScore;
@property (nonatomic,strong)NSString * createTime;
@end
