//
//  LoginViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2018/1/8.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HXLoginViewController.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
#import "ProViewController.h"
#import "HXSmsLoginViewController.h"
#import "HXSetPwdViewController.h"
#import "UITextField+Category.h"
#import "HXAlertViewController.h"
#import "NSString+WPAttributedMarkup.h"
#import <RZDataBinding/RZDataBinding.h>
#import "HXAgreementModel.h"

#import "HXScoreHomeViewController.h"

@interface HXLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) WPHotspotLabel *proLabel;

@property (nonatomic, strong) UITextField *textPhone;
@property (nonatomic, strong) UITextField *textPwd;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) NSMutableArray *  agreementArr;

@end

@implementation HXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavgation];
    [self setUpView];
    [self showAgreement];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGestureClick)];
    [self.view addGestureRecognizer:tapGesture];
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hiddenNavgationBarLine:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hiddenNavgationBarLine:NO];
    // 开启返回手势
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
}

- (void)setUpNavgation {
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:@"loginClose"];
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerButtonClick)];
    [rightBtn setTintColor:ColorWithHex(0xFF6098)];
    [rightBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = rightBtn;
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
    
    [self.view addSubview:self.textPwd];
    [self.textPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.textPhone.mas_bottom).offset(0);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(60);
    }];
    [self.textPwd layoutIfNeeded];
    [self.textPwd setBottomBorder:ColorWithHex(0xF1F1F1)];
    
    [self.view addSubview:self.errorLabel];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.textPwd.mas_bottom).offset(5);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(14);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(self.textPwd.mas_bottom).offset(40);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(self.loginButton.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.proLabel];
    self.proLabel.hidden = YES;
    [self.proLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(self.proLabel.intrinsicContentSize);
    }];
}

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] init];
        _errorLabel.hidden = YES;
        _errorLabel.textColor = ColorWithHex(0xFF6098);
        _errorLabel.font = [UIFont systemFontOfSize:14];
        _errorLabel.text = @"账号密码不符合";
    }
    return _errorLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setText:@"账号登录"];
        _titleLabel.font = [UIFont systemFontOfSize:34];
        _titleLabel.textColor = ColorWithHex(0x333333);
    }
    return _titleLabel;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.enabled = NO;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:ColorWithHex(0xffffff) forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _loginButton.backgroundColor = ColorWithHex(0xFFB0CC);
        _loginButton.layer.cornerRadius = 25;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        
        UILabel *smsLabel = [[UILabel alloc] init];
        smsLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *smsTapGesture = [[UITapGestureRecognizer alloc] init];
        [smsTapGesture addTarget:self action:@selector(smsTapGestureClick)];
        [smsLabel addGestureRecognizer:smsTapGesture];
        smsLabel.text = @"短信登录";
        smsLabel.textColor = ColorWithHex(0x999999);
        smsLabel.font = [UIFont systemFontOfSize:14];
        smsLabel.textAlignment = NSTextAlignmentRight;
        [_footerView addSubview:smsLabel];
        [smsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(_footerView);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ColorWithHex(0xE6E6E6);
        [_footerView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(smsLabel.mas_right).offset(20);
            make.center.equalTo(_footerView);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(1);
        }];
        
        UILabel *forgetLabel = [[UILabel alloc] init];
        forgetLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *forgetTapGesture = [[UITapGestureRecognizer alloc] init];
        [forgetTapGesture addTarget:self action:@selector(forgetTapGestureClick)];
        [forgetLabel addGestureRecognizer:forgetTapGesture];
        
        forgetLabel.text = @"忘记密码？";
        forgetLabel.textColor = ColorWithHex(0x999999);
        forgetLabel.font = [UIFont systemFontOfSize:14];
        forgetLabel.textAlignment = NSTextAlignmentLeft;
        [_footerView addSubview:forgetLabel];
        [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(_footerView);
            make.left.equalTo(lineView.mas_right).offset(20);
        }];
    }
    return _footerView;
}

