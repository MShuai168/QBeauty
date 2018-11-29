////
////  HXJobViewModel.h
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/11.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBaseViewModel.h"
//#import "HXJobInforModel.h"
//#import "HXJobInformationModel.h"
//@interface HXJobViewModel : HXBaseViewModel
//@property (nonatomic,strong)HXJobInformationModel * model;
//@property (nonatomic,strong)NSString * realName;
//@property (nonatomic,strong)NSArray * companyImgArr;//工作
//@property (nonatomic,assign)CertificateCategory catory;//当前图片所属类型
//
//@property (nonatomic,strong)NSString * title;//标题
//@property (nonatomic,strong)NSString * content;//描述
//
//@property (nonatomic,strong)NSString * orderId;//订单ID
//@property (nonatomic,strong)NSString * orderNumber;
//@property (nonatomic,strong)NSString * type;//当前图片种类
///**
// 提交工作认证
// 
// @param jobModel 工作信息
// @param returnBlock 回调
// */
//-(void)submitJobInformationWithJobModel:(HXJobInforModel *)jobModel photoArr:(NSMutableArray *)arr returnBlock:(ReturnValueBlock )returnBlock;
//
///**
// 获取工作信息
// 
// @param returnBlock 回调
// */
//-(void)archiveJobInformationWithReturnBlock:(ReturnValueBlock)returnBlock;
//
///**
// 提交图片
// 
// @param arr 图片数组
// */
//-(void)submitPhotoWithPhotoArr:(NSMutableArray *)arr returnBlock:(ReturnValueBlock )returnBlock failBlock:(FailureBlock)failBlock;
//
///**
// 获取图片回显
// 
// @param type 类型
// @param orderNumber 订单号
// @param returnBlock 回调
// */
//-(void)archivePhotoType:(NSString *)type ordrNumber:(NSString *)orderNumber returnBlock:(ReturnValueBlock )returnBlock;
///**
// 根据tag值匹配
// 
// @param tag 标记 00: 政府机关、10:事业单位、20:国企、30:外企、40:合资、50:民营、60:私企、70:个体
// @return 返回对应的文字
// */
//-(NSString *)natureWithTag:(NSString *)tag;
//
///**
// 上传其他影像资料
// 
// @param arr 影像图片数组
// @param returnBlock 回调
// */
//-(void)submitOtherPhotoWithPhotoArr:(NSMutableArray *)arr returnBlock:(ReturnValueBlock )returnBlock failBlock:(FailureBlock)failBlock;
//
///**
// 获取名称
// */
//-(void)archiveNameAndTitle;
//
//
///**
// 获取影像上传对应的编号
// */
//-(void)archiveKindType;
//
//
//@end
