//
//  HXRepaymentViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXRepaymentViewModel : HXBaseViewModel
@property (nonatomic,strong)NSMutableArray * repaymentArr; // 还款记录
@property (nonatomic,strong)HXStateView * state;
-(void)archiveRepaymentReturnValue:(ReturnValueBlock)returnValue faile:(FailureBlock)fail;
@end
