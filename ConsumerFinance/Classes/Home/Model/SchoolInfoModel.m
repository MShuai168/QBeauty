//
//  SchoolInfoModel.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/8.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "SchoolInfoModel.h"

@implementation SchoolInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"userId":@"userUuid"};
}


@end
