//
//  FreezeHintView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/7/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "FreezeHintView.h"
#import "HXPayView.h"


@implementation FreezeHintView
+(void)creatView {
    FreezeHintView * freeView = [[[self class] alloc] init];
    freeView.backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.49];
    [[UIApplication sharedApplication].keyWindow addSubview:freeView];
    [freeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    UIView * promptView = [[UIView alloc] init];
    promptView.backgroundColor = kUIColorFromRGB(0xFCFCFC);
    [freeView  addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(freeView);
        make.centerX.equalTo(freeView);
        make.height.mas_equalTo(201);
        make.left.equalTo(freeView).offset(30);
        make.right.equalTo(freeView).offset(-30);
    }];
    
    UILabel * promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"提示";
    promptLabel.textColor = ComonTextColor;
    promptLabel.font = [UIFont systemFontOfSize:18];
    [promptView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(promptView);
        make.top.equalTo(promptView).offset(18);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = kUIColorFromRGB(0xE4E4E4);
    [promptView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLabel.mas_bottom).offset(15);
        make.left.and.right.equalTo(promptView);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel * contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"抱歉！额度冻结期将不能使用";
    contentLabel.textColor = ComonTitleColor;
    contentLabel.font = [UIFont systemFontOfSize:16];
    [promptView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(25);
        make.centerX.equalTo(promptView);
    }];
    
    UILabel * numberLabel = [[UILabel alloc] init];
    numberLabel.text = [NSString stringWithFormat:@"客服电话：%@",DefineText_Hotline];
    numberLabel.textColor = ComonTitleColor;
    numberLabel.font = [UIFont systemFontOfSize:16];
    [promptView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(15);
        make.centerX.equalTo(promptView);
    }];
    
    for (int i = 0; i<2; i++) {
        UIButton * sureBtn = [[UIButton alloc] init];
        sureBtn.backgroundColor = kUIColorFromRGB(0xF2F4F5);
        [promptView addSubview:sureBtn];
        sureBtn.tag = i+100;
        [sureBtn addTarget:freeView action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        if (i==0) {
            [sureBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
            [sureBtn setTitle:@"取消" forState:UIControlStateNormal];
        }else {
            [sureBtn setTitleColor:kUIColorFromRGB(0x4A90E2) forState:UIControlStateNormal];
            [sureBtn setTitle:@"联系客服" forState:UIControlStateNormal];
            
        }
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(promptView.mas_left).offset(i*(SCREEN_WIDTH-60)/2);
            make.bottom.equalTo(promptView);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo((SCREEN_WIDTH-60)/2);
        }];
    
    }
    UIView * botomLine = [[UIView alloc] init];
    botomLine.backgroundColor = kUIColorFromRGB(0xE4E4E4);
    [promptView addSubview:botomLine];
    [botomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(promptView.mas_bottom).offset(-50.5);
        make.left.and.right.equalTo(promptView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView * comenLine = [[UIView alloc] init];
    comenLine.backgroundColor = kUIColorFromRGB(0xE4E4E4);
    [promptView addSubview:comenLine];
    [comenLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(promptView);
        make.width.mas_equalTo(0.5);
        make.bottom.equalTo(promptView);
        make.height.mas_equalTo(50);
    }];
}
-(void)sureBtnAction:(UIButton *)sender {
    if (sender.tag == 101) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",DefineText_Hotline];
        //            NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@interface HXScorePromptView ()
@property (nonatomic,strong)OpenScore scroe;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,assign)BOOL openScore;
@property (nonatomic,strong)SureBlock sureBlock;
@property (nonatomic,strong)CancelBlock cancelBlock;
@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSArray * titleArr;
@property (nonatomic,strong)NSArray * nameArr;
@end
@implementation HXScorePromptView
-(id)initWithScore:(OpenScore)score {

    self = [super init];
    if (self) {
        self.backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.2];
        self.frame = [UIScreen mainScreen].bounds;
        [self creatView];
        self.scroe = score;
    }
    return self;
}
-(id)initWithName:(NSString *)name TitleArr:(NSArray *)titleArr selectNameArr:(NSArray *)nameArr comBool:(BOOL)comBool sureBlock:(void(^)())sureBlock cancelBlock:(void(^)())cancelBlock{
    self = [super init];
    if (self) {
        self.sureBlock = sureBlock;
        self.cancelBlock = cancelBlock;
        self.comBool = comBool;
        self.name = name;
        self.titleArr = titleArr;
        self.nameArr = nameArr;
        //临时添加
        self.openScore = YES;
        self.backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.2];
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}
-(void)creatView {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    UIView * promptView = [[UIView alloc] init];
    promptView.backgroundColor = kUIColorFromRGB(0xFCFCFC);
    promptView.layer.cornerRadius = 5;
    promptView.layer.masksToBounds = YES;
    [self  addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(173);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
    }];
    
    
    UILabel * promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"新人礼盒";
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.textColor = kUIColorFromRGB(0xFA5578);
    promptLabel.font = [UIFont systemFontOfSize:16];
    [promptView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(promptView);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
        make.top.equalTo(promptView).offset(20);
        make.height.mas_equalTo(16);
    }];
    
    
    UILabel * contentLabel = [[UILabel alloc] init];
    self.contentLabel = contentLabel;
    contentLabel.textColor = ComonTitleColor;
    contentLabel.font = [UIFont systemFontOfSize:16];
    [promptView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptView).offset(71.5);
        make.centerX.equalTo(promptView);
    }];
    contentLabel.text = @"叮咚～您有一份新人礼盒，请签收～";

    
    UIView * botomLine = [[UIView alloc] init];
    botomLine.backgroundColor = kUIColorFromRGB(0xE7E7E7);
    [promptView addSubview:botomLine];
    [botomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(promptView.mas_bottom).offset(-50.5);
        make.left.and.right.equalTo(promptView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UIButton * sureBtn = [[UIButton alloc] init];
    [promptView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn setTitleColor:kUIColorFromRGB(0xFB5B5E) forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(promptView).offset(0);
        make.bottom.equalTo(promptView);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
    }];
    [HXScorePromptView exChangeOut:promptView dur:0.5];
}
-(void)showAlert {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatAlertViewWithName:self.name TitleArr:self.titleArr selectNameArr:self.nameArr];
    
}
// - alertview弹出动画
+ (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
}


