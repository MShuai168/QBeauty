//
//  YBAlertView.m
//  YBAlertView_Demo
//
//  Created by Jason on 16/1/12.
//  Copyright © 2016年 www.jizhan.com. All rights reserved.
//

#import "HXAlertController.h"
#import "HDTextField.h"
@interface HXAlertController ()<UITextFieldDelegate>
{
    UILabel *_titleLabel;
    HDTextField *_textField;
    BOOL _isNumberBoardType;
}
@property (nonatomic, strong) UIView *bgView;

@end

@implementation HXAlertController
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(20, kScreenH/2 - 100, kScreenW-40, 160)];
    if (self) {
        
        
        self.backgroundColor = ColorWithRGB(242, 242, 242);
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.width, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = _title;
        _titleLabel.textColor = ColorWithRGB(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_titleLabel];
        
        
        
        _textField = [[HDTextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_titleLabel.frame) + 15, self.width-32, 34)];
        _textField.delegate = self;
        _textField.tag = 100;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _textField.layer.cornerRadius = 5;
        _textField.text = _textStr;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.placeholder = _placeHoderStr;
        _textField.font = [UIFont systemFontOfSize:14];
        [self addSubview:_textField];
        
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(_textField.frame) + 15, _textField.width/2-5, 34);
        [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:ColorWithRGB(21, 164, 232) forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cancelBtn.backgroundColor = ColorWithRGB(255, 255, 255);
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.layer.cornerRadius = 2.0f;
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"btn_cancel.png"] forState:UIControlStateNormal];
        [self addSubview:cancelBtn];
        
        UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame)+10, CGRectGetMaxY(_textField.frame) + 15, _textField.width/2-5, 34);
        [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        confirmBtn.titleLabel.textColor = ColorWithRGB(255, 255, 255);
        confirmBtn.backgroundColor = ColorWithRGB(21, 164, 232);
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        confirmBtn.layer.masksToBounds = YES;
        confirmBtn.layer.cornerRadius = 3.0f;
        [self addSubview:confirmBtn];

        
        
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
        self.clickAlertControllerBlock(_textField.text);
        
        if ((_textField.text.length != 0 || ![_textField.text isEqualToString:@""]) && ![Helper stringContainsEmoji:_textField.text] && ![Helper hasSpecialChar:_textField.text]) {
            [btn.superview performSelector:@selector(close)];
        }
    }
    
}
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
    
}
-(void)setPlaceHoderStr:(NSString *)placeHoderStr{
    _placeHoderStr = placeHoderStr;
    _textField.placeholder = placeHoderStr;
}
-(void)setTextStr:(NSString *)textStr{
    _textStr = textStr;
    _textField.text = textStr;
}


- (void)setKeyBoardType:(UIKeyboardType )keyBoardType{
    _keyBoardType = keyBoardType;
    _isNumberBoardType = (keyBoardType == UIKeyboardTypeNumberPad) ? YES : NO;
    _textField.keyboardType = keyBoardType;
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    if (_isNumberBoardType) {
        NSInteger allowedLength = 11;
        NSString  *astring      = LIMIT_NUMBERS;
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

    }else{
   
        return YES;
    }
    
    
}


@end
