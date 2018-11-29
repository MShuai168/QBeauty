////
////  HXSignConractViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/26.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXSignConractViewController.h"
//#import "HXOrderStatusTagView.h"
//#import "HXOrderSucessViewController.h"
//#import "HXOrderSucessViewControllerViewModel.h"
//#import "HXPayViewController.h"
//#import "HXUploadCertificateViewController.h"
//
//#import <RZDataBinding/RZDataBinding.h>
//#import "ProViewController.h"
//#import "HXSelfSizingCollectCell.h"
//#import "HXAgreementModel.h"
//#import "NSString+WPAttributedMarkup.h"
//#import "WPAttributedStyleAction.h"
//#import "WPHotspotLabel.h"
//
//@interface HXSignConractViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>
//{
//    UITextView * _textView;
//}
//
//@property (nonatomic, strong) UIButton *mandateButton;
//@property (nonatomic, strong) UIButton *protocolButton;
//@property (nonatomic, strong) UIButton *signButton;
//@property (nonatomic, strong) UIButton *checkSignButton;
//@property (nonatomic, strong) UIView *contentView;
//@property (nonatomic, strong) UIScrollView *protocolView;
//@property (nonatomic, strong) UIView *timerView;
//@property (nonatomic, strong) UIWebView *webView;
//@property (nonatomic, strong) UIButton * middleButton;
//@property (nonatomic, strong) UILabel *label;
//@property (nonatomic, strong) UICollectionView *collectionView;
//
//@end
//
//@implementation HXSignConractViewController
//
//- (instancetype)init {
//    if (self == [super init]) {
//        _viewModel = [[HXSignConractViewControllerViewModel alloc] init];
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.title = @"签署合同";
//    
//    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
//    
//    [self setUpNavigation];
//    [self setUpTagView];
//    [self setUpSignButton];
//    [self setUpContentView];
//    [self setUpTimerView];
//    [self setUpProtocolView];
//    
//    [self bind];
//    
//    [self.viewModel getConract];
//    
//}
//
//- (void)bind {
//    [self.viewModel rz_addTarget:self action:@selector(urlChanged) forKeyPathChange:RZDB_KP(HXSignConractViewControllerViewModel, mandateUrl)];
//    [self.viewModel rz_addTarget:self action:@selector(isGreenChanelChanged) forKeyPathChange:RZDB_KP(HXSignConractViewControllerViewModel, isGreenChanel)];
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
//- (UIView *)timerView {
//    if (!_timerView) {
//        _timerView = [[UIView alloc] init];
//        _timerView.backgroundColor = ColorWithHex(0xFEFCEC);
//        
//        UIImageView *icon = [[UIImageView alloc] init];
//        [icon setImage:[UIImage imageNamed:@"waitContract"]];
//        [_timerView addSubview:icon];
//        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_timerView).offset(15);
//            make.top.equalTo(_timerView).offset(15);
//            make.size.mas_equalTo([UIImage imageNamed:@"waitContract"].size);
//        }];
//        
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
//        titleLabel.textColor = ColorWithHex(0xF6A623);
//        titleLabel.text = @"合同签署时间48个小时";
//        [_timerView addSubview:titleLabel];
//        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(icon.mas_right).offset(15);
//            make.top.equalTo(_timerView).offset(13);
//            make.right.equalTo(_timerView);
//        }];
//        
//        UIView *lineView = [[UIView alloc] init];
//        lineView.backgroundColor = ColorWithHex(0xFCEBC4);
//        [_timerView addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_timerView).offset(15);
//            make.right.equalTo(_timerView).offset(-15);
//            make.top.equalTo(_timerView).offset(45);
//            make.height.mas_equalTo(0.5);
//        }];
//        
//        UILabel *contentLabel = [[UILabel alloc] init];
//        contentLabel.font = [UIFont systemFontOfSize:12];
//        contentLabel.textColor = ColorWithHex(0xB3976B);
//        contentLabel.text = @"签署协议前，请先与商家沟通完成，签署后订单不可取消。";
//        [_timerView addSubview:contentLabel];
//        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_timerView).offset(15);
//            make.top.equalTo(lineView.mas_bottom).offset(6);
//            make.right.equalTo(_timerView).offset(-15);
//        }];
//    }
//    return _timerView;
//}
//
//- (void)setUpTimerView {
//    // TODO: 48小时临时去掉
//    self.timerView.hidden = YES;
//    [self.view addSubview:self.timerView];
//    [self.timerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(0);
//        make.top.equalTo(self.contentView.mas_bottom);
//    }];
//    
//}
//
//- (void)setUpProtocolView {
//    self.protocolView = [[UIScrollView alloc] init];
//    [self.view addSubview:self.protocolView];
//    [self.protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.signButton.mas_top);
//        make.top.equalTo(self.timerView.mas_bottom);
//        make.height.mas_equalTo(80);
//    }];
//
//    self.checkSignButton = [[UIButton alloc] init];
//    self.checkSignButton.hidden = YES;
//    [self.checkSignButton addTarget:self action:@selector(checkSignButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.checkSignButton setImage:[UIImage imageNamed:@"OrderUnchecked"] forState:UIControlStateNormal];
//    [self.checkSignButton setImage:[UIImage imageNamed:@"OrderChecked"] forState:UIControlStateSelected];
//    [self.checkSignButton setImageEdgeInsets:UIEdgeInsetsMake(-24, 5, 0, 0)];
//    [self.protocolView addSubview:self.checkSignButton];
//    [self.checkSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.protocolView).offset(5);
//        make.top.equalTo(self.protocolView).offset(20);
//        make.width.height.mas_equalTo(40);
//    }];
//    
////    UITextView * textView = [[UITextView alloc] init];
////    _textView = textView;
////    _textView.selectable=YES;
////    textView.backgroundColor = ColorWithHex(0xF5F7F8);
////    [self.protocolView addSubview:textView];
////    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(self.protocolView).offset(35);
////        make.right.equalTo(self.view).offset(-15);
////        make.top.equalTo(self.protocolView).offset(13);
////        make.height.mas_equalTo(60);
////    }];
//}
//- (void)setUpContentView {
//    self.contentView = [[UIView alloc] init];
//    self.contentView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.contentView];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.mas_equalTo(35);
//        make.bottom.equalTo(self.signButton.mas_top).offset(-80);
//    }];
//    
//    self.webView = [[UIWebView alloc] init];
//    self.webView.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:self.webView];
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView).offset(0);
//    }];
//}
//
//- (void)setUpSignButton {
//    self.signButton = [[UIButton alloc] init];
//    [self.signButton addTarget:self action:@selector(signButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.signButton setTitle:@"签章" forState:UIControlStateNormal];
//    self.signButton.enabled = NO;
//    self.signButton.backgroundColor = kUIColorFromRGB(0xCCCCCC);
//    self.signButton.layer.cornerRadius = 2;
//    [self.view addSubview:self.signButton];
//    if (iphone_X) {
//        [self.signButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view).offset(15);
//            make.right.equalTo(self.view).offset(-15);
//            make.bottom.equalTo(self.view).offset(-30);
//            make.height.mas_equalTo(50);
//        }];
//    } else {
//        [self.signButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view).offset(15);
//            make.right.bottom.equalTo(self.view).offset(-15);
//            make.height.mas_equalTo(50);
//        }];
//    }
//}
//
//- (void)setUpTagView {
//    HXOrderStatusTagView *statusTagView;
//    if ([self.viewModel.orderInfo.isYimei boolValue]) {
//        statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"开户绑卡",@"签署合同",@"商户确认",@"服务费"] selectedIndex:1 isFirst:NO];
//    }else {
//        if ([self.viewModel.orderInfo.distinguish isEqualToString:@"20"]) {
//            statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"认证资料",@"开户绑卡",@"签署合同",@"订单完成"] selectedIndex:2 isFirst:NO];
//        }else {
//        statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"开户绑卡",@"签署合同",@"服务费",@"订单成功"] selectedIndex:1 isFirst:NO];
//        }
//    }
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//}
//
//
//#pragma mark - Private
//
//- (void)checkSignButtonClick:(UIButton *)button {
//    self.checkSignButton.selected = !self.checkSignButton.isSelected;
//    if (self.checkSignButton.selected) {
//        self.signButton.enabled = YES;
//        self.signButton.backgroundColor = ColorWithHex(0x4A90E2);
//    }else {
//        self.signButton.enabled = NO;
//        self.signButton.backgroundColor =  kUIColorFromRGB(0xCCCCCC);
//    }
//}
//
//- (void)isGreenChanelChanged {
//    self.protocolView.hidden = self.viewModel.isGreenChanel;
//    if (self.viewModel.isGreenChanel) {
//        self.signButton.enabled = YES;
//        self.signButton.backgroundColor = ColorWithHex(0x4A90E2);
//        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.view);
//            make.top.mas_equalTo(35);
//            make.bottom.equalTo(self.signButton.mas_top).offset(-15);
//        }];
//    } else {
//        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.view);
//            make.top.mas_equalTo(35);
//            make.bottom.equalTo(self.signButton.mas_top).offset(-80);
//        }];
//    }
//}
//
//- (void)urlChanged {
//    [self changeAgreement];
//    [self loadWebView:self.viewModel.mandateUrl];
//}
//-(void)changeAgreement {
//    self.checkSignButton.hidden = NO;
//    WPHotspotLabel *proLabel = [[WPHotspotLabel alloc] init];
//    NSMutableDictionary * style3 = [[NSMutableDictionary alloc] init];
//    [style3 setObject:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:HXRGB(51, 51, 51)} forKey:@"body"];
//    [style3 setObject:HXRGB(60, 155, 255) forKey:@"link"];
//    NSString * string = @"本人同意签署";
//    for (int i = 0; i<self.viewModel.agreementArr.count; i++) {
//        HXAgreementModel * model = [self.viewModel.agreementArr objectAtIndex:i];
//        if (model.dictName.length==0) {
//            continue;
//        }
//        [style3 setObject:[WPAttributedStyleAction styledActionWithAction:^{
//            NSLog(@"wewe=============%d",i);
//            [self.view endEditing:YES];
//            HXAgreementModel * model = [self.viewModel.agreementArr objectAtIndex:i];
//            ProViewController *controller = [[ProViewController alloc] init];
//            controller.reuqestUrl = model.dictRelate;
//            controller.titleName  = model.dictName;
//            [self.navigationController pushViewController:controller animated:YES];
//            
//            
//        }] forKey:[NSString stringWithFormat:@"%d",i]];
//        
//        
//        if (i+1==self.viewModel.agreementArr.count&&self.viewModel.agreementArr.count>1) {
//            string  = [NSString stringWithFormat:@"%@和%@",string,model.dictName.length?[NSString stringWithFormat:@"<%d>《%@》</%d>",i,model.dictName,i]:@""];
//        }else {
//            if (i==0) {
//                string  = [NSString stringWithFormat:@"%@%@",string,model.dictName.length?[NSString stringWithFormat:@"<%d>《%@》</%d>",i,model.dictName,i]:@""];
//            }else {
//                
//                string  = [NSString stringWithFormat:@"%@,%@",string,model.dictName.length?[NSString stringWithFormat:@"<%d>《%@》</%d>",i,model.dictName,i]:@""];
//            }
//        }
//        
//    }
//    proLabel.attributedText = [string attributedStringWithStyleBook:style3];
//    proLabel.numberOfLines = 0;
//    [self.protocolView addSubview:proLabel];
//    [proLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.protocolView).offset(40);
//        make.right.equalTo(self.view).offset(-15);
//        make.top.equalTo(self.protocolView).offset(20);
//        make.height.mas_lessThanOrEqualTo(60);
//    }];
//}
//
//- (void)signButtonClick:(UIButton *)button {
//    if (!self.viewModel.isGreenChanel && !self.checkSignButton.isSelected) {
//        [KeyWindow displayMessage:@"请勾选“已阅读并同意借款协议等”"];
//        return;
//    }
//    
//    NSDictionary *head = @{@"tradeCode" : @"0401",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{@"orderId" : self.viewModel.orderInfo.id
//                           };
//    
//    [MBProgressHUD showMessage:nil toView:nil];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
//                                                         self.viewModel.orderInfo.yfqStatus = yfqStatus;
//                                                         [self.viewModel.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//                                                             if([self.viewModel.orderInfo.yfqStatus isEqualToString:@"99"]){
//                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:Notification_CreditScore object:nil userInfo:nil];
//                                                             }
//                                                             [self.navigationController pushViewController:controller animated:YES];
//                                                         } with:self.viewModel.orderType];
//                                                         
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                 }];
//    
//}
//
//
//-(void)leftButtonAction {
//    NSDictionary *head = nil;
//    NSDictionary *body = @{@"contractType" : @"C3"};
//    [MobClick event:Event_get_verification_code];
//    [[AFNetManager manager] getXyReduceHtmlUrlWithHeadParameter:head bodyParameter:body htmlUrl:^(NSString *url) {
//        ProViewController *controller = [[ProViewController alloc] init];
//        controller.reuqestUrl = url;
//        [self.navigationController pushViewController:controller animated:YES];
//        
//    }];
//
//    
//    
//}
//-(void)middleButtonAction {
//    
//    NSDictionary *head = nil;
//    NSDictionary *body = @{@"contractType" : @"C2"};
//    [MobClick event:Event_get_verification_code];
//    [[AFNetManager manager] getXyReduceHtmlUrlWithHeadParameter:head bodyParameter:body htmlUrl:^(NSString *url) {
//        ProViewController *controller = [[ProViewController alloc] init];
//        controller.reuqestUrl = url;
//        [self.navigationController pushViewController:controller animated:YES];
//        
//    }];
//}
//-(void)rightButtonAction {
//    
//    NSDictionary *head = nil;
//    NSDictionary *body = @{@"contractType" : @"C1"};
//    [MobClick event:Event_get_verification_code];
//    [[AFNetManager manager] getXyReduceHtmlUrlWithHeadParameter:head bodyParameter:body htmlUrl:^(NSString *url) {
//        ProViewController *controller = [[ProViewController alloc] init];
//        controller.reuqestUrl = url;
//        [self.navigationController pushViewController:controller animated:YES];
//        
//    }];
//    
//    
//}
//- (void)loadWebView:(NSString *)urlString {
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
//}
//
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
//    
//    [self.view endEditing:YES];
//    HXAgreementModel * model = [self.viewModel.agreementArr objectAtIndex:[[URL scheme] intValue]];
//    ProViewController *controller = [[ProViewController alloc] init];
//    controller.reuqestUrl = model.dictRelate;
//    controller.titleName  = model.dictName;
//    [self.navigationController pushViewController:controller animated:YES];
//    
//    return NO;
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
//@end