-(void)changeScore:(NSString *)score {
    self.contentLabel.text = [NSString stringWithFormat:@"WOW～您获得了: %@趣贝",score];
    long len2 = [[NSString stringWithFormat:@"%@趣贝",score] length];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:self.contentLabel.text];
    long len1 = [@"WOW～您获得了: " length];
    [str2 addAttribute:NSForegroundColorAttributeName value:ComonBackColor range:NSMakeRange(len1,len2)];
    self.contentLabel.attributedText = str2;
    self.openScore = YES;
}
-(void)sureBtnAction:(UIButton *)sender {
    if (self.openScore) {
        [self.freeView removeFromSuperview];
        self.freeView = nil;
        [self removeFromSuperview];
        if (self.scroe) {
            self.scroe(@"1");
        }
        return;
    }
    if (self.scroe) {
        self.scroe(@"0");
    }
}


#pragma mark --筛选框
-(void)creatAlertViewWithName:(NSString *)name TitleArr:(NSArray *)titleArr selectNameArr:(NSArray *)nameArr  {
    UIView * promptView = [[UIView alloc] init];
    promptView.backgroundColor = kUIColorFromRGB(0xFCFCFC);
    promptView.layer.cornerRadius = 5;
    promptView.layer.masksToBounds = YES;
    [self  addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(0);
        make.left.equalTo(self).offset(30);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.hidden = YES;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    titleLabel.textColor = ComonCharColor;
    [promptView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(promptView);
        make.top.equalTo(promptView).offset(30);
    }];
    
    UILabel * firTitleLabel = [[UILabel alloc] init];
    firTitleLabel.hidden = YES;
    firTitleLabel.textColor = ComonTextColor;
    firTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [promptView addSubview:firTitleLabel];
    [firTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptView).offset(45/2);
        make.centerX.equalTo(promptView);
    }];
    
    UILabel * secTitleLabel = [[UILabel alloc] init];
    secTitleLabel.hidden = YES;
    secTitleLabel.textColor = ComonTextColor;
    secTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [promptView addSubview:secTitleLabel];
    [secTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firTitleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(promptView);
    }];
    
    
    if (name.length==0) {
        titleLabel.hidden = YES;
        firTitleLabel.hidden =  NO;
        
        if (titleArr.count==1&&titleArr) {
            secTitleLabel.hidden = YES;
            
            [promptView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(150);
            }];
            firTitleLabel.text = [titleArr firstObject];
            [firTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(promptView).offset(42);
            }];
        }else if(titleArr.count==2&&titleArr){
            secTitleLabel.hidden = NO;
            [promptView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(150);
            }];
            
            firTitleLabel.text = [titleArr firstObject];
            [firTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(promptView).offset(25);
                make.height.mas_equalTo(16);
            }];
            
            
            secTitleLabel.text = [titleArr lastObject];
            [secTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(firTitleLabel.mas_bottom).offset(10);
            }];
        }else {
            //异常
            [self removeFromSuperview];
            return;
        }
    }else {
        titleLabel.text = name;
        titleLabel.hidden =NO;
        [titleLabel layoutIfNeeded];
        firTitleLabel.hidden =  NO;
        
        if (titleArr.count==1&&titleArr) {
            [promptView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(198);
            }];
            
            firTitleLabel.text = [titleArr firstObject];
            [firTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(promptView).offset(42+48);
                make.centerX.equalTo(firTitleLabel);
            }];
            
        }else if(titleArr.count==2&&titleArr){
            secTitleLabel.hidden = NO;
            [promptView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(198);
            }];

            firTitleLabel.text = [titleArr firstObject];
            [firTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(promptView).offset(25+48);
                make.centerX.equalTo(promptView);
                make.height.mas_equalTo(16);
            }];
            
            secTitleLabel.text = [titleArr lastObject];
            [secTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(firTitleLabel.mas_bottom).offset(10);
                make.centerX.equalTo(promptView);
            }];
        }else {
            //异常
            [self removeFromSuperview];
            return;
        }
        
    }
    UIView * botomLine = [[UIView alloc] init];
    botomLine.backgroundColor = kUIColorFromRGB(0xE7E7E7);
    [promptView addSubview:botomLine];
    [botomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(promptView.mas_bottom).offset(-50.5);
        make.left.and.right.equalTo(promptView);
        make.height.mas_equalTo(0.5);
    }];
    
    if (nameArr.count==1) {
        UIButton * sureBtn = [[UIButton alloc] init];
        [promptView addSubview:sureBtn];
        sureBtn.tag = 201;
        [sureBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [sureBtn setTitleColor:kUIColorFromRGB(0xFB5B5E) forState:UIControlStateNormal];
        [sureBtn setTitle:[nameArr firstObject] forState:UIControlStateNormal];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(promptView).offset(0);
            make.bottom.equalTo(promptView);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(SCREEN_WIDTH-60);
        }];
    }else if(nameArr.count==2){
        for (int i = 0; i<2; i++) {
            UIButton * sureBtn = [[UIButton alloc] init];
            [promptView addSubview:sureBtn];
            sureBtn.tag = i+200;
            [sureBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            if (i==0) {
                self.leftBtn = sureBtn;
                [sureBtn setTitleColor:self.comBool?ComonTitleColor:kUIColorFromRGB(0xFB5B5E) forState:UIControlStateNormal];
                [sureBtn setTitle:[nameArr firstObject] forState:UIControlStateNormal];
            }else {
                self.rightBtn = sureBtn;
                [sureBtn setTitleColor:self.comBool?kUIColorFromRGB(0xFB5B5E):ComonTitleColor forState:UIControlStateNormal];
                [sureBtn setTitle:[nameArr lastObject] forState:UIControlStateNormal];
                
            }
            [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(promptView.mas_left).offset(i*(SCREEN_WIDTH-60)/2);
                make.bottom.equalTo(promptView);
                make.height.mas_equalTo(50);
                make.width.mas_equalTo((SCREEN_WIDTH-60)/2);
            }];
        }
        
        UIView * comenLine = [[UIView alloc] init];
        comenLine.backgroundColor = kUIColorFromRGB(0xE4E4E4);
        [promptView addSubview:comenLine];
        [comenLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(promptView);
            make.width.mas_equalTo(0.5);
            make.bottom.equalTo(promptView);
            make.height.mas_equalTo(50);
        }];
    }else {
        [self removeFromSuperview];
        return;
    }
    [HXScorePromptView exChangeOut:promptView dur:0.5];
    
}
-(void)selectAction:(UIButton *)sender {
    if (sender.tag == 200) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }else {
        if (self.sureBlock) {
            self.sureBlock();
        }
    }
    [self removeFromSuperview];
}

