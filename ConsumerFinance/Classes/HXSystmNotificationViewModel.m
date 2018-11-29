//
//  HXSystmNotificationViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXSystmNotificationViewModel.h"
#import "MessageModel.h"

@interface HXSystmNotificationViewModel()

@property (nonatomic,strong,readwrite)NSMutableArray *notificationContents;

@end

@implementation HXSystmNotificationViewModel
- (void)getNotification:(returnValue)returnValue withFailureBlock:(FailureBlock)failureBlock {
    
    NSDictionary *head = @{};
    NSDictionary *body = @{};
    
    switch (_type) {
        case MessageSystem:
            // 系统通知
            head = @{@"tradeCode" : @"0205",
                     @"tradeType" : @"appService"};
            body = @{@"pageSize" : @"1000",
                     @"current" :@"1"
                     };
            break;
        case MessageOrder:
            // 订单通知
            head = @{@"tradeCode" : @"0206",
                     @"tradeType" : @"appService"};
            body = @{@"pageSize" : @"1000",
                     @"current" :@"1",
                     @"userUuid":[AppManager manager].userInfo.userId
                     };
            
            break;
        case MessageRepayment:
            // 还款提醒
            head = @{@"tradeCode" : @"0204",
                     @"tradeType" : @"appService"};
            body = @{@"pageSize" : @"1000",
                     @"current" :@"1",
                     @"userUuid":[AppManager manager].userInfo.userId
                     };
            
            break;
            
        default:
            break;
    }
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSArray *array = [[NSArray alloc] init];
                                                         switch (_type) {
                                                             case MessageSystem:
                                                                 array = [object.body objectForKey:@"sysNoticeList"];
                                                                 break;
                                                             case MessageOrder:
                                                                 array = [object.body objectForKey:@"orderNoticeList"];
                                                                 break;
                                                             case MessageRepayment:
                                                                 array = [object.body objectForKey:@"refundNoticeList"];
                                                                 break;
                                                                 
                                                             default:
                                                                 break;
                                                         }
                                                         _notificationContents = [MessageModel mj_objectArrayWithKeyValuesArray:array];
                                                         if (returnValue) {
                                                             returnValue();
                                                         }
                                                         if (_notificationContents.count==0) {
                                                             [self showItemView:self.controller.view type:2];
                                                         }else {
                                                             [self.itemStateView removeFromSuperview];
                                                         }
                                                     }else {
                                                         
                                                         [self showItemView:self.controller.view type:0];
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     [self showItemView:self.controller.view type:0];
                                                     failureBlock();
                                                 }];
}

-(void)showItemView:(UIView *)view  type:(NSInteger)type{
    if (self.itemStateView) {
        [self.itemStateView removeFromSuperview];
    }
    self.itemStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
        if ([self.controller respondsToSelector:NSSelectorFromString(@"archiveDetails")]){
            SEL selector = NSSelectorFromString(@"archiveDetails");
            IMP imp = [self.controller methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self.controller, selector);
        }
    }];
    
}



@end
