//
//  FreezeHintView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/7/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreezeHintView : UIView
+(void)creatView;//创建冻结提示框
@end

typedef void (^OpenScore)();
typedef void (^SureBlock)();
typedef void (^CancelBlock)();
@interface HXScorePromptView : UIView
@property (nonatomic,strong)UIView * freeView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIButton * leftBtn;
@property (nonatomic,strong)UIButton * rightBtn;
@property (nonatomic,assign)BOOL comBool;//判断是否通用 左面按钮灰色 右面红色
-(id)initWithScore:(OpenScore)score;

-(void)changeScore:(NSString *)score;

-(id)initWithName:(NSString *)name TitleArr:(NSArray *)titleArr selectNameArr:(NSArray *)nameArr comBool:(BOOL)comBool sureBlock:(void(^)())sureBlock cancelBlock:(void(^)())cancelBlock;
-(void)showAlert;
@end

@interface HXPaymentView : UIView
@property (nonatomic,strong)UIView * freeView;
@property (nonatomic,weak)UIViewController * controller;
@property (nonatomic,assign)BOOL orderServiceBool; //判断订单支付
-(id)initWithOrderNo:(NSString *)orderNo sureBlock:(void(^)())sureBlock cancelBlock:(void(^)())cancelBlock;
@end
