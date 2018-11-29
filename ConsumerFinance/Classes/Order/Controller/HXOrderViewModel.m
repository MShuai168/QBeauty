////
////  HXOrderViewModel.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/13.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXOrderViewModel.h"
//#import "HXOrderInfo.h"
//#import "HXOrderTableViewCellViewModel.h"
//
//#import <RZDataBinding/RZDataBinding.h>
//
//@interface HXOrderViewModel()
//
//@property (nonatomic, strong, readwrite) NSMutableArray *allStatusorderList;
//
//@end
//
//@implementation HXOrderViewModel
//
//- (instancetype)initWithController:(UIViewController *)controller {
//    if (self == [super initWithController:controller]) {
//        _allStatusorderList = [[NSMutableArray alloc] init];
//        self.paseSize = 1;
//    }
//    return self;
//}
//
//- (void)getOrderList {
//    NSDictionary *head = @{@"tradeCode" : @"0131",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{};
//    body = @{@"yfqStatus" : @"",
//             @"userId" :[AppManager manager].userInfo.userId,
//             @"pages" : [NSString stringWithFormat:@"%ld",(long)self.paseSize],
//             @"rows" :@"10"
//             };
//    [MBProgressHUD hideHUDForView:self.controller.view];
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         NSArray *orders = [object.body objectForKey:@"OrderList"];
//                                                         [self paddingOrder:orders];
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                 }];
//    
//}
//
//- (void)paddingOrder:(NSArray *)orders {
//    if (self.paseSize == 1) {
//        [_allStatusorderList removeAllObjects];
//    }
//    
//    [orders enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        HXOrderInfo *orderInfo = [HXOrderInfo mj_objectWithKeyValues:obj];
//        HXOrderTableViewCellViewModel *viewModel = [[HXOrderTableViewCellViewModel alloc] init];
//        viewModel.companyName = orderInfo.merchantName;
//        viewModel.productName = orderInfo.productName;
//        viewModel.price = [orderInfo.stagesMoney floatValue];
//        viewModel.orderTime = orderInfo.createdTime;
//        viewModel.orderNo = orderInfo.id;
//        viewModel.orderNoOuter = orderInfo.orderNo;
//        viewModel.merchantId = orderInfo.companyId;
//        if ([orderInfo.distinguish isEqualToString:@"10"]) {
//            viewModel.orderType = orderTypeCommon;
//        }
//        if ([orderInfo.distinguish isEqualToString:@"20"]) {
//            viewModel.orderType = orderTypeCarBuy;
//        }
//        if ([orderInfo.distinguish isEqualToString:@"30"]) {
//            viewModel.orderType = orderTypeTenancy;
//        }
//        if ([orderInfo.distinguish isEqualToString:@"40"]) {
//            viewModel.orderType = orderTypeHoneymoon;
//        }
//        
//        viewModel.status = orderInfo.yfqStatus;
//        //一分期内部状态（10：订单待确认、15订单修改中、20分期待选择、30资料待认证、40资料认证中、50审核中、60补充资料、70审核拒绝、80订单取消、87H5绑定银行卡、88审核通过、89审核通过降额、90合同待签署、91服务费待缴、92影像待上传（汽车）、93影像审核中（汽车）、94补充影像（汽车）、95资料审核（汽车）、99订单完成）
//        if ([orderInfo.yfqStatus isEqualToString:@"10"]) {
//            viewModel.status = @"订单待确认";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"15"]) {
//            viewModel.status = @"订单修改中";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"20"]) {
//            viewModel.status = @"分期选择";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"30"]) {
//            viewModel.status = @"资料待认证";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"40"]) {
//            viewModel.status = @"";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"50"]) {
//            viewModel.status = @"审核中";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"60"]) {
//            viewModel.status = @"补充资料";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"70"]) {
//            viewModel.status = @"审核拒绝";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"80"]) {
//            viewModel.status = @"订单取消";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"87"]) {
//            viewModel.status = @"绑定银行卡";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"88"]) {
//            viewModel.status = @"审核通过";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"89"]) {
//            viewModel.status = @"审核通过降额";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"90"]) {
//            viewModel.status = @"合同签署";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"91"]) {
//            viewModel.status = @"服务费待支付";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"92"]) {
//            viewModel.status = @"影像上传";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"93"]) {
//            viewModel.status = @"影像审核中";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"94"]) {
//            viewModel.status = @"补充影像";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"95"]) {
//            viewModel.status = @"资料审核";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"96"]) {
//            viewModel.status = @"待商户确认";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"97"]) {
//            viewModel.status = @"商户已确认";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"98"]) {
//            viewModel.status = @"服务费已支付";
//        }
//        if ([orderInfo.yfqStatus isEqualToString:@"99"]) {
//            viewModel.status = @"订单完成";
//        }
//        
//        [_allStatusorderList addObject:viewModel];
//        self.refreshTable = YES;
//        
//    }];
//}
//
//- (void)getOrderDetailWithHXOrderTableViewCellViewModel:(HXOrderTableViewCellViewModel *)cellViewModel withReturnOrderInfoBlock:(returnOrderInfo)returnOrderInfo withFailureBlock:(FailureBlock)failureBlock {
//    if (!cellViewModel) {
//        // TODO: 提示相应的message
//        return;
//    }
//    NSDictionary *head = @{};
//    
//    switch (cellViewModel.orderType) {
//        case orderTypeCommon:
//            // 通用订单
//            head = @{@"tradeCode" : @"0125",
//                     @"tradeType" : @"appService"};
//            break;
//        case orderTypeTenancy:
//            // 租房
//            head = @{@"tradeCode" : @"0126",
//                     @"tradeType" : @"appService"};
//            
//            break;
//        case orderTypeHoneymoon:
//            // 蜜月
//            head = @{@"tradeCode" : @"0128",
//                     @"tradeType" : @"appService"};
//            
//            break;
//        case orderTypeCarBuy: case orderTypeCarRent:
//            // 汽车
//            head = @{@"tradeCode" : @"0127",
//                     @"tradeType" : @"appService"};
//            
//            break;
//            
//        default:
//            break;
//    }
//    
//    NSDictionary *body = @{@"id" : cellViewModel.orderNo,
//                           @"userId" :[AppManager manager].userInfo.userId
//                           };
//    
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     NSDictionary *dic = [[NSDictionary alloc] init];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         
//                                                         dic = [object.body objectForKey:@"frontOrder"];
//                                                         HXOrderInfo *orderInfo = [HXOrderInfo mj_objectWithKeyValues:dic];
//                                                         if (orderInfo) {
//                                                             
//                                                             returnOrderInfo(orderInfo);
//                                                         }
//                                                         // TODO: 如果没有取到订单详情，交互行为
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:self.controller.view];
//                                                     failureBlock();
//                                                 }];
//    
//}
//
//@end
