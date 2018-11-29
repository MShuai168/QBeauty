//
//  HXSystmNotificationViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
/**
 消息类型
 */
typedef NS_ENUM(NSInteger, MessageType) {
    MessageOrder,//订单提醒
    MessageRepayment,//还款提醒
    MessageSystem //系统通知
};
typedef void(^returnValue)(void);

@interface HXSystmNotificationViewModel : HXBaseViewModel

@property (nonatomic,assign)MessageType type;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * content;
@property (nonatomic,assign)float height;
@property (nonatomic,strong,readonly)NSArray *notificationContents;
@property (nonatomic,strong)HXStateView * itemStateView;

- (void)getNotification:(returnValue)returnValue withFailureBlock:(FailureBlock) failureBlock;

@end
