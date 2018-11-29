////
////  HXPayViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/28.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXPayViewController.h"
//#import "HXOrderStatusTagView.h"
//#import "HXPayConfirmViewController.h"
//#import "HXOrderSucessViewController.h"
//
//#import <RZDataBinding/RZDataBinding.h>
//
//@interface HXPayViewController ()
//
//@property (nonatomic, strong) UIView *serviceFeeView;
//@property (nonatomic, strong) UILabel *servieFeeLabel;
//
//@property (nonatomic, strong) UIView *statusView;
//@property (nonatomic, strong) UIImageView *statusImageView;
//@property (nonatomic, strong) UILabel *statusLabel;
//@property (nonatomic, strong) UILabel *telLabel;
//
//@property (nonatomic, strong) UIButton *payButton;
//
//@end
//
//@implementation HXPayViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.title = @"服务费";
//    
//    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
//    
//    self.viewModel = [[HXPayViewControllerViewModel alloc] init];
//    self.viewModel.payStatus = payStatusProcess;
//    
//    [self setUpNavigation];
//    [self setUpTagView];
//    [self setUpServiceFeeView];
//    [self setUpPayButton];
//    [self setUpStatusView];
//    
//    [self bind];
//    
//    // Do any additional setup after loading the view.
//}
//
//- (void)bind {
//    
//    [self.viewModel rz_addTarget:self action:@selector(payStatusChanged) forKeyPathChange:RZDB_KP(HXPayViewControllerViewModel, payStatus) callImmediately:YES];
//}
//
//- (UIView *)statusView {
//    if (!_statusView) {
//        _statusView = [[UIView alloc] init];
//        _statusView.backgroundColor = [UIColor whiteColor];
//        
//        [_statusView addSubview:self.statusImageView];
//        self.statusImageView.image = [UIImage imageNamed:@"payWait"];
//        [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_statusView).offset(15);
//            make.centerY.equalTo(_statusView);
//            make.size.mas_equalTo([UIImage imageNamed:@"payWait"].size);
//        }];
//        
//        [_statusView addSubview:self.statusLabel];
//        self.statusLabel.text = @"银行处理中...";
//        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.statusImageView.mas_right).offset(5);
//            make.top.bottom.equalTo(_statusView);
//            make.width.mas_equalTo(self.view.frame.size.width/2);
//        }];
//        
//        [_statusView addSubview:self.telLabel];
//        [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(_statusView);
//            make.right.equalTo(_statusView).offset(-15);
//            make.size.mas_equalTo(self.telLabel.intrinsicContentSize);
//        }];
//        
//    }
//    return _statusView;
//}
//
//- (UILabel *)statusLabel {
//    if (!_statusLabel) {
//        _statusLabel = [[UILabel alloc] init];
//        _statusLabel.textColor = ColorWithHex(0x4990E2);
//        _statusLabel.font = [UIFont systemFontOfSize:13];
//    }
//    return _statusLabel;
//}
//
//- (UILabel *)telLabel {
//    if (!_telLabel) {
//        _telLabel = [[UILabel alloc] init];
//        _telLabel.text = @"致电客服：400-400-400";
//        _telLabel.textColor = ColorWithHex(0x999999);
//        _telLabel.font = [UIFont systemFontOfSize:11];
//    }
//    return _telLabel;
//}
//
//- (UIImageView *)statusImageView {
//    if (!_statusImageView) {
//        _statusImageView = [[UIImageView alloc] init];
//    }
//    return _statusImageView;
//}
//
//- (UILabel *)servieFeeLabel {
//    if (!_servieFeeLabel) {
//        _servieFeeLabel = [[UILabel alloc] init];
//        _servieFeeLabel.text = @"900";
//        _servieFeeLabel.textAlignment = NSTextAlignmentCenter;
//        _servieFeeLabel.font = [UIFont systemFontOfSize:35];
//        _servieFeeLabel.textColor = ColorWithHex(0xE6BF73);
//    }
//    return _servieFeeLabel;
//}
//
//- (UIView *)serviceFeeView {
//    if (!_serviceFeeView) {
//        _serviceFeeView = [[UIView alloc] init];
//        _serviceFeeView.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *label = [[UILabel alloc] init];
//        label.text = @"服务费";
//        label.textColor = ColorWithHex(0x666666);
//        label.font = [UIFont systemFontOfSize:14];
//        [_serviceFeeView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(_serviceFeeView);
//            make.top.equalTo(_serviceFeeView).offset(15);
//            make.size.mas_equalTo(label.intrinsicContentSize);
//        }];
//        
//        UIView *lineView = [[UIView alloc] init];
//        lineView.backgroundColor = ColorWithHex(0xE6E6E6);
//        [_serviceFeeView addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_serviceFeeView).offset(15);
//            make.right.equalTo(_serviceFeeView);
//            make.height.mas_equalTo(0.5);
//            make.bottom.equalTo(_serviceFeeView).offset(-31);
//        }];
//        
//        UILabel *decLabel = [[UILabel alloc] init];
//        decLabel.textAlignment = NSTextAlignmentCenter;
//        decLabel.text = @"该笔费用会在我们放款之前需要您预先支付";
//        decLabel.textColor = ColorWithHex(0x999999);
//        decLabel.font = [UIFont systemFontOfSize:11];
//        [_serviceFeeView addSubview:decLabel];
//        [decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.left.right.equalTo(_serviceFeeView);
//            make.top.equalTo(lineView.mas_bottom);
//        }];
//    }
//    return _serviceFeeView;
//}
//
//- (void)setUpStatusView {
//    [self.view addSubview:self.statusView];
//    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.serviceFeeView.mas_bottom).offset(10);
//        make.height.mas_equalTo(40);
//    }];
//}
//
//- (void)setUpPayButton {
//    self.payButton = [[UIButton alloc] init];
//    [self.payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.payButton setTitle:@"支付" forState:UIControlStateNormal];
//    self.payButton.backgroundColor = ColorWithHex(0x4A90E2);
//    self.payButton.layer.cornerRadius = 2;
//    [self.view addSubview:self.payButton];
//    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(15);
//        make.right.bottom.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(50);
//    }];
//}
//
//- (void)setUpServiceFeeView {
//    [self.view addSubview:self.serviceFeeView];
//    [self.serviceFeeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view).offset(35);
//        make.height.mas_equalTo(125);
//    }];
//    
//    [self.serviceFeeView addSubview:self.servieFeeLabel];
//    [self.servieFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.serviceFeeView);
//        make.left.right.equalTo(self.serviceFeeView);
//        make.size.mas_equalTo(self.servieFeeLabel.intrinsicContentSize);
//    }];
//    
//    self.servieFeeLabel.text = @"¥900";
//}
//
//- (void)setUpNavigation {
//    [self setNavigationBarBackgroundImage];
//    
//    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setImage:[UIImage imageNamed:@"backButton02"] forState:UIControlStateNormal];
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
//    
//}
//
//- (void)setUpTagView {
//    HXOrderStatusTagView *statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"认证资料",@"签署合同",@"服务费",@"订单成功"] selectedIndex:2 isFirst:NO];
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//}
//
//#pragma mark - Private
//
//- (void)payStatusChanged {
//    self.statusView.hidden = NO;
//    
//    switch (self.viewModel.payStatus) {
//        case payStatusSucess:
//            self.statusImageView.image = [UIImage imageNamed:@"orderSuccess"];
//            self.statusLabel.text = @"支付成功";
//            self.statusLabel.textColor = ColorWithHex(0x4990E2);
//            self.telLabel.hidden = YES;
//            break;
//        case payStatusFail:
//            self.statusImageView.image = [UIImage imageNamed:@"payDefeat"];
//            self.statusLabel.text = @"支付失败";
//            self.statusLabel.textColor = ComonBackColor;
//            self.telLabel.hidden = NO;
//            break;
//        case payStatusProcess:
//            self.statusImageView.image = [UIImage imageNamed:@"payWait"];
//            self.statusLabel.text = @"银行处理中...";
//            self.statusLabel.textColor = ColorWithHex(0x4990E2);
//            self.telLabel.hidden = YES;
//            break;
//        case payStatusNull:
//            self.statusView.hidden = YES;
//            break;
//            
//        default:
//            break;
//    }
//}
//
//- (void)payButtonClick:(UIButton *)button {
//    
//    HXPayConfirmViewController *controller = [[HXPayConfirmViewController alloc] init];
//    
//    controller.payConfirmBlcok = ^(void){
//        HXOrderSucessViewController *controller = [[HXOrderSucessViewController alloc] init];
//        [self.navigationController pushViewController:controller animated:YES];
//    };
//    
//    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [self presentViewController:controller animated:YES completion:nil];
//    
//}
//
//- (void)backButtonClick:(UIButton *)button {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