- (UITextField *)textPhone {
    if (!_textPhone) {
        _textPhone = [[UITextField alloc] init];
        _textPhone.tag = 0;
        _textPhone.delegate = self;
        _textPhone.tintColor = ColorWithHex(0xFF6098);
        _textPhone.keyboardType = UIKeyboardTypeNumberPad;
        [_textPhone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textPhone.placeholder = @"请输入手机号";
    }
    return _textPhone;
}

- (UITextField *)textPwd {
    if (!_textPwd) {
        _textPwd = [[UITextField alloc] init];
        _textPwd.tag = 1;
        _textPwd.delegate = self;
        _textPwd.tintColor = ColorWithHex(0xFF6098);
        _textPwd.placeholder = @"请输入密码";
        [_textPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textPwd.secureTextEntry = YES;
    }
    return _textPwd;
}

- (WPHotspotLabel *)proLabel {
    if (!_proLabel) {
        _proLabel = [[WPHotspotLabel alloc] init];
        NSDictionary* style3 = @{@"body":@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                           NSForegroundColorAttributeName:HXRGB(51, 51, 51)},
                                 @"actionA":[WPAttributedStyleAction styledActionWithAction:^{
                                     //文字点击事件
                                     [self showAgreement];
                                 }],
                                 @"actionB":[WPAttributedStyleAction styledActionWithAction:^{
                                     //文字点击事件
                                     [self showAgreement];
                                 }],
                                 @"link": HXRGB(60, 155, 255)};
        
        _proLabel.attributedText = [@"注册表示同意<actionA>《注册协议》</actionA>及<actionB>《隐私权政策》</actionB>" attributedStringWithStyleBook:style3];
        _proLabel.numberOfLines = 0;
    }
    return _proLabel;
}

/**
 *  获取协议
 */
-(void)showAgreement{
    self.proLabel.hidden = YES;
    [self.view endEditing:YES];
    [[HXNetManager shareManager] get:AgreementUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.agreementArr = [HXAgreementModel mj_objectArrayWithKeyValuesArray:[responseNewModel.body objectForKey:@"agreementList"]];
            if (self.agreementArr.count==0) {
                self.proLabel.hidden = NO;
            }
            WPHotspotLabel *proLabel = [[WPHotspotLabel alloc] init];
            NSMutableDictionary * style3 = [[NSMutableDictionary alloc] init];
            [style3 setObject:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:HXRGB(51, 51, 51)} forKey:@"body"];
            [style3 setObject:HXRGB(60, 155, 255) forKey:@"link"];
            NSString * string = @"注册表示同意";
            for (int i = 0; i<self.agreementArr.count; i++) {
                HXAgreementModel * model = [self.agreementArr objectAtIndex:i];
                if (model.dictName.length==0) {
                    continue;
                }
                [style3 setObject:[WPAttributedStyleAction styledActionWithAction:^{
                    NSLog(@"wewe=============%d",i);
                    [self.view endEditing:YES];
                    HXAgreementModel * model = [self.agreementArr objectAtIndex:i];
                    ProViewController *controller = [[ProViewController alloc] init];
                    controller.reuqestUrl = model.dictRelate;
                    controller.titleName  = model.dictName;
                    [self.navigationController pushViewController:controller animated:YES];
                    
                    
                }] forKey:[NSString stringWithFormat:@"%d",i]];
                
                
                if (i+1==self.agreementArr.count&&self.agreementArr.count>1) {
                    string  = [NSString stringWithFormat:@"%@及%@",string,model.dictName.length?[NSString stringWithFormat:@"<%d>《%@》</%d>",i,model.dictName,i]:@""];
                }else {
                    if (i==0) {
                        string  = [NSString stringWithFormat:@"%@%@",string,model.dictName.length?[NSString stringWithFormat:@"<%d>《%@》</%d>",i,model.dictName,i]:@""];
                    }else {
                        
                        string  = [NSString stringWithFormat:@"%@,%@",string,model.dictName.length?[NSString stringWithFormat:@"<%d>《%@》</%d>",i,model.dictName,i]:@""];
                    }
                }
                
            }
            proLabel.attributedText = [string attributedStringWithStyleBook:style3];
            proLabel.numberOfLines = 0;
            [self.view addSubview:proLabel];
            [proLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(-20);
                make.centerX.equalTo(self.view);
                make.size.mas_equalTo(proLabel.intrinsicContentSize);
            }];
        }else {
            self.proLabel.hidden = NO;
        }
    } failure:^(NSError *error) {
        self.proLabel.hidden = NO;
    }];
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.textPhone setBottomBorder:ColorWithHex(0xF1F1F1)];
    [self.textPwd setBottomBorder:ColorWithHex(0xF1F1F1)];
    
    [textField setBottomBorder:ColorWithHex(0xFF6098)];
    
    return YES;
}

