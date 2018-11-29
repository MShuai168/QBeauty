//
//  HXOrderTableViewCellViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/14.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXOrderTableViewCellViewModel : NSObject

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) float price;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) NSString *orderNo; // 我们系统的订单编号
@property (nonatomic, strong) NSString *orderNoOuter; // 安硕系统的订单编号
@property (nonatomic, strong) NSString *merchantId; // 商户id
@property (nonatomic, assign) orderType orderType; // 订单类型

@end
