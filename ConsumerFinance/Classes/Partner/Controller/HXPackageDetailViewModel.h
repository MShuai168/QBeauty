//
//  HXPackageDetailViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBaseViewModel.h"

@interface HXPackageDetailViewModel : HXBaseViewModel

@property (nonatomic, strong, readonly) NSArray *packageDetails;
@property (nonatomic, strong) NSString *id;

- (void)requestWithSucess:(ReturnValueBlock)sucess failureBlock:(FailureBlock)failureBlock;

@end
