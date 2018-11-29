//
//  DKSetTradeView.h
//  HSMC
//
//  Created by Metro on 16/7/30.
//  Copyright © 2016年 Dalvik. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPasswordLength 6
//textField中的竖线
#define kLineTag 1000
//textFiled中的星号显示
#define kDotTag 3000

#define textFieldWidth [UIScreen mainScreen].bounds.size.width - 50 * 2 - 10 * 2
#define textFieldHeight 35

typedef void(^DKSetTradePasswordValue)(NSString *password);


@interface DKSetTradeView : UIView

@property (nonatomic,strong) UITextField *inputTextFiled;

- (instancetype)initWithTitle:(NSString *)title completion:(DKSetTradePasswordValue)completion;
- (void)cancelPassword; //消除交易密码

@end
