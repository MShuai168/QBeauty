//
//  HXPayConfirmViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXBankListModel.h"

@interface HXPayConfirmViewModel : HXBaseViewModel
@property (nonatomic,strong)NSString * hasPassWordBool ; //是否设置交易密码
@property (nonatomic,strong)NSString * payPasswordLockNum; //错误次数
@property (nonatomic,strong)NSMutableArray * bankArr;
@property (nonatomic,strong)HXBankListModel * selectBank;
@property (nonatomic,strong)NSString * totalMoney; //总金额
@property (nonatomic,strong)NSString * orderNumber;//订单号
@property (nonatomic,strong)NSString * selectDate;//分期数
@property (nonatomic,strong)NSString * businessNo;//预还款带回的参数
@property (nonatomic,strong)NSString * message;

///**
// 判断是否设置交易密码
//
// @param returnBlock 回调
// */
//-(void)archivePassWordHaveBoolWithReturnBlock:(ReturnValueBlock)returnBlock;

/**
 交易密码支付

 @param returnBlock 回调
 */
-(void)submitPassWord:(NSString *)passWord returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 银行卡预支付 获取短信验证码

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)archivePaymentMessageWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 主动还款

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)submitRepayInformationWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock ;
@end
