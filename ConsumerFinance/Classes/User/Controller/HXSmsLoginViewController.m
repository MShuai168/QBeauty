//
//  HXSmsLoginViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2018/1/9.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HXSmsLoginViewController.h"
#import "HXCodeViewController.h"
#import <RZDataBinding/RZDataBinding.h>

@interface HXSmsLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textPhone;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation HXSmsLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    [self setUpView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGestureClick)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self.textPhone becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hiddenNavgationBarLine:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hiddenNavgationBarLine:NO];
    
    [self.view endEditing:YES];
}

- (void) setUpView {
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.view).offset(10);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(34);
    }];
    
    [self.view addSubview:self.textPhone];
    [self.textPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(40);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(60);
    }];
    [self.textPhone layoutIfNeeded];
    [self.textPhone setBottomBorder:ColorWithHex(0xF1F1F1)];

    [self.view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(self.textPhone.mas_bottom).offset(40);
        make.height.mas_equalTo(50);
    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setText:@"输入手机号"];
        _titleLabel.font = [UIFont systemFontOfSize:34];
        _titleLabel.textColor = ColorWithHex(0x333333);
    }
    return _titleLabel;
}

- (UITextField *)textPhone {
    if (!_textPhone) {
        _textPhone = [[UITextField alloc] init];
        _textPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textPhone.delegate = self;
        _textPhone.tintColor = ColorWithHex(0xFF6098);
        _textPhone.keyboardType = UIKeyboardTypeNumberPad;
        [_textPhone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textPhone.placeholder = @"请输入手机号";
    }
    return _textPhone;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        _nextButton.enabled = NO;
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_nextButton setTitleColor:ColorWithHex(0xffffff) forState:UIControlStateNormal];
        [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _nextButton.backgroundColor = ColorWithHex(0xFFB0CC);
        
        _nextButton.layer.cornerRadius = 25;
    }
    return _nextButton;
}

- (void)setUpNav {
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:@"loginBack"];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField setBottomBorder:ColorWithHex(0xFF6098)];
    
    return YES;
}

#pragma  mark - Private

- (void)tapGestureClick {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSString *phone = [self.textPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (phone.length > 11) {
        self.textPhone.text = [phone substringToIndex:11];
    }
    if (self.textPhone.text.length == 11) {
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = ColorWithHex(0xFF6098);
        
    } else {
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = ColorWithHex(0xFFB0CC);
    }
}

- (void)nextButtonClick:(UIButton *)button {
    [self.view endEditing:YES];
    if (self.textPhone.text.length == 0) {
        //不是标准的手机号码
        [KeyWindow displayMessage:@"手机号码不能为空"];
        return;
    }
    if (![Helper justMobile:self.textPhone.text]) {
        [KeyWindow displayMessage:@"您输入的手机号错误"];
        return;
    }
    NSString *phone = [self.textPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [MBProgressHUD showMessage:nil toView:self.view];
    NSString *codeType = @"";
    switch (self.smsType) {
        case smsByTypeRegisterEnum:
            codeType = @"1";
            break;
        case smsByTypeLoginEnum:
            codeType = @"2";
            break;
        case smsByTypeForgetPwdEnum:
            codeType = @"3";
            break;
        case smsByTypeResetPwdEnum:
            codeType = @"4";
            break;
            
        default:
            break;
    }
    
    [[HXNetManager shareManager] get:@"user/getVerificationCode" parameters:@{@"cellphone":phone.length!=0?phone:@"",@"codeType":codeType} sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            HXCodeViewController *controller = [[HXCodeViewController alloc] init];
            controller.tellPhone = self.textPhone.text;
            controller.isGoToSetPwd = self.isGoToSetPwd;
            controller.smsType = self.smsType;
            [self.navigationController pushViewController:controller animated:YES];
            return ;
        }
        [KeyWindow displayMessage:responseNewModel.message];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