@end



@interface HXPaymentView()
@property (nonatomic,strong)UIView * backView;
@property (nonatomic,strong)SureBlock sureBlock;
@property (nonatomic,strong)CancelBlock cancelBlock;
@property (nonatomic,strong)NSString * orderNo;
@property (nonatomic,strong)HXPayView *payView;
@end
@implementation HXPaymentView
-(id)initWithOrderNo:(NSString *)orderNo sureBlock:(void(^)())sureBlock cancelBlock:(void(^)())cancelBlock{
    self = [super init];
    if (self) {
        self.sureBlock = sureBlock;
        self.cancelBlock = cancelBlock;
        self.orderNo = orderNo;
        [self creatView];
    }
    return self;
    
}
-(void)creatView {
    UIView * freeView = [[UIView alloc] init];
    self.freeView = freeView;
    freeView.backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.2];
    [[UIApplication sharedApplication].keyWindow addSubview:freeView];
    [freeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo([UIApplication sharedApplication].keyWindow);
        make.bottom.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom).offset(201.5 + 50);
    }];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT+201.5 + 90, SCREEN_WIDTH, 201.5 + 90)];
    self.backView = backView;
    backView.backgroundColor = CommonBackViewColor;
    [freeView addSubview:backView];
    
    UILabel * zfLabel = [[UILabel alloc] init];
    [zfLabel setText:@"支付方式"];
    [zfLabel setTextColor:ComonTextColor];
    [zfLabel setFont:[UIFont systemFontOfSize:16]];
    [backView addSubview:zfLabel];
    [zfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(20);
        make.left.equalTo(backView).offset(15);
    }];
    
    for (int i =0; i<3; i++) {
        UIButton * paymentBtn = [[UIButton alloc] init];
        paymentBtn.layer.cornerRadius = 3;
        paymentBtn.tag = i+500;
        paymentBtn.layer.masksToBounds = YES;
//        [paymentBtn setTitle:i==0?@"取消":@"支付宝" forState:UIControlStateNormal];
        [paymentBtn setTitleColor:i==0?ComonTitleColor:CommonBackViewColor forState:UIControlStateNormal];
        [paymentBtn addTarget:self action:@selector(paymentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        paymentBtn.backgroundColor = i!=0?kUIColorFromRGB(0x00AAEE):kUIColorFromRGB(0xF2F4F5);
        [backView addSubview:paymentBtn];
        [paymentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(backView).offset(i==0?-15:-95);
            /*
             0  15
             1  15 + 50 + 15*2
             2  15 + 50*2 + 15*4
             15 + 50*i + 15*2*i
             */
            
            make.bottom.equalTo(backView).offset(-15*(1+2*i) - 50*i);
            make.left.equalTo(backView).offset(15);
            make.right.equalTo(backView).offset(-15);
            make.height.mas_equalTo(50);
        }];
        if (i==0) {
            [paymentBtn setTitle:@"取消" forState:UIControlStateNormal];
            paymentBtn.backgroundColor = kUIColorFromRGB(0xF2F4F5);
            UIView * lineView = [[UIView alloc] init];
            lineView.backgroundColor = kUIColorFromRGB(0xe6e6e6);
            [backView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(backView);
                make.height.mas_equalTo(0.5);
                make.bottom.equalTo(backView).offset(-80);
            }];
        } else if (i == 1){
            [paymentBtn setTitle:@"支付宝" forState:UIControlStateNormal];
            paymentBtn.backgroundColor = kUIColorFromRGB(0x00AAEE);
            UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhifubao"]];
            [paymentBtn addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(paymentBtn).offset(12);
                make.centerY.equalTo(paymentBtn);
            }];
        } else if (i == 2) {
            UIView * lineView = [[UIView alloc] init];
            lineView.backgroundColor = kUIColorFromRGB(0xe6e6e6);
            [backView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(backView);
                make.height.mas_equalTo(0.5);
                make.bottom.equalTo(backView).offset(-160);
            }];
            
            [paymentBtn setTitle:@"微信" forState:UIControlStateNormal];   //150  211  103
            paymentBtn.backgroundColor = ColorWithRGB(150,211,103);
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechat"]];
            [paymentBtn addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(paymentBtn).offset(10);
                make.centerY.equalTo(paymentBtn);
            }];
        }
    }
    
    [UIView animateWithDuration:(0.5)//动画持续时间
                     animations:^{
                         //执行的动画
                         self.backView.frame = CGRectMake(0, SCREEN_HEIGHT-201.5 - 90, SCREEN_WIDTH, 201.5 + 90);
                     }completion:^(BOOL finished){
                         //动画执行完毕后的操作
                         
                     }];
}

