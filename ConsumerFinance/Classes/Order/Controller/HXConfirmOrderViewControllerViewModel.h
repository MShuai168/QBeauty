//
//  HXConfirmOrderViewControllerViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/21.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXOrderInfo.h"
#import "HXBaseViewModel.h"

@interface HXConfirmOrderViewControllerViewModel : HXBaseViewModel

@property (nonatomic, strong, readonly) NSArray *customers;
@property (nonatomic, strong, readonly) NSArray *projects;
@property (nonatomic, strong, readonly) NSArray *hireInfos;

//@property (nonatomic, assign) orderType orderType;
//@property (nonatomic, strong) HXOrderInfo *orderInfo;

- (void)paddingData:(NSDictionary *)dic;

@end
