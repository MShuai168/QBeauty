//
//  HXMyPointsModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyPointsModel.h"

@implementation HXMyPointsModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"scoreRecords" : @"HXScoreRecordsModel",
             };
}
@end
