//
//  SMSAuthenticationView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/27.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "SMSAuthenticationView.h"
#import "HXButton.h"
@interface SMSAuthenticationView()<UITextFieldDelegate>
@property (nonatomic,strong)HXButton *msgCodeBut;
@property (nonatomic,strong)UITextField * codeText;
@property (nonatomic,strong)UILabel * messageLabel;
@end
@implementation SMSAuthenticationView
-(id)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}
-(void)creatView {
    
    UIView * headView = [[UIView alloc] init];
    headView.backgroundColor = kUIColorFromRGB(0xf2f4f5);
    [self addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = ComonTextColor;
    titleLabel.text = @"输入短信验证码";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(headView);
    }];
    
    UILabel * sendLabel = [[UILabel alloc] init];
    self.sendLabel = sendLabel;
    sendLabel.font = [UIFont systemFontOfSize:13];
    sendLabel.textColor = kUIColorFromRGB(0x666666);
//    NSString *numberString ;
//    if ([[AppManager manager] getMyPhone].length !=0) {
//        numberString =  [[[AppManager manager] getMyPhone] stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"******"];
//    }
//    sendLabel.text =[NSString stringWithFormat:@"短信正在发送至 :%@",numberString];
    [self addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(20);
        make.left.equalTo(self).offset(33);
        make.height.mas_equalTo(13);
    }];
    
    UIView * writeView = [[UIView alloc] init];
    writeView.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
    writeView.layer.borderWidth = 1;
    [self addSubview:writeView];
    [writeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(sendLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
    }];
    
    UITextField * codeText = [[UITextField alloc] init];
    self.codeText = codeText;
    codeText.delegate =self;
    codeText.tag = 1;
    codeText.keyboardType = UIKeyboardTypeNumberPad;
    codeText.textColor = ComonTextColor;
    codeText.font = [UIFont fontWithName:@".PingFangSC-Regular" size:24];
    [writeView addSubview:codeText];
    [codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(writeView);
        make.left.equalTo(writeView).offset(15);
        make.right.equalTo(writeView.mas_right).offset(-100);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = kUIColorFromRGB(0xd8d8d8);
    [writeView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(writeView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(0.5);
        make.right.equalTo(writeView.mas_right).offset(-95);
    }];
    
    /**
     *   验证码按钮
     */
    _msgCodeBut = [[HXButton alloc] init];
    _msgCodeBut.titleLabel.font = [UIFont systemFontOfSize:16];
    [_msgCodeBut setTitleColor:HXRGB(60, 155, 255)
                      forState:UIControlStateNormal];
    [_msgCodeBut addTarget:self action:@selector(getSMSCode:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_msgCodeBut];
    [_msgCodeBut  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(writeView).offset(0);
        make.right.equalTo(writeView);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(50);
    }];
    
    UILabel * messageLabel = [[UILabel alloc] init];
    self.messageLabel =messageLabel;
//    messageLabel.text = @"验证码错误";
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = ComonBackColor;
    [self addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(writeView.mas_bottom).offset(10);
    }];
    
    for (int i = 0; i<2; i++) {
        UIButton * btn = [[UIButton alloc] init];
        btn.tag = 200+i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn setTitle:i==0?@"取消":@"确认" forState:UIControlStateNormal];
        [btn setTitleColor:i==0?kUIColorFromRGB(0x666666) :kUIColorFromRGB(0x4A90E2) forState:UIControlStateNormal];
        [btn setBackgroundColor:kUIColorFromRGB(0xFAFAFA)];
        [btn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset((SCREEN_WIDTH-60)/2*i);
            make.width.mas_equalTo((SCREEN_WIDTH-60)/2);
            make.height.mas_equalTo(50);
        }];
    }
    
    UIView * bottomLine = [[UIView alloc] init];
    [bottomLine setBackgroundColor:kUIColorFromRGB(0xD8D8D8)];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-50);
        make.left.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView * suLineView = [[UIView alloc] init];
    [suLineView setBackgroundColor:kUIColorFromRGB(0xD8D8D8)];
    [self addSubview:suLineView];
    [suLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(50);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(0.5);
    }];
    
}
-(void)startTimer {
    
    [self endEditing:YES];
    [_msgCodeBut timeStart];
    
}
-(void)stopTimer {
    
   [_msgCodeBut invlidateTimer];
}

-(void)clearnMessage:(NSString *)str {
    self.messageLabel.hidden =NO;
    self.messageLabel.text = str;
    _codeText.text = @"";
}
/**
 *  获取短信验证码
 */
-(void)getSMSCode:(HXButton*)but{
    self.messageLabel.text = @"";
    if (self.timerClick) {
        self.timerClick();
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger allowedLength = 100;
    NSString  *astring      = @"";
    self.messageLabel.text = @"";
    
    switch (textField.tag) {
        case 1: {
            allowedLength = 6;
            astring       = LIMIT_NUMBERS;
        }
            break;
            
        default:
            break;
    }
    
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    
    if ([NSString isBlankString:astring]) {
        if ([textField.text length] < allowedLength || [string length] == 0) {
            return YES;
        }else {
            [textField shakeAnimation];
            return NO;
        }
    } else {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:astring] invertedSet];
        //按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL canChange     = [string isEqualToString:filtered];
        
        if ((canChange && [textField.text length] < allowedLength) || [string length] == 0) {
            return YES;
        }else {
            [textField shakeAnimation];
            return NO;
        }
    }
    
}
-(void)sureBtnAction:(UIButton *)btn {
    
    if (btn.tag == 200) {
        if (self.cancel) {
            [_codeText resignFirstResponder];
            self.cancel();
        }
    }
    if (self.codeText.text.length<6) {
        self.messageLabel.text = @"验证码必须为6位数字";
        return;
    }
    if (btn.tag==201) {
        if (self.clickBtn) {
            [_codeText resignFirstResponder];
            self.clickBtn(self.codeText.text);
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
