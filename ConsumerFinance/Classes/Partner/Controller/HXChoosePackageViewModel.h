//
//  HXChoosePackageViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/30.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBaseViewModel.h"

typedef void (^buyPackageBlock)(id value);

@interface HXChoosePackageViewModel : HXBaseViewModel

@property (nonatomic, strong, readonly) NSDictionary *packageDic;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *inviterCode;

- (void)request;
- (void)resetModel;
- (void)buyPackageWithSucess:(buyPackageBlock)sucess failure:(FailureBlock)failure;
- (NSString *)getSelectedId;

@end
