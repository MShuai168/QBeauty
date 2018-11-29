//
//  BankInfoModel.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/10.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "BankInfoModel.h"

@implementation BankInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"userId":@"userUuid"};
}


@end
