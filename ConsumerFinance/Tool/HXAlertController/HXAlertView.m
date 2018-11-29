//
//  YBAlertView.m
//  YBAlertView_Demo
//
//  Created by Jason on 16/1/12.
//  Copyright © 2016年 www.jizhan.com. All rights reserved.
//

#import "HXAlertView.h"
#import "HDTextField.h"

#define VIEW_HEIGHT 160
#define VIEW_WIDTH  300
@interface HXAlertView ()<UITextFieldDelegate>
{
    UILabel *_titleLabel;
    HDTextField *_textField;
    HXButton *_smsBut;
    UIButton * _confirmBtn;
}
@property (nonatomic, strong) UIView *bgView;

@end

@implementation HXAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake((SCREEN_WIDTH-VIEW_WIDTH)/2, kScreenH/2 - 100, VIEW_WIDTH, VIEW_HEIGHT)];
    if (self) {
        
        
        self.backgroundColor = ColorWithRGB(242, 242, 242);
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.width, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = _title;
        _titleLabel.textColor = ColorWithRGB(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_titleLabel];
        
        
        
        _textField = [[HDTextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_titleLabel.frame) + 10, self.width-32, 40)];
        _textField.tag = 100;
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _textField.layer.cornerRadius = 5;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.placeholder = _placeHoderStr;
        _textField.font = [UIFont systemFontOfSize:14];
        [self addSubview:_textField];
        
        _smsBut = [[HXButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        _smsBut.titleStr = @"S";
        [_smsBut timeStart];
        [_smsBut addTarget:self action:@selector(getSMSCode:) forControlEvents:UIControlEventTouchUpInside];
        _textField.rightView = _smsBut;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_textField.width-80-5, 8, 0.5, _textField.height-16)];
        line.backgroundColor = ColorWithRGB(151, 151, 151);
        [_textField addSubview:line];
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake((self.width-_textField.width/2)/2, CGRectGetMaxY(_textField.frame) + 15, self.width/2-5, 38);
        [_confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.textColor = ColorWithRGB(255, 255, 255);
        _confirmBtn.backgroundColor = ColorWithRGB(21, 164, 232);
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.cornerRadius = 3.0f;
        [self addSubview:_confirmBtn];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(VIEW_WIDTH - 20 - 10, 10.f, 20, 20);
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        self.layer.cornerRadius = 10;
        self.backgroundColor = ColorWithRGB(242, 242, 242);
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)show
{
    if (self.bgView) return;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.4;
    
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    //animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:animation forKey:nil];
    
    [window addSubview:self.bgView];
    
    [window addSubview:self];
    
    
    
}
//关闭
- (void)close{
    [self removeFromSuperview];
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [_smsBut invlidateTimer];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [self close];
}

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
//取消修改手势密码
- (void)cancelClick:(UIButton *)btn
{
    [_textField resignFirstResponder];
    [btn.superview performSelector:@selector(close)];
}
//确定输入登录密码
-  (void)confirmClick:(UIButton *)btn
{
    
    [_textField resignFirstResponder];
    
    if (self.clickAlertControllerBlock) {
        NSString *contentStr = _textField.text;
        self.clickAlertControllerBlock(contentStr);
        if (contentStr.length != 0 || ![contentStr isEqualToString:@""]) {
            [btn.superview performSelector:@selector(close)];
        }
        
    }
    
}


- (void)setPayButtonTitle:(NSString *)payButtonTitle{

    [_confirmBtn setTitle:payButtonTitle forState:UIControlStateNormal];
}
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
    
}
-(void)setPlaceHoderStr:(NSString *)placeHoderStr{
    _placeHoderStr = placeHoderStr;
    _textField.placeholder = placeHoderStr;
}


- (void) getSMSCode:(HXButton*)but{
    
    if ([self.delegate respondsToSelector:@selector(sendSMS:)]) {
        [self.delegate sendSMS:but];
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    NSInteger allowedLength = 6;
    NSString  *astring      = LIMIT_NUMBERS;
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

@end
