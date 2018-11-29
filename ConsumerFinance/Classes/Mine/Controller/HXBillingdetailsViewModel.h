////
////  HXBillingdetailsViewModel.h
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/31.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBaseViewModel.h"
//@interface HXBillingdetailsViewModel : HXBaseViewModel
//@property (nonatomic,strong)NSString * hasPassWordBool ; //是否设置交易密码
//@property (nonatomic,strong)NSString * orderNo;
//@property (nonatomic,assign)BOOL isGreen;
//@property (nonatomic,assign)NSString * repayAmt;
//@property (nonatomic,strong)NSMutableArray * voListArr;
//@property (nonatomic,strong)NSString * orderMoney;//订单金额
//@property (nonatomic,strong)NSString * createDate;//创建时间
//@property (nonatomic,strong)NSString * totalMoney; //还款总额
//@property (nonatomic,strong)NSString  * selectMoney; //目前只支持1期 后面待定
//@property (nonatomic,strong)NSString * interest; //罚息
//@property (nonatomic,assign)BOOL squareBool;
//@property (nonatomic,strong)NSMutableArray * bankArr;//银行卡数组
//@property (nonatomic,strong)NSString * selctDate; //选择的分期
//@property (nonatomic,strong)NSString * authBool; //是否实名认证
//@property (nonatomic,strong)NSString * nameStr;
//@property (nonatomic,strong)NSString * idCardNumber;
//@property (nonatomic,strong)NSString * responseTime;
//@property (nonatomic,assign)BOOL betweenTimeBool;//判断是否在22-3点
//@property (nonatomic,strong)NSString * repayMoneStr; //绿通还款描述
//
///**
// 判断是否设置交易密码
//
// @param returnBlock 回调
// */
//-(void)archivePassWordHaveBoolWithReturnBlock:(ReturnValueBlock)returnblock;
//
///**
// 获取详情
//
// @param returnblock 回调
// */
//-(void)archiveDetailWithReturnBlock:(ReturnValueBlock)returnblock failBlock:(FailureBlock)failBlock;
//
///**
// 获取银行卡列表
//
// @param returnBlock 回调
// */
//-(void)archiveBankListWithReturnBlock:(ReturnValueBlock)returnBlock;
//
//-(void)archiveBaseInformationWithReturnBlock:(ReturnValueBlock)returnBlock;
//@end