#pragma mark - Private

- (void)finishButtonState {
    if (self.textPhone.text.length == 11 && self.textPwd.text.length>=6) {
        self.loginButton.enabled = YES;
        self.loginButton.backgroundColor = ColorWithHex(0xFF6098);
        
    } else {
        self.loginButton.enabled = NO;
        self.loginButton.backgroundColor = ColorWithHex(0xFFB0CC);
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.tag == 0) {
        NSString *phone = [self.textPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (phone.length > 11) {
            self.textPhone.text = [phone substringToIndex:11];
        }
    } else {
        if (![Helper hasOnlyNumAndChar:textField.text] || textField.text.length > 20) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
        }
    }
    
    [self finishButtonState];
}

- (void)loginButtonClick:(UIButton *)button {
    [self.view endEditing:YES];
    self.errorLabel.hidden = YES;
    if (self.textPhone.text.length == 0) {
        //不是标准的手机号码
        [KeyWindow displayMessage:@"手机号码不能为空"];
        return;
    }
    if (![Helper justMobile:self.textPhone.text]) {
        [KeyWindow displayMessage:@"您输入的手机号错误"];
        return;
    }
    if (self.textPwd.text.length == 0) {
        [KeyWindow displayMessage:@"密码不能为空"];
        return;
    }
    if (self.textPwd.text.length < 6) {
        [KeyWindow displayMessage:@"密码必须为6位以上20位以下数字或字母"];
        return;
    }
    
    NSString *pwd = [NSString stringWithFormat:@"%@%@",access_key,self.textPwd.text];
    NSString *encryption_md5     = [MD5Encryption md5by32:pwd];
    NSString *phone = [self.textPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] post:@"user/loginByPassword" parameters:@{@"cellphone":phone.length!=0?phone:@"",@"password":encryption_md5.length!=0?encryption_md5:@"",@"macCode":[[[UIDevice currentDevice] identifierForVendor] UUIDString],@"divice":@"ios",@"version":SHORT_VERSION} sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [[AppManager manager] handleLoginWithPhone:self.textPhone.text pwd:encryption_md5 userInfo:responseNewModel.body];
             [self.navigationController popToRootViewControllerAnimated:YES];
            return ;
        }
        self.errorLabel.hidden = NO;
        self.errorLabel.text = [responseNewModel.body objectForKey:@"message"];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (void)smsTapGestureClick {
    HXSmsLoginViewController *controller = [[HXSmsLoginViewController alloc] init];
    controller.smsType = smsByTypeLoginEnum;
    controller.isGoToSetPwd = NO;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)forgetTapGestureClick {
    HXSmsLoginViewController *controller = [[HXSmsLoginViewController alloc] init];
    controller.isGoToSetPwd = YES;
    controller.smsType = smsByTypeForgetPwdEnum;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tapGestureClick {
    [self.textPhone setBottomBorder:ColorWithHex(0xF1F1F1)];
    [self.textPwd setBottomBorder:ColorWithHex(0xF1F1F1)];
    [self.view endEditing:YES];
}

- (void) getURL:(NSString *)type{
    
    NSDictionary *head = nil;
    NSDictionary *body = @{@"contractType" : type};
    if ([type isEqualToString:@"C3"]) {
        // TODO: 埋点
    }else if ([type isEqualToString:@"C4"]) {
        // TODO: 埋点
    }
    // TODO: 埋点
    [[AFNetManager manager] getHtmlUrlWithHeadParameter:head bodyParameter:body htmlUrl:^(NSString *url) {
        ProViewController *controller = [[ProViewController alloc] init];
        controller.reuqestUrl = url;
        controller.titleName = [type isEqualToString:@"C4"]?@"注册协议":@"隐私协议";
        [self.navigationController pushViewController:controller animated:YES];
        
    }];
    
}

- (void)registerButtonClick {
    HXSmsLoginViewController *controller = [[HXSmsLoginViewController alloc] init];
    controller.smsType = smsByTypeRegisterEnum;
    controller.isGoToSetPwd = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)onBack {
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;            //改变视图控制器出现的方式
    transition.subtype = kCATransitionFromBottom;     //出现的位置
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
