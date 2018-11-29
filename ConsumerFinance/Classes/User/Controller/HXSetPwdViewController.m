//
//  HXSetPwdViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2018/1/9.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HXSetPwdViewController.h"

@interface HXSetPwdViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *okButton;

@property (nonatomic, strong) UITextField *textPwd;
@property (nonatomic, strong) UITextField *textNewPwd;

@end

@implementation HXSetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    [self setUpView];
    
    [self.textNewPwd becomeFirstResponder];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGestureClick)];
    [self.view addGestureRecognizer:tapGesture];
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

- (void)setUpNav {
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:@"loginBack"];
}

- (void) setUpView {
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.view).offset(10);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(34);
    }];
    
    [self.view addSubview:self.textNewPwd];
    [self.textNewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(40);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(60);
    }];
    [self.textNewPwd layoutIfNeeded];
    [self.textNewPwd setBottomBorder:ColorWithHex(0xF1F1F1)];
    
    [self.view addSubview:self.textPwd];
    [self.textPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.textNewPwd.mas_bottom).offset(0);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(60);
    }];
    [self.textPwd layoutIfNeeded];
    [self.textPwd setBottomBorder:ColorWithHex(0xF1F1F1)];
    
    [self.view addSubview:self.okButton];
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(self.textPwd.mas_bottom).offset(40);
        make.height.mas_equalTo(50);
    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setText:@"设置登录密码"];
        _titleLabel.font = [UIFont systemFontOfSize:34];
        _titleLabel.textColor = ColorWithHex(0x333333);
    }
    return _titleLabel;
}

- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [[UIButton alloc] init];
        _okButton.enabled = NO;
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        [_okButton setTitleColor:ColorWithHex(0xffffff) forState:UIControlStateNormal];
        [_okButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _okButton.backgroundColor = ColorWithHex(0xFFB0CC);
        _okButton.layer.cornerRadius = 25;
        [_okButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

- (UITextField *)textNewPwd {
    if (!_textNewPwd) {
        _textNewPwd = [[UITextField alloc] init];
        _textNewPwd.tag = 0;
        _textNewPwd.delegate = self;
        _textNewPwd.tintColor = ColorWithHex(0xFF6098);
        _textNewPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textNewPwd.placeholder = @"6-20位数字、字母";
        [_textNewPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        _textNewPwd.secureTextEntry = YES;
    }
    return _textNewPwd;
}

- (UITextField *)textPwd {
    if (!_textPwd) {
        _textPwd = [[UITextField alloc] init];
        _textPwd.tag = 1;
        _textPwd.delegate = self;
        _textPwd.tintColor = ColorWithHex(0xFF6098);
        _textPwd.placeholder = @"请再次输入密码";
        _textPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _textPwd.secureTextEntry = YES;
        [_textPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textPwd;
}

#pragma mark - Private

- (void)tapGestureClick {
    [self.view endEditing:YES];
}

- (void)finishButtonState {
    if (self.textPwd.text.length >= 6 && self.textNewPwd.text.length >= 6) {
        self.okButton.enabled = YES;
        self.okButton.backgroundColor = ColorWithHex(0xFF6098);
        
    } else {
        self.okButton.enabled = NO;
        self.okButton.backgroundColor = ColorWithHex(0xFFB0CC);
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (![Helper hasOnlyNumAndChar:textField.text] || textField.text.length > 20) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }
    [self finishButtonState];
}

- (void)okButtonClick:(UIButton *)button {
    [self.view endEditing:YES];
    NSString *pwdText = [self.textNewPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![Helper justPassword:pwdText]) {
        [KeyWindow displayMessage:@"请输入6-20位，密码仅支持数字或字母"];
        return;
    }
    if (![self.textNewPwd.text isEqualToString:self.textPwd.text]) {
        [KeyWindow displayMessage:@"两次密码输入不一致"];
        return;
    }
    
    NSString *pwd = [NSString stringWithFormat:@"%@%@",access_key,pwdText];
    NSString *encryption_md5     = [MD5Encryption md5by32:pwd];
    
    NSDictionary *body = @{
                           @"password":encryption_md5,
                           @"repeatPassword":encryption_md5
                           };
    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] post:@"user/setPassword" parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [[NSUserDefaults standardUserDefaults] setObject:encryption_md5 forKey:kPassword];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (void)onBack {
    if (self.isNeedLoginOut) {
        [[HXNetManager shareManager] post:@"user/logout" parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
            [MBProgressHUD hideHUDForView:self.view];
            if ([responseNewModel.status isEqualToString:@"0000"]) {
                
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view];
        }];
        [[AppManager manager] signOutProgressHandler:self userInfo:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
