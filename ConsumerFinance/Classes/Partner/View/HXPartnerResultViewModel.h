//
//  HXPartnerResultViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXBuyRecordModel.h"
#import "HXPartnerResultModel.h"
#import "HXChangeInformationModel.h"
typedef NS_ENUM(NSInteger, PartnerOrderStates) {
    PartnerOrderStatesCommen,//合伙人订单
    PartnerOrderStatesCancel,//合伙人订单取消
    PartnerOrderStatesSuccess, //合伙人订单完成
    PartnerOrderStatesUnpaid, //合伙人订单待支付
    PartnerOrderStatesPaid,//合伙人订单已支付
    PartnerOrderStatesFail//合伙人订单失败
};
@interface HXPartnerResultViewModel : HXBaseViewModel
@property (nonatomic,strong)NSString * nameStr;
@property (nonatomic,strong)NSString * identyStr;
@property (nonatomic,strong)NSString * iphoneStr;
@property (nonatomic,assign)PartnerOrderStates  orderStates;
@property (nonatomic,strong)HXBuyRecordModel * buyRecordModel;
@property (nonatomic,strong)NSString * isPartner;
@property (nonatomic,strong)HXPartnerResultModel * resultModel;
@property (nonatomic,strong)HXChangeInformationModel * informationModel;
@property (nonatomic,strong)NSString * refuseReason;
@property (nonatomic,strong)NSString * id;

/**
 获取结果页详情

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)archiveResultWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 取消套餐

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)submitCanceltWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 提交个人信息修改
 
 @param block 回调
 @param failBlock 错误回调
 */
-(void)submitInformationWithReturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock;
//获取失败原因
-(void)archiveFailWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
@end
