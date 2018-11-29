//
//  HXBuyRecordModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBuyRecordModel : NSObject
@property (nonatomic,strong)NSString * applyMoney;
@property (nonatomic,strong)NSString * createTime;
@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSString * type;

@property (nonatomic,strong)NSString * packageName;
@property (nonatomic,strong)NSString * orderStatus;
@property (nonatomic,strong)NSString * orderPrice;


@property (nonatomic,strong)NSString * accountAmount;
@property (nonatomic,strong)NSString * cellphone;

@property (nonatomic,strong)NSString * id;

@end
