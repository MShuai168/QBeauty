////
////  HXBeautyConfirmViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/8/21.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBeautyConfirmViewController.h"
//#import "HXOrderStatusTagView.h"
//
//@interface HXBeautyConfirmViewController ()
//
//@property (nonatomic, strong) UIView *bgView;
//@property (nonatomic, strong) UIButton *nextButton;
//
//@end
//
//@implementation HXBeautyConfirmViewController
//
//- (instancetype)init {
//    if (self == [super init]) {
//        _viewModel = [[HXBeautyConfirmViewModel alloc] initWithController:self];
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.title = @"商户确认";
//    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
//    
//    [self setUpNavigation];
//    [self setUpTagView];
//    [self setUpBgView];
//    [self setUpNextButton];
//}
//
//- (void)setUpNavigation {
//    [self setNavigationBarBackgroundImage];
//    
//    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
//    
//}
//
//- (void)setUpTagView {
//    HXOrderStatusTagView *statusTagView;
//    if ([self.viewModel.orderInfo.isYimei boolValue]) {
//        statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"开户绑卡",@"签署合同",@"商户确认",@"服务费"] selectedIndex:2 isFirst:YES];
//    }else {
//        statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"开户绑卡",@"签署合同",@"商户确认",@"服务费"] selectedIndex:2 isFirst:YES];
//    }
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//}
//
//- (void)setUpBgView {
//    [self.view addSubview:self.bgView];
//    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view).offset(35);
//    }];
//}
//
//- (void)setUpNextButton {
//    self.nextButton.hidden = YES;
//    [self.view addSubview:self.nextButton];
//    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(15);
//        make.bottom.right.equalTo(self.view).offset(-15);
//        make.height.mas_offset(50);
//    }];
//    
//    if (self.viewModel.beautyStatus == BeautyStatusSuccess) {
//        self.nextButton.hidden = NO;
//    }
//}
//
//- (UIView *)bgView {
//    if (!_bgView) {
//        _bgView = [[UIView alloc] init];
//        _bgView.backgroundColor = [UIColor whiteColor];
//        
//        UIImageView *imageView =[[UIImageView alloc] init];
//        UILabel *label = [[UILabel alloc] init];
//        label.font = [UIFont systemFontOfSize:18];
//        label.textColor = ColorWithHex(0x999999);
//        if (self.viewModel.beautyStatus == BeautyStatusSuccess) {
//            imageView.image = [UIImage imageNamed:@"ShopSucceess"];
//            label.text = @"商户已确认";
//        } else {
//            imageView.image = [UIImage imageNamed:@"ShopWait"];
//            label.text = @"等待商户确认中";
//        }
//        
//        [_bgView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_bgView).offset(50);
//            make.centerX.equalTo(_bgView);
//            make.size.mas_offset(imageView.image.size);
//        }];
//        
//        [_bgView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(imageView.mas_bottom).offset(32);
//            make.centerX.equalTo(_bgView);
//            make.size.mas_offset(label.intrinsicContentSize);
//            make.bottom.equalTo(_bgView).offset(-26);
//        }];
//        
//    }
//    return _bgView;
//}
//
//- (UIButton *)nextButton {
//    if (!_nextButton) {
//        _nextButton = [[UIButton alloc] init];
//        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
//        [_nextButton setBackgroundColor:ColorWithHex(0x4A90E2)];
//        [_nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _nextButton;
//}
//
//- (void)nextButtonClick:(UIButton *)button {
//    [self.viewModel archivewOrderConfirmStates];
//}
//
//- (void)backButtonClick:(UIButton *)button {
//    if ([self.navigationController.viewControllers objectAtIndex:1]) {
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//        return;
//    }
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
