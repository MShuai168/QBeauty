//
//  HXSetPwdViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2018/1/9.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSetPwdViewController : UIViewController

@property (nonatomic, assign) BOOL isNeedLoginOut; // 是否需要返回的时候，做登出操作。只有从安全中心做设置密码操作才会不需要做登出操作

@end
