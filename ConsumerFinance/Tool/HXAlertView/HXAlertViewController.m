//
//  HXAlertViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXAlertViewController.h"

#import <Masonry/Masonry.h>

@interface HXAlertViewController ()

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HXAlertViewController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle {
    HXAlertViewController *alertViewController = [[HXAlertViewController alloc] init];
    
    alertViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [alertViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [alertViewController.leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [alertViewController.rightButton setTitle:rightTitle forState:UIControlStateNormal];
    alertViewController.messageLabel.text = message;
    [alertViewController setUpAlertView];
    
    return alertViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.5];
}

- (void)setUpAlertView {
    [self.view addSubview:self.alertView];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(150);
    }];
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 4;
        
        [_alertView addSubview:self.leftButton];
        [_alertView addSubview:self.rightButton];
        [_alertView addSubview:self.messageLabel];
        
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_alertView).offset(10);
            make.left.equalTo(_alertView).offset(10);
            make.right.equalTo(_alertView).offset(-10);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ColorWithHex(0xE4E4E4);
        [_alertView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_alertView);
            make.top.equalTo(self.messageLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(_alertView).offset(-50);
        }];
        
        UIView *verticalLineView = [[UIView alloc] init];
        verticalLineView.backgroundColor = ColorWithHex(0xE4E4E4);
        [_alertView addSubview:verticalLineView];
        [verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_alertView);
            make.width.mas_equalTo(1);
            make.top.equalTo(lineView.mas_bottom);
            make.bottom.equalTo(_alertView);
        }];
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(_alertView);
            make.right.equalTo(verticalLineView.mas_left);
            make.top.equalTo(lineView.mas_bottom);
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(verticalLineView.mas_right);
            make.right.bottom.equalTo(_alertView);
            make.top.equalTo(lineView.mas_bottom);
        }];
    }
    return _alertView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [_leftButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitleColor:ColorWithHex(0xFB5B5E) forState:UIControlStateNormal];
        [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = ColorWithHex(0x333333);
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = ColorWithHex(0x333333);
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _messageLabel;
}

- (void)leftClick:(UIButton *)button {
    if (self.leftAction) {
        self.leftAction();
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)rightClick:(UIButton *)button {
    if (self.rightAction) {
        self.rightAction();
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"HXAlertViewController dealloc");
}

@end
