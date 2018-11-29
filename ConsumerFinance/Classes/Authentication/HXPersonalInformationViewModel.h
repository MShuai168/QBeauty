////
////  HXPersonalInformationViewModel.h
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/9.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXBaseViewModel.h"
//#import "HXPersonDetailModel.h"
//#import "HXPersonalModel.h"
//@interface HXPersonalInformationViewModel : HXBaseViewModel
//@property (nonatomic,strong)HXPersonDetailModel * model;
//@property (nonatomic,strong) HXPersonalModel * personalModel;
//@property (nonatomic,strong)NSArray *  contractListArr;
//
//@property (nonatomic,strong)NSArray * identityArr;
//- (void)postToServer;
///**
// 获取基本信息
// */
//-(void)archiveinformationWithReturnBlock:(ReturnValueBlock)returnBlock;
//
///**
// 根据id查询对应身份
//
// @param 用户类型（01：企业主，02：上班族，03：学生、04：自由职业者）
//
// @return 返回对应字符串
// */
//-(NSString *)identityWithTag:(NSString *)tag;
///**
// 根据id查询婚姻状况
// 
// @param 婚姻状况"已婚":10);"未婚":20);"离异":21);"丧偶":25);再婚":30)
// 
// @return 返回对应字符串
// */
//-(NSString *)marriageWithTag:(NSString *)tag;
//
//
///**
// 替换联系人关系
//
// @param tag 对应的标记
// @return 返回联系人名称
// */
//-(NSString *)contractTypeWithTag:(NSString *)tag;
///**
// 提交资料
//
// @param returnBlock 回调
// */
//-(void)submitPersonInformationWithReturnBlock:(ReturnValueBlock)returnBlock;
//
///**
// 根据身份匹配不同的联系人 身份
// */
//-(void)identityStates:(NSString *)tag;
//
//-(NSString *)identityWithName:(NSString *)name;
//
//
//@end
