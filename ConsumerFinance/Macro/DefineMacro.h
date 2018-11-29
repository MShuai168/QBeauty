//
//  DefineMacro.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/21.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, orderType){
    orderTypeCommon, // 订单类型，通用
    orderTypeTenancy, // 租房
    orderTypeHoneymoon, // 蜜月
    orderTypeCarBuy, // 直购汽车
    orderTypeCarRent // 以租代购
};

// 不同的登录途径
typedef enum : NSUInteger {
    smsByTypeLoginEnum, // 通过短信登录
    smsByTypeRegisterEnum, //注册
    smsByTypeForgetPwdEnum, //忘记密码
    smsByTypeResetPwdEnum // 设置密码
} smsByType;

extern NSString *const kLocationCity; // 当前选择的城市
extern NSString *const CreatTime;
extern NSString *const kPassword;
extern NSString *const kUserPhone;
extern NSString *const kDownloadUrl;
