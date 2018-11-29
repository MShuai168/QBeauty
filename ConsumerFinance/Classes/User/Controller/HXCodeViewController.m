//
//  HXCodeViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2018/1/9.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HXCodeViewController.h"
#import "UITextField+Category.h"
#import "HXTextField.h"
#import "VerifyCodeModel.h"
#import "HXSetPwdViewController.h"
#import "HXAlertViewController.h"

@interface HXCodeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *decLabel;
@property (nonatomic, strong) UIView *codeView;
@property (nonatomic, strong) NSMutableArray *arrayField;
@property (nonatomic, strong) UIButton *resetCodeButton;

@end

@implementation HXCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    [self setUpView];
    
    self.decLabel.text = [NSString stringWithFormat:@"验证码已发送至%@",self.tellPhone];
    [self openCountdown];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hiddenNavgationBarLine:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hiddenNavgationBarLine:NO];
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
    
    [self.view addSubview:self.decLabel];
    [self.decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(14);
    }];
    
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(self.decLabel.mas_bottom).offset(16);
        make.height.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.resetCodeButton];
    [self.resetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(self.codeView.mas_bottom).offset(20);
    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setText:@"输入验证码"];
        _titleLabel.font = [UIFont systemFontOfSize:34];
        _titleLabel.textColor = ColorWithHex(0x333333);
    }
    return _titleLabel;
}

- (UILabel *)decLabel {
    if (!_decLabel) {
        _decLabel = [[UILabel alloc] init];
        _decLabel.text = @"验证码已发送至";
        _decLabel.font = [UIFont systemFontOfSize:14];
        _decLabel.textColor = ColorWithHex(0x999999);
    }
    return _decLabel;
}

- (UIView *)codeView {
    if (!_codeView) {
        _codeView = [[UIView alloc] init];
        self.arrayField = [[NSMutableArray alloc] init];
        float width = (SCREEN_WIDTH - 100)/6;
        
        for (int i=0; i<6; i++) {
            HXTextField *field = [[HXTextField alloc] initWithFrame:CGRectMake(i*(width+10), 0, width, 60)];
            if (i == 0) {
                [field becomeFirstResponder];
            }
            [field addTarget:self action:@selector(textfieldChange:) forControlEvents:UIControlEventEditingChanged];
            field.textAlignment = NSTextAlignmentCenter;
            field.tag = i;
            field.delegate = self;
            field.tintColor = ColorWithHex(0xFF6098);
            field.keyboardType = UIKeyboardTypeNumberPad;
            [field setBottomBorder:ColorWithHex(0xF1F1F1)];
            field.deleteKeyReturnBlock = ^(HXTextField *field) {
                if (field.tag-1 >= 0) {
                    [field setBottomBorder:ColorWithHex(0xF1F1F1)];
                    HXTextField *textField = [self.arrayField objectAtIndex:field.tag - 1];
                    textField.text = @"";
                    [textField becomeFirstResponder];
                }
            };
            
            [_codeView addSubview:field];
            [self.arrayField addObject:field];
        }
    }
    return _codeView;
}

- (UIButton *)resetCodeButton {
    if (!_resetCodeButton) {
        _resetCodeButton = [[UIButton alloc] init];
        _resetCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_resetCodeButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        [_resetCodeButton setTitleColor:ColorWithHex(0x333333) forState:UIControlStateNormal];
        [_resetCodeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_resetCodeButton addTarget:self action:@selector(resetCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetCodeButton;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag-1 > 0) {
        HXTextField *field = [self.arrayField objectAtIndex:textField.tag - 1];
        return field.text.length >0;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField setBottomBorder:ColorWithHex(0xFF6098)];
}

- (void)textfieldChange:(UITextField *)textField {
    if (textField.tag+1 < self.arrayField.count) {
        HXTextField *field = [self.arrayField objectAtIndex:textField.tag+1];
        if (field) {
            [field becomeFirstResponder];
        }
        return;
    }
    [self.view endEditing:YES];
    __block NSString *codes = @"";
    [self.arrayField enumerateObjectsUsingBlock:^(HXTextField *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        codes = [codes stringByAppendingString:obj.text];
    }];
    NSLog(@"ddddd:---%@",codes);
    NSDictionary *body = @{@"cellphone":self.tellPhone.length!=0?self.tellPhone:@"",
                           @"code":codes,
                           @"macCode":[[[UIDevice currentDevice] identifierForVendor] UUIDString],
                           @"device":@"ios",
                           @"version":SHORT_VERSION,
                           @"source":self.isGoToSetPwd?@"1":@"0"
                           };
    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] postNoHandleDisplayMessage:@"user/loginByVerificationCode" parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            VerifyCodeModel *model = [VerifyCodeModel mj_objectWithKeyValues:responseNewModel.body];
            if (model) {
                [[AppManager manager] handleLoginWithPhone:self.tellPhone pwd:@"" userInfo:responseNewModel.body];
                if (model.flag) {
                    HXSetPwdViewController *controller = [[HXSetPwdViewController alloc] init];
                    controller.isNeedLoginOut = YES;
                    [self.navigationController pushViewController:controller animated:YES];
                } else {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
        }
        [self handleError];
        [KeyWindow displayMessage:responseNewModel.message duration:2 position:@"center"];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [self handleError];
    }];
}

#pragma mark - Private

- (void)handleError {
    [self.codeView removeFromSuperview];
    self.codeView = nil;
    [self setUpView];
    HXTextField *field = [self.arrayField firstObject];
    [field becomeFirstResponder];
}

-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                self.resetCodeButton.enabled = YES;
                [self.resetCodeButton setTitle:@"重发验证码" forState:UIControlStateNormal];
                [self.resetCodeButton setTitleColor:ColorWithHex(0x333333) forState:UIControlStateNormal];
                self.resetCodeButton.userInteractionEnabled = YES;
            });
            
        } else {
            int seconds = time % 60;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                self.resetCodeButton.enabled = NO;
                [self.resetCodeButton setTitle:[NSString stringWithFormat:@"重发验证码(%.2d)", seconds] forState:UIControlStateNormal];
                [self.resetCodeButton setTitleColor:ColorWithHex(0x333333) forState:UIControlStateNormal];
                self.resetCodeButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)resetCodeButtonClick:(UIButton *)button {
    [self openCountdown];
    
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
    [[HXNetManager shareManager] get:@"user/getVerificationCode" parameters:@{@"cellphone":self.tellPhone.length!=0?self.tellPhone:@"",@"codeType":codeType} sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            
        }
        [KeyWindow displayMessage:responseNewModel.message];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
    
}

- (void)onBack {
    HXAlertViewController *alertController = [HXAlertViewController alertControllerWithTitle:@"" message:@"短信接收可能会延迟，请耐心等待一会吧~" leftTitle:@"返回" rightTitle:@"再等一会"];
    alertController.leftAction = ^{
        NSLog(@"左侧按钮");
        [self.navigationController popViewControllerAnimated:YES];
    };
    alertController.rightAction = ^{
        [self handleError];
        NSLog(@"右侧按钮");
    };
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
