//
//  HXMessageViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/6/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MessageModel.h"

@interface HXMessageViewModel : NSObject

@property (nonatomic, strong) MessageModel *firstSysNoticeModel; //系统通知
@property (nonatomic, strong) MessageModel *firstRefundModel; //还款提醒
@property (nonatomic, strong) MessageModel *firstOrderModel; //订单通知
@property (nonatomic, strong) NSString *noReadOrderCount; // 订单通知未读
@property (nonatomic, strong) NSString *noReadPayment; // 订单通知未读

@end
