//
//  HXLogisticsModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXLogisticsModel : NSObject
@property (nonatomic,strong)NSString * gmtCreate;
@property (nonatomic,strong)NSString *  id;
@property (nonatomic,strong)NSString * orderId;
@property (nonatomic,strong)NSString * proName;
@property (nonatomic,strong)NSString *  shippingCompany;
@property (nonatomic,strong)NSString *  shippingCompanyStatus;
@property (nonatomic,strong)NSString *  shippingExtraStatus;
@property (nonatomic,strong)NSString *  shippingNumber;
@property (nonatomic,strong)NSString *  shippingStatus;
@end
