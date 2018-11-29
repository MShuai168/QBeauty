//
//  HXSignInViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXSignInViewController.h"
#import "HXSignInModel.h"

#import <RZDataBinding/RZDataBinding.h>

@interface HXSignInViewController ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) HXSignInModel *model;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel * signLabel;

@end

@implementation HXSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.2];
    [self setUpView];
    [self setUpCloseButton];
    [self request];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)setUpView {
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(230);
    }];
}

- (void)setUpCloseButton {
    [self.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bgView.mas_bottom).offset(-10);
        make.width.mas_equalTo(108);
        make.height.mas_equalTo(30);
    }];
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        _closeButton.backgroundColor = [UIColor whiteColor];
        [_closeButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [_closeButton setTitle:@" 点击关闭" forState:UIControlStateNormal];
//        [_closeButton.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
        [_closeButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_closeButton setImage:[UIImage imageNamed:@"signInClose"] forState:UIControlStateNormal];
        _closeButton.layer.cornerRadius = 10;
        
        [_closeButton addTarget:self action:@selector(tapView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"rili"];
        imageView.image = image;
        [_bgView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView).offset(30);
            make.centerX.equalTo(_bgView).offset(-50);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"签到成功";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = ColorWithHex(0x333333);
        [_bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView).offset(28);
            make.left.equalTo(imageView.mas_right).offset(12);
            make.size.mas_equalTo(label.intrinsicContentSize);
        }];
        
        UILabel * signLabel = [[UILabel alloc] init];
        self.signLabel = signLabel;
        signLabel.text = @"已连续签到0天";
        signLabel.textColor = ComonTitleColor;
        signLabel.font = [UIFont systemFontOfSize:13];
        [_bgView addSubview:signLabel];
        [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_bgView);
            make.top.equalTo(label.mas_bottom).offset(20);
        }];
        
        [Helper changeTextWithFont:13 title:signLabel.text changeTextArr:@[@"0"] label:signLabel color:kUIColorFromRGB(0xFA5578)];
        
    }
    return _bgView;
}

- (void)signDayView {
    for (int i = 0; i<7; i++) {
        UIImageView *signImageView = [[UIImageView alloc] init];
        UILabel *signLabel = [[UILabel alloc] init];
        signLabel.text = [NSString stringWithFormat:@"第%d天",i+1];
        signLabel.font = [UIFont systemFontOfSize:11];
        
        UILabel *scoreLable = [[UILabel alloc] init];
        
        if (self.model) {
            HXSignInRuleModel *ruleModel = [HXSignInRuleModel mj_objectWithKeyValues:[self.model.signRule objectAtIndex:i]];
            
            scoreLable.text = [NSString stringWithFormat:@"+%@",[NSString roundDown:[ruleModel.score doubleValue] afterPoint:0]];
        }
        
        scoreLable.font = [UIFont systemFontOfSize:15];
        
        if (i+1 <= [self.model.signInDay intValue]) {
            signImageView.image = [UIImage imageNamed:@"shijianbg1"];
            signLabel.textColor = ColorWithHex(0xffffff);
            scoreLable.textColor = ColorWithHex(0xffffff);
        } else {
            signImageView.image = [UIImage imageNamed:@"shijianbg2"];
            signLabel.textColor = ColorWithHex(0x666666);
            scoreLable.textColor = ColorWithHex(0x666666);
        }
        
        int width = (SCREEN_WIDTH-55)/4;
        if (i < 4) {
            signImageView.frame = CGRectMake(15+(width+5)*i, 107, width, 45);
        } else if(i<6) {
            signImageView.frame = CGRectMake(15+(width+5)*(i-4), 157, width, 45);
        } else {
            signImageView.frame = CGRectMake(15+(width+5)*(i-4), 157, width*2+5, 45);
            
            UIImageView *giftImageView = [[UIImageView alloc] init];
            UIImage *giftImage = [UIImage imageNamed:@"signInGift"];
            giftImageView.image = giftImage;
            [signImageView addSubview:giftImageView];
            [giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(signImageView);
                make.right.equalTo(signImageView).offset(-25);
                make.size.mas_equalTo(giftImage.size);
            }];
        }
        [_bgView addSubview:signImageView];
        
        if (i == 6) {
            [signImageView addSubview:signLabel];
            [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(signImageView).offset(52);
                make.size.mas_equalTo(signLabel.intrinsicContentSize);
                make.bottom.equalTo(signImageView).offset(-7);
            }];
            
            [signImageView addSubview:scoreLable];
            [scoreLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(signLabel);
                make.size.mas_equalTo(scoreLable.intrinsicContentSize);
                make.bottom.equalTo(signLabel.mas_top).offset(-3);
            }];
        } else {
            [signImageView addSubview:signLabel];
            [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(signImageView);
                make.size.mas_equalTo(signLabel.intrinsicContentSize);
                make.bottom.equalTo(signImageView).offset(-7);
            }];
            
            [signImageView addSubview:scoreLable];
            [scoreLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(signImageView);
                make.size.mas_equalTo(scoreLable.intrinsicContentSize);
                make.bottom.equalTo(signLabel.mas_top).offset(-3);
            }];
        }
        
    }
}

- (void)request {
    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] post:SignUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.model = [HXSignInModel mj_objectWithKeyValues:responseNewModel.body];
            self.model.signInDay = self.model.signInDay.length!=0?self.model.signInDay:@"0";
            self.signLabel.text = [NSString stringWithFormat:@"已连续签到%@天",self.model.signInDay];
            [Helper changeTextWithFont:13 title:self.signLabel.text changeTextArr:@[self.model.signInDay] label:self.signLabel color:kUIColorFromRGB(0xFA5578)];
            [self signDayView];
            if (self.block) {
                self.block();
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)tapView:(id)obect {
    [self dismiss];
}

- (void)dismiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)dealloc {
    NSLog(@"HXSignInViewController dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
