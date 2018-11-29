////
////  HXDataAuthenticationViewModel.h
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/9.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXBaseViewModel.h"
//#import "HXDataAuthenModel.h"
//
//
//@interface HXDataAuthenticationViewModel : HXBaseViewModel
//@property (nonatomic,assign)IdentityStyle style; //状态
//@property (nonatomic,strong)NSArray * nameArr; //资料认证界面标题对应的数组
//@property (nonatomic,strong)NSArray * statesArr;
//@property (nonatomic,strong)HXDataAuthenModel * model;
//
//@property (nonatomic,assign)BOOL hiddSubmitBtn; //判断按钮状态
//
//@property (nonatomic,assign)BOOL orderAuth; //判断订单资料认证
//
//@property (nonatomic,assign)BOOL provideBool; //首付调整额度 NO 首次开通 YES调整额度
//
//@property (nonatomic,assign)BOOL photoUploadBool; //图像是否上传
//
////传递
//@property (nonatomic,assign)OrderStatuesKind states; //资料认证状态
//
//@property (nonatomic,strong)NSString * supplyDescription;//补充资料文字描述
//
//@property (nonatomic,strong)NSString * applyMoney; //申请金额
//@property (nonatomic,strong)NSString * derate; //降额
//@property (nonatomic,strong)NSString * orderId; //订单id
//
///**
// 获取当前用户验证状态
// 
// @param returnBlock 回调
// */
//-(void)archiveDataAtuthenStatesWithReturnBlock:(ReturnValueBlock)returnBlock;
//
///**
// 获取用户状态对应标题
// */
//-(void)changeStates;
//
///**
// 提交运营商认证成功
// */
//-(void)cheakCarrieroperatorCodeNumber:(NSString *)code statesWithReturnBlock:(ReturnValueBlock)returnBlock;
//
//
///**
// 根据状态设置对应的文本
//
// @param block 描述回调
// */
//-(void)replaceTitleWithTileBlock:(void(^)(NSString * title ,NSString * description,float titleHeight))block;
//
//
///**
// 提交调额
//
// @param returnBlock 回调
// */
//-(void)submitAdjustAmountWithReturnBlock:(ReturnValueBlock)returnBlock;
//
///**
// 信用分激活
// 
// @param returnBlock 回调
// */
//-(void)creditActivationWithReturnBlock:(ReturnValueBlock)returnBlock;
//    
//    
//    
//
//@end