-(void)paymentBtnAction:(UIButton *)button {
    if (button.tag==500) {
        [UIView animateWithDuration:(0.2)//动画持续时间
                         animations:^{
                             //执行的动画
                             self.backView.frame = CGRectMake(0, SCREEN_HEIGHT+201.5 + 90, SCREEN_WIDTH, 201.5 + 90);
                         }completion:^(BOOL finished){
                             //动画执行完毕后的操作
                             [self.freeView removeFromSuperview];
                             [self.backView removeFromSuperview];
                             [self removeFromSuperview];
                             if (self.cancelBlock) {
                                 self.cancelBlock();
                             }
                         }];
    } else {
        [self.freeView removeFromSuperview];
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
        
        self.payView = [[HXPayView alloc] init];
//        [MBProgressHUD showMessage:nil toView:self.controller.view];
        
        int type = 0;
        
        if(button.tag == 501) {
//            self.payView = [[HXPayView alloc] init];
//            [MBProgressHUD showMessage:nil toView:self.controller.view];
//            [self.payView pay:self.orderNo orderServiceBool:self.orderServiceBool successBlock:^{
//                if (self.sureBlock) {
//                    self.sureBlock(@"1");
//                } else {
//                    [MBProgressHUD hideHUDForView:self.controller.view];
//                }
//            } failBlock:^{
//                [MBProgressHUD hideHUDForView:self.controller.view];
//                if (self.sureBlock) {
//                    self.sureBlock(@"0");
//                }
//            }];
            
//            NSLog(@"支付宝支付");
            type = 1;
        } else if (button.tag == 502) {
//            NSLog(@"微信支付");
            type = 2;
        }
        
        [self.payView payWithType:type orderNum:self.orderNo orderServiceBool:self.orderServiceBool successBlock:^{
            if (self.sureBlock) {
                self.sureBlock(@"1");
            } else {
                [MBProgressHUD hideHUDForView:self.controller.view];
            }
        } failBlock:^{
            [MBProgressHUD hideHUDForView:self.controller.view];
            if (self.sureBlock) {
                self.sureBlock(@"0");
            }
        }];
    }
}


@end
