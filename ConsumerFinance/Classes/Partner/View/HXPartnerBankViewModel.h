//
//  HXPartnerBankViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXPartnerBankModel.h"
@interface HXPartnerBankViewModel : HXBaseViewModel
@property (nonatomic,strong)NSString * nameStr;
@property (nonatomic,strong)NSString * bankStr;
@property (nonatomic,strong)NSString * cardStr;
@property (nonatomic,strong)NSString * subbranchStr;
@property (nonatomic,strong)HXPartnerBankModel * model;

/**
 获取合伙人银行卡信息

 @param block 回调
 @param failBlock 错误回调
 */
-(void)archiveBankInformationWithReuturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock;

/**
 提交合伙人银行卡信息

 @param block 回调
 @param failBlock 错误回调
 */
-(void)submitBankInformationWithReuturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock;
@end
