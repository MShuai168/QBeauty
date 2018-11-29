//
//  HXPayConfirmViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/2.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPayConfirmViewModel.h"
typedef NS_ENUM(NSInteger, OrderStatues){
    orderStatuesCommon, // 正常支付状态
    orderStatuesSuccess, // 成功状态
    orderStatuesfail, // 失败状态
    orderStatuesOngoing,//订单进行中
    orderZFB //支付宝
};
typedef void(^payConfirm)(void);
@protocol forgotPassWordDelegate;
@interface HXPayConfirmViewController : UIViewController

@property (nonatomic, strong) payConfirm payConfirmBlcok;
@property (nonatomic,assign)id<forgotPassWordDelegate>delegate;
@property (nonatomic,strong)HXPayConfirmViewModel *viewModel;
-(id)initWithOrderStates:(OrderStatues)orderStates;
@end

/**
 忘记密码
 */
@protocol forgotPassWordDelegate <NSObject>

-(void)forgot;
-(void)addBank;

@end
//禁止复制粘贴的UITextField
#import "WTReTextField.h"
@interface YLPasswordTextFiled : WTReTextField

@end
/*
 弹出的供输入密码的框
 */
