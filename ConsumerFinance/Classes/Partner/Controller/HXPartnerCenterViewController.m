//
//  HXPartnerCenterViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerCenterViewController.h"
#import "HXPartnerRecordViewController.h"
#import "HXApplyWithdrawViewController.h"
#import "HXMyTeamViewController.h"
#import "HXPartneInformationViewController.h"
#import "HXChoosePackageViewController.h"


@interface HXPartnerCenterViewController ()<applyWithdrawDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) BOOL canBuy; // 是否可以套餐购买(0:有订单   1:跳转)
@property (nonatomic, assign) BOOL canCashOut; // 是否申请提现(1:有冻结金额   0:无冻结金额)

@end

@implementation HXPartnerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorWithHex(0xF9F9F9);
    
    [self setUpHeaderView];
    [self setUpContentView];
    
    [self setUpNavigation];
}

- (void)setUpNavigation {
    UIView *NavBarView = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.frame];
    [self.view addSubview:NavBarView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"合伙人中心";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = ColorWithHex(0xffffff);
    [NavBarView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(NavBarView);
        make.centerY.equalTo(NavBarView);
        make.size.mas_equalTo(titleLabel.intrinsicContentSize);
    }];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton setTitle:@"记录" forState:UIControlStateNormal];
    [rightButton setTitleColor:ColorWithHex(0xffffff) forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [NavBarView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(NavBarView);
        make.right.equalTo(NavBarView).offset(-10);
        make.width.height.mas_equalTo(50);
    }];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    leftButton.adjustsImageWhenHighlighted = NO;
    [leftButton setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [NavBarView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(NavBarView);
        make.left.equalTo(NavBarView).offset(0);
        make.width.height.mas_equalTo(50);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)request {
//    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] get:@"partnerInfo/queryPartnerInfoByUserUuid" parameters:@{@"userUuid":userUuid} sucess:^(ResponseNewModel *responseNewModel) {
//        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            NSDictionary *dic = [responseNewModel.body objectForKey:@"partnerInfo"];
            if (dic) {
                self.priceLable.text = [NSString stringFormatterWithCurrencyString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"balance"]?[NumAgent roundDown:[dic objectForKey:@"balance"] ifKeep:YES]:@"0.00"]];
                self.canCashOut = [[dic objectForKey:@"frozen"] intValue] == 1; //是否申请提现(1:有冻结金额   0:无冻结金额)
                self.canBuy = [[dic objectForKey:@"orderStatus"] intValue] == 1;  //是否可以套餐购买(0:有订单   1:跳转)
            }
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (void)setUpHeaderView {
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(195);
    }];
    
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"partnerBg"]];
        [_headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_headerView);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithHex:0xffffff alpha:0.7];
        label.text = @"奖金(元)";
        label.font = [UIFont systemFontOfSize:15];
        [_headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headerView);
            make.size.mas_equalTo(label.intrinsicContentSize);
            make.top.equalTo(_headerView).offset(88);
        }];
        
        self.priceLable = [[UILabel alloc] init];
        self.priceLable.textAlignment = NSTextAlignmentCenter;
        self.priceLable.textColor = ColorWithHex(0xffffff);
        self.priceLable.font = [UIFont fontWithName:@"DINAlternate-Bold" size:40];
        self.priceLable.text = [NSString stringFormatterWithCurrency:0];
        [_headerView addSubview:self.priceLable];
        [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headerView);
            make.left.right.equalTo(_headerView);
            make.top.equalTo(label.mas_bottom).offset(16);
            make.bottom.equalTo(_headerView).offset(-35);
        }];
        
    }
    return _headerView;
}

