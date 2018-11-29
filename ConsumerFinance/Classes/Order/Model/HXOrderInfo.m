//
//  HXOrderInfo.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXOrderInfo.h"
#import "HXConfirmOrderViewController.h"
#import "HXConfirmOrderViewControllerViewModel.h"
#import "HXChooseStagingViewController.h"
#import "HXAuthenticationStatusViewController.h"
#import "HXSignConractViewController.h"
#import "HXPayViewController.h"
//#import "HXUploadCertificateViewController.h"
#import "HXOrderSucessViewController.h"
#import "HXAuthRefuseViewController.h"
#import "HXBankAuthViewController.h"
#import "HXBeautyConfirmViewController.h"
#import "HXServiceChargeViewController.h"
#import "HXServiceChargeViewController.h"

@implementation HXOrderInfo

//- (void)orderStatusHandleWithBlock:(returnController)returnController with:(orderType)orderType {
//    
//    //一分期内部状态（10：订单待确认、15订单修改中、20分期待选择、30资料待认证、40资料认证中、50审核中、60补充资料、70审核拒绝、80订单取消、88审核通过、89审核通过降额、90合同待签署、91服务费待缴、92影像待上传（汽车）、93影像审核中（汽车）、94补充影像（汽车）、96商家待确认订单（医美）3.1、98服务费已支付、99订单完成）
//    
////    orderType orderType = cellViewModel.orderType;
//    //订单区分（10通用20汽车30租房40蜜月）
//    if ([self.distinguish isEqualToString:@"20"]) {
//        //购买形式(1:以租代购，2直购)
//        if ([self.buyType isEqualToString:@"1"]) {
//            orderType = orderTypeCarRent;
//        }
//        if ([self.buyType isEqualToString:@"2"]) {
//            orderType = orderTypeCarBuy;
//        }
//    }
//    
//    if ([self.yfqStatus isEqualToString:@"10"] || [self.yfqStatus isEqualToString:@"15"]) {
//        HXConfirmOrderViewController *controller = [[HXConfirmOrderViewController alloc] init];
//        HXConfirmOrderViewControllerViewModel *viewModel = [[HXConfirmOrderViewControllerViewModel alloc] init];
//        viewModel.orderInfo = self;
//        viewModel.orderType = orderType;
//        
//        controller.viewModel = viewModel;
//        returnController(controller);
//    }
//    
//    if ([self.yfqStatus isEqualToString:@"20"]) {
//        HXChooseStagingViewController *controller = [[HXChooseStagingViewController alloc] init];
//        HXChooseStagingViewControllerViewModel *viewModel = [[HXChooseStagingViewControllerViewModel alloc] init];
//        viewModel.orderInfo = self;
//        viewModel.credits = 0;
//        viewModel.orderId = self.id;
//        controller.viewModel = viewModel;
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"30"] || [self.yfqStatus isEqualToString:@"40"] || [self.yfqStatus isEqualToString:@"50"] || [self.yfqStatus isEqualToString:@"60"] || [self.yfqStatus isEqualToString:@"88"] || [self.yfqStatus isEqualToString:@"89"]) {
//        
//        HXAuthenticationStatusViewController *controller = [[HXAuthenticationStatusViewController alloc] init];
//        controller.viewModel.orderInfo = self;
//        controller.viewModel.orderId = self.id;
//        controller.viewModel.orderInfo.yfqStatus = self.yfqStatus;
//        
//        if ([self.yfqStatus isEqualToString:@"30"]) {
//            controller.viewModel.states = OrderStatuesCommen;
//            controller.viewModel.supplyDescription = @"请保证资料的准确性，以便评估您的额度";
//        }
//        if ([self.yfqStatus isEqualToString:@"50"]) {
//            controller.viewModel.states = OrderStatuesGoing;
//            controller.viewModel.supplyDescription = @"资料审核中，请耐心等待";
//        }
//        if ([self.yfqStatus isEqualToString:@"60"]) {
//            controller.viewModel.states = OrderStatuesReplenish;
//            controller.viewModel.supplyDescription = self.message;
//        }
//        
//        if ([self.yfqStatus isEqualToString:@"88"]) {
//            controller.viewModel.states = OrderStatuesPass;
//            controller.viewModel.supplyDescription = @"恭喜！审核已通过";
//            controller.viewModel.applyMoney = self.approvalAmount;
//        }
//        if ([self.yfqStatus isEqualToString:@"89"]) {
//            controller.viewModel.states = OrderStatuesDerate;
//            controller.viewModel.applyMoney = self.stagesMoney;
//            controller.viewModel.derate = self.approvalAmount;
//        }
//        
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"80"] || [self.yfqStatus isEqualToString:@"70"]) {
//        HXAuthRefuseViewController *controller  = [[HXAuthRefuseViewController alloc] init];
//        if ([self.yfqStatus isEqualToString:@"70"]) {
//            controller.viewModel.states = OrderStatuesRefuse;
//        } else {
//            controller.viewModel.states = OrderStatuesCancel;
//        }
//        controller.viewModel.supplyDescription = self.message;
//        controller.viewModel.orderType = orderType;
//        controller.viewModel.orderInfo = self;
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"87"]) {
//        HXBankAuthViewController *controller = [[HXBankAuthViewController alloc] init];
//        controller.viewModel.orderInfo = self;
//        controller.viewModel.orderType = orderType;
//        controller.viewModel.orderId = self.id;
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"90"]) {
//        HXSignConractViewController *controller = [[HXSignConractViewController alloc] init];
//        controller.viewModel.orderType = orderType;
//        controller.viewModel.orderInfo = self;
//        
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"91"]) {
//        HXServiceChargeViewController *controller = [[HXServiceChargeViewController alloc] init];
//        controller.viewModel.orderInfo = self;
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"92"] || [self.yfqStatus isEqualToString:@"93"] || [self.yfqStatus isEqualToString:@"94"] || [self.yfqStatus isEqualToString:@"95"]) {
//        HXUploadCertificateViewController *controller = [[HXUploadCertificateViewController alloc] init];
//        controller.viewModel.orderInfo = self;
//        
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"96"]) {
//        HXBeautyConfirmViewController *controller = [[HXBeautyConfirmViewController alloc] init];
//        controller.viewModel.beautyStatus = BeautyStatusWait;
//        controller.viewModel.orderInfo = self;
//        
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"97"]) {
//        HXServiceChargeViewController * controller = [[HXServiceChargeViewController alloc] init];
//        controller.viewModel.orderInfo = self;
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"98"]) {
//        HXServiceChargeViewController * controller = [[HXServiceChargeViewController alloc] init];
//        controller.viewModel.orderInfo = self;
//        returnController(controller);
//    }
//    if ([self.yfqStatus isEqualToString:@"99"]) {
//        HXOrderSucessViewController *controller = [[HXOrderSucessViewController alloc] init];
//        HXOrderSucessViewControllerViewModel *viewModel = [[HXOrderSucessViewControllerViewModel alloc] init];
//        viewModel.orderInfo = self;
//        viewModel.orderType = orderType;
//        controller.viewModel = viewModel;
//        
//        returnController(controller);
//    }
//}

- (NSString *)paddingBuyType:(NSString *)buyType {
    return [buyType isEqualToString:@"1"]?@"以租代购":@"直购";
}

- (NSString *)paddingTourismType:(NSString *)tourismType {
    return [tourismType isEqualToString:@"1"]?@"自助":@"跟团";
}

@end
