////
////  HXServiceChargeViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/11/20.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXServiceChargeViewController.h"
//#import "HXOrderStatusTagView.h"
//#import "HXPayConfirmViewController.h"
//#import "HXAlertViewController.h"
//#import "HXPayView.h"
//
//@interface HXServiceChargeViewController ()
//@property (nonatomic,strong)HXPaymentView * payment;
//@property (nonatomic,strong)UIView * footView;
//@property (nonatomic,strong)UIImageView * iconImageView;
//@property (nonatomic,strong)UILabel * zffailLabel;
//@property (nonatomic,strong)UIButton * referButton;
//@property (nonatomic,strong)HXPayView * payView;
//@property (nonatomic,strong)UILabel * moneyLabel;
//@end
//
//@implementation HXServiceChargeViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXServiceChargeViewModel alloc] initWithController:self];
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
//    if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"98"]) {
//        [self request];
//    }
//}
//-(void)request {
//    
//    [self.viewModel archiveServiceChargeWithReturnBlock:^{
//        [self changeMoney];
//    } failBlock:^{
//        [self changeMoney];
//    }];
//    
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"服务费";
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//    self.view.backgroundColor = COLOR_BACKGROUND;
//    
//}
//-(void) hiddeKeyBoard{
//    [self.view endEditing:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//-(void)createUI {
//    HXOrderStatusTagView *statusTagView;
//    if ([self.viewModel.orderInfo.isYimei boolValue]) {
//        statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"签署合同",@"商户确认",@"服务费",@"订单完成"] selectedIndex:2 isFirst:NO];
//    }else {
//        statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"开户绑卡",@"签署合同",@"服务费",@"订单完成"] selectedIndex:2 isFirst:NO];
//    }
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//    
//    UIView * headView = [[UIView alloc] init];
//    headView.backgroundColor = CommonBackViewColor;
//    [self.view addSubview:headView];
//    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(statusTagView.mas_bottom).offset(0);
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(125);
//    }];
//    
//    UILabel * serviceLabel = [[UILabel alloc] init];
//    serviceLabel.text = @"服务费";
//    serviceLabel.textColor = ComonTitleColor;
//    serviceLabel.font = [UIFont systemFontOfSize:14];
//    [headView addSubview:serviceLabel];
//    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headView).offset(16);
//        make.centerX.equalTo(headView);
//    }];
//    
//    UILabel * moneyLabel = [[UILabel alloc] init];
//    self.moneyLabel = moneyLabel;
//    self.viewModel.orderInfo.serviceCharge = [self.viewModel.orderInfo.serviceCharge floatValue]>0.00?self.viewModel.orderInfo.serviceCharge:@"0.00";
//    NSString * money = self.viewModel.orderInfo.serviceCharge.length!=0?[NumAgent roundDown:self.viewModel.orderInfo.serviceCharge ifKeep:YES]:@"0.00";
//    moneyLabel.textColor = kUIColorFromRGB(0xE6BF73);
//    moneyLabel.font = [UIFont systemFontOfSize:20];
//    [headView addSubview:moneyLabel];
//    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headView).offset(40);
//        make.centerX.equalTo(headView);
//    }];
//    if (![self.viewModel.orderInfo.yfqStatus isEqualToString:@"98"]) {
//        moneyLabel.text = [NSString stringWithFormat:@"¥%@",money];
//        [Helper changeTextWithFont:35 title:moneyLabel.text changeTextArr:@[money] label:moneyLabel color:kUIColorFromRGB(0xE6BF73)];
//    }
//    
//    UIView * lineView = [[UIView alloc] init];
//    lineView.backgroundColor = kUIColorFromRGB(0xE6E6E6);
//    [headView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headView).offset(94);
//        make.left.equalTo(headView).offset(15);
//        make.right.equalTo(headView).offset(-15);
//        make.height.mas_equalTo(0.5);
//    }];
//    
//    UILabel * introduceLabel = [[UILabel alloc] init];
//    introduceLabel.textColor = ComonCharColor;
//    introduceLabel.text = @"该笔费用会在我们放款之前需要您预先支付";
//    introduceLabel.font = [UIFont systemFontOfSize:11];
//    [headView addSubview:introduceLabel];
// 
//    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(headView).offset(-10);
//        make.centerX.equalTo(headView);
//    }];
//    
//    UIView * footView = [[UIView alloc] init];
//    footView.hidden = YES;
//    self.footView = footView;
//    footView.backgroundColor = CommonBackViewColor;
//    [self.view addSubview:footView];
//    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headView.mas_bottom).offset(10);
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(40);
//    }];
//    
//    UIImageView * iconImageView = [[UIImageView alloc] init];
//    self.iconImageView = iconImageView;
//    iconImageView.image = [UIImage imageNamed:@"fwGroup"];
//    [footView addSubview:iconImageView];
//    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(footView);
//        make.left.equalTo(footView).offset(15);
//    }];
//    
//    UILabel * zffailLabel = [[UILabel alloc] init];
//    self.zffailLabel = zffailLabel;
//    zffailLabel.text = @"支付失败";
//    zffailLabel.textColor = ComonBackColor;
//    zffailLabel.font = [UIFont systemFontOfSize:13];
//    [footView addSubview:zffailLabel];
//    [zffailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(footView);
//        make.left.equalTo(footView).offset(33);
//    }];
//    
//    
//    UIButton * referButton = [[UIButton alloc] init];
//    self.referButton = referButton;
//    [referButton setTitle:@"支付" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0x4A90E2) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x4A90E2) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [self.view addSubview:referButton];
//    [referButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(-15);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(50);
//    }];
//    
//    if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"98"]) {
//        self.viewModel.payResultBool = YES;
//        self.iconImageView.image = [UIImage imageNamed:@"sezfsucces"];
//        self.zffailLabel.text = @"支付成功";
//        self.zffailLabel.textColor = kUIColorFromRGB(0x4A90E2);
//        self.footView.hidden = NO;
//        [self.referButton setTitle:@"下一步" forState:UIControlStateNormal];
//    }
//    
//}
//
//-(void)registerAction {
//    if (self.viewModel.payResultBool) {
//        [self.viewModel submitServieceMoneyStatesWithReturnBlock:^{
//            
//        } failBlock:^{
//            
//        }];
//        
//        return;
//    }
//    
//    HXPayConfirmViewController *controller = [[HXPayConfirmViewController alloc] initWithOrderStates:orderZFB];
//    controller.viewModel.totalMoney =self.viewModel.orderInfo.serviceCharge.length!=0?[NumAgent roundDown:self.viewModel.orderInfo.serviceCharge ifKeep:YES]:@"0.00";
//    controller.payConfirmBlcok = ^(void){
//        self.payView = [[HXPayView alloc] init];
//        self.payView.serviceCharge = self.viewModel.orderInfo.serviceCharge;
//        [MBProgressHUD showMessage:nil toView:self.view];
//        [self.payView payWithType:1 orderNum:self.viewModel.orderInfo.id orderServiceBool:YES successBlock:^(NSString * merchantOutOrderNo){
//            [MBProgressHUD hideHUDForView:self.view];
//            self.viewModel.merchantOutOrderNo = merchantOutOrderNo;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideHUDForView:self.view];
//                HXAlertViewController *alertViewController = [HXAlertViewController alertControllerWithTitle:@"" message:@"支付是否完成？" leftTitle:@"否" rightTitle:@"是"];
//                
//                alertViewController.leftAction = ^{
//                    [self archiveStates];
//                };
//                alertViewController.rightAction = ^{
//                    [self archiveStates];
//                };
//                [self presentViewController:alertViewController animated:YES completion:nil];
//            });
//            
//        } failBlock:^(NSString * responseCode,NSString * serviceCharge){
//            [MBProgressHUD hideHUDForView:self.view];
//            if ([responseCode isEqualToString:@"7077"]) {
//                self.viewModel.orderInfo.serviceCharge = serviceCharge;
//                self.viewModel.orderInfo.serviceCharge = [self.viewModel.orderInfo.serviceCharge floatValue]>0.00?self.viewModel.orderInfo.serviceCharge:@"0.00";
//                NSString * money = self.viewModel.orderInfo.serviceCharge.length!=0?[NumAgent roundDown:self.viewModel.orderInfo.serviceCharge ifKeep:YES]:@"0.00";
//                self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",money];
//                [Helper changeTextWithFont:35 title:self.moneyLabel.text changeTextArr:@[money] label:self.moneyLabel color:kUIColorFromRGB(0xE6BF73)];
//                self.iconImageView.image = [UIImage imageNamed:@"sezfsucces"];
//                self.zffailLabel.text = @"支付成功";
//                self.zffailLabel.textColor = kUIColorFromRGB(0x4A90E2);
//                self.footView.hidden = NO;
//                [self.referButton setTitle:@"下一步" forState:UIControlStateNormal];
//                self.viewModel.payResultBool = YES;
//            }else if ([responseCode isEqualToString:@"7078"]) {
//                self.footView.hidden = NO;
//                self.viewModel.orderInfo.serviceCharge = serviceCharge;
//                 self.viewModel.orderInfo.serviceCharge = [self.viewModel.orderInfo.serviceCharge floatValue]>0.00?self.viewModel.orderInfo.serviceCharge:@"0.00";
//                NSString * money = self.viewModel.orderInfo.serviceCharge.length!=0?[NumAgent roundDown:self.viewModel.orderInfo.serviceCharge ifKeep:YES]:@"0.00";
//                self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",money];
//                [Helper changeTextWithFont:35 title:self.moneyLabel.text changeTextArr:@[money] label:self.moneyLabel color:kUIColorFromRGB(0xE6BF73)];
//                [self.referButton setTitle:@"重新支付" forState:UIControlStateNormal];
//            }else {
//                self.footView.hidden = NO;
//                [self.referButton setTitle:@"重新支付" forState:UIControlStateNormal];
//            }
//        }];
//    };
//    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:controller animated:YES completion:nil];
//}
//-(void)archiveStates {
//    [self.viewModel archiveServieceMoneyStatesWithReturnBlock:^{
//        if (self.viewModel.payResultBool) {
//            self.iconImageView.image = [UIImage imageNamed:@"sezfsucces"];
//            self.zffailLabel.text = @"支付成功";
//            self.zffailLabel.textColor = kUIColorFromRGB(0x4A90E2);
//            self.footView.hidden = NO;
//            [self.referButton setTitle:@"下一步" forState:UIControlStateNormal];
//        }else {
//            self.footView.hidden = NO;
//            [self.referButton setTitle:@"重新支付" forState:UIControlStateNormal];
//        }
//        
//    } failBlock:^{
//        self.footView.hidden = NO;
//        [self.referButton setTitle:@"重新支付" forState:UIControlStateNormal];
//    }];
//}
//-(void)changeMoney {
//    self.viewModel.orderInfo.serviceCharge = [self.viewModel.orderInfo.serviceCharge floatValue]>0.00?self.viewModel.orderInfo.serviceCharge:@"0.00";
//    NSString * money = self.viewModel.orderInfo.serviceCharge.length!=0?[NumAgent roundDown:self.viewModel.orderInfo.serviceCharge ifKeep:YES]:@"0.00";
//    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",money];
//    [Helper changeTextWithFont:35 title:self.moneyLabel.text changeTextArr:@[money] label:self.moneyLabel color:kUIColorFromRGB(0xE6BF73)];
//}
//
//- (void)onBack {
//    if ([self.navigationController.viewControllers objectAtIndex:1]) {
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//        return;
//    }
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
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