- (void)setUpContentView {
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom).offset(10);
        make.height.mas_equalTo(170);
    }];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = ColorWithHex(0xffffff);
        
        UIView *hLineView = [[UIView alloc] init];
        hLineView.backgroundColor = ColorWithHex(0xE6E6E6);
        [_contentView addSubview:hLineView];
        [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_contentView);
            make.height.mas_equalTo(0.5);
            make.left.right.equalTo(_contentView);
        }];
        
        UIView *vLineView = [[UIView alloc] init];
        vLineView.backgroundColor = ColorWithHex(0xE6E6E6);
        [_contentView addSubview:vLineView];
        [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_contentView);
            make.width.mas_equalTo(0.5);
            make.top.bottom.equalTo(_contentView);
        }];
        
        UIButton *cashOutButton = [[UIButton alloc] init];
        cashOutButton.adjustsImageWhenHighlighted = NO;
        [cashOutButton setImage:[UIImage imageNamed:@"tixian"] forState:UIControlStateNormal];
        [cashOutButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [cashOutButton setTitle:@"申请提现" forState:UIControlStateNormal];
        [cashOutButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [cashOutButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [cashOutButton addTarget:self action:@selector(canCashOutClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:cashOutButton];
        [cashOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_contentView);
            make.bottom.equalTo(hLineView);
            make.right.equalTo(vLineView);
        }];
        
        UIButton *teamButton = [[UIButton alloc] init];
        teamButton.adjustsImageWhenHighlighted = NO;
        [teamButton setImage:[UIImage imageNamed:@"hehuorenCenter"] forState:UIControlStateNormal];
        [teamButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [teamButton setTitle:@"我的团队" forState:UIControlStateNormal];
        [teamButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [teamButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [teamButton addTarget:self action:@selector(teamButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:teamButton];
        [teamButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(_contentView);
            make.bottom.equalTo(hLineView);
            make.left.equalTo(vLineView);
        }];
        
        UIButton *packageButton = [[UIButton alloc] init];
        packageButton.adjustsImageWhenHighlighted = NO;
        [packageButton setImage:[UIImage imageNamed:@"taocan"] forState:UIControlStateNormal];
        [packageButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [packageButton setTitle:@"套餐购买" forState:UIControlStateNormal];
        [packageButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [packageButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [packageButton addTarget:self action:@selector(packageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:packageButton];
        [packageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(_contentView);
            make.top.equalTo(hLineView);
            make.right.equalTo(vLineView);
        }];
        
        UIButton *personButton = [[UIButton alloc] init];
        personButton.adjustsImageWhenHighlighted = NO;
        [personButton setImage:[UIImage imageNamed:@"gerenxinxi"] forState:UIControlStateNormal];
        [personButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [personButton setTitle:@"个人信息" forState:UIControlStateNormal];
        [personButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [personButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [personButton addTarget:self action:@selector(personButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:personButton];
        [personButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(_contentView);
            make.top.equalTo(hLineView);
            make.left.equalTo(vLineView);
        }];
    }
    return _contentView;
}

- (void)leftButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick:(UIButton *)button {
    HXPartnerRecordViewController * record = [[HXPartnerRecordViewController alloc] init];
    [self.navigationController pushViewController:record animated:YES];
}

- (void)canCashOutClick:(UIButton *)button {
    if (self.canCashOut) {
        [KeyWindow displayMessage:@"您有一笔提现正在处理"];
        return;
    }
    HXApplyWithdrawViewController * withdraw = [[HXApplyWithdrawViewController alloc] init];
    withdraw.delegate = self;
    [self.navigationController pushViewController:withdraw animated:YES];
}

- (void)teamButtonClick:(UIButton *)button {
    HXMyTeamViewController * myteam = [[HXMyTeamViewController alloc] init];
    [self.navigationController pushViewController:myteam animated:YES];
}

- (void)packageButtonClick:(UIButton *)button {
    if (!self.canBuy) {
        [KeyWindow displayMessage:@"您有一笔订单正在处理"];
        return;
    }
    HXChoosePackageViewController *controller = [[HXChoosePackageViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)personButtonClick:(UIButton *)button {
    HXPartneInformationViewController * information = [[HXPartneInformationViewController alloc] init];
    [self.navigationController pushViewController:information animated:YES];
}

//-(void)update {
//    [self request];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
