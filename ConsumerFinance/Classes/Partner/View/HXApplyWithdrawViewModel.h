//
//  HXApplyWithdrawViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXApplyWithdrawModel.h"
@interface HXApplyWithdrawViewModel : HXBaseViewModel
@property(nonatomic,strong)HXApplyWithdrawModel * model;
@property (nonatomic,strong)NSString * careful;//
@property (nonatomic,strong)NSString * applyMoeny;//提现金额

/**
 获取银行卡提现信息

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)archiveApplyBankInformationWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 提现

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)submitApplyWithdrawWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
@end
