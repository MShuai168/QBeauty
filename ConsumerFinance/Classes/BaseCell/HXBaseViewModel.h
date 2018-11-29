////
////  HXBaseViewModel.h
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/3/15.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
#import <Foundation/Foundation.h>
#import "HXOrderInfo.h"
///**
// 资料认证状态
// */
//typedef NS_ENUM(NSInteger, OrderStatuesKind) {
//    OrderStatuesCommen,//审核通用
//    OrderStatuesGoing,//审核中
//    OrderStatuesPass, //审核通过
//    OrderStatuesReplenish, //资料补充
//    OrderStatuesCancel,//资料取消
//    OrderStatuesRefuse, //资料拒绝
//    OrderStatuesDerate //审核通过降额
//};
//typedef NS_ENUM(NSInteger, CertificateCategory) {
//    CertificateCommen,//默认凭证
//    CertificatePayment,//首付凭证
//    CertificateSales, //销售凭证
//    CertificateFinancial, //财力凭证
//    CertificateStream,//流水凭证
//    CertificateWork,//工作凭证
//    CertificateIdentify,//身份证
//    CertificateStudent//学生凭证
//};
//typedef NS_ENUM(NSInteger, IdentityStyle) {
//    DefaultStyle,
//    WorkStyle,
//    StudentStyle,
//    FreeStyle,
//};
typedef NS_ENUM(NSInteger, ShopStatuesKind) {
    ShopStatuesCommen,//兑换通用
    ShopStatuesCancel,//兑换取消
    ShopStatuesSuccess, //兑换完成
    ShopStatuesArchive, //兑换已经发货
    ShopStatuesWait,//兑换等待
    ShopStatuesGoing, //兑换 处理中
    ShopStatesStock,//商品下架
    ShopStatuesWaitMoney //兑换 待支付
};

@interface HXBaseViewModel : NSObject
@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

@property (nonatomic, assign) orderType orderType;
@property (nonatomic, strong) HXOrderInfo *orderInfo;

@property (nonatomic,weak)  UIViewController * controller;

-(id)initWithController:(UIViewController *)controller;

// 传入交互的Block块
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

-(HXStateView *)creatStatesView:(UIView *)view showType:(NSInteger)type offset:(NSInteger)offset showInformation:(void (^)())showInformation;
@end
