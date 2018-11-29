//
//  HXEarnScoreViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBaseViewModel.h"

@interface HXEarnScoreViewModel : HXBaseViewModel

@property (nonatomic, strong, readonly) NSArray *scoreWayArray; // 获取积分条件

- (void)request;

@end
