//
//  HXCreditLimitModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/7/18.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXCreditLimitModel : NSObject
@property (nonatomic,strong)NSString * createTime;
@property (nonatomic,strong)NSString * creditLine;
@property (nonatomic,strong)NSString * creditRatin;
@property (nonatomic,strong)NSString * creditScore;
@property (nonatomic,strong)NSString * creditValiableLine;
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * status;
@property (nonatomic,strong)NSString * updateTime;
@property (nonatomic,strong)NSString * withdrawPercent ;
@property (nonatomic,strong)NSString * remainedMoney;
@property (nonatomic,strong)NSString * isActivate;

@end
