//
//  HXAlertViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^actionBlock)(void);

@interface HXAlertViewController : UIViewController

+ (instancetype _Nullable )alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message leftTitle:(NSString *_Nullable)leftTitle rightTitle:(NSString *_Nonnull)rightTitle;

@property (nonatomic, strong) actionBlock _Nullable leftAction;
@property (nonatomic, strong) actionBlock _Nullable rightAction;

@end
