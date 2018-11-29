//
//  SMSAuthenticationView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/27.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSAuthenticationView : UIView
@property (nonatomic,strong)void(^clickBtn)();//确认
@property (nonatomic,copy)void(^cancel)();//取消
@property (nonatomic,copy)void(^timerClick)();//短信验证码
@property (nonatomic,strong)UILabel * sendLabel ;
-(void)startTimer;//开始计时
-(void)stopTimer;//停止计时
//清空text 显示错误
-(void)clearnMessage:(NSString *)str;
@end
