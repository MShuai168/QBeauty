////
////  HXBankAuthViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/6/20.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBankAuthViewController.h"
//#import "HXOrderStatusTagView.h"
//
//@interface HXBankAuthViewController ()<UIWebViewDelegate>
//
//@property (nonatomic, strong) UIWebView *webView;
//
//@end
//
//@implementation HXBankAuthViewController
//
//- (instancetype)init {
//    if (self == [super init]) {
//        _viewModel = [[HXBankAuthViewControllerViewModel alloc] init];
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.title = @"开户绑卡";
//    
//    [self setUpNavigation];
//    [self setUpTagView];
//    
//    [self setUpView];
//    [self request];
//}
//
//- (void)request {
//    NSDictionary *head = @{@"tradeCode" : @"0138",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{
//                           @"userId" :[AppManager manager].userInfo.userId,
//                           @"orderId":self.viewModel.orderId
//                           };
//    
//    [MBProgressHUD showMessage:nil toView:nil];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     NSString *html = [object.body objectForKey:@"html"];
//                                                     [self.webView loadHTMLString:html baseURL:nil];
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                 }];
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
//}
//
//- (void)setUpView {
//    [self.view addSubview:self.webView];
//    self.webView.backgroundColor = ColorWithHex(0xF5F7F8);
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.top.equalTo(self.view).offset(35);
//    }];
//}
//
//- (void)setUpTagView {
//    HXOrderStatusTagView *statusTagView;
//    if ([self.viewModel.orderInfo.isYimei boolValue]) {
//        statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"认证资料",@"开户绑卡",@"签署合同",@"商户确认"] selectedIndex:1 isFirst:NO];
//    }else {
//        if ([self.viewModel.orderInfo.distinguish isEqualToString:@"20"]) {
//            statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"认证资料",@"开户绑卡",@"签署合同",@"订单完成"] selectedIndex:1 isFirst:NO];
//        }else {
//        statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"认证资料",@"开户绑卡",@"签署合同",@"服务费"] selectedIndex:1 isFirst:NO];
//        }
//    }
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//    
//}
//
//- (UIWebView *)webView {
//    if (!_webView) {
//        _webView = [[UIWebView alloc] init];
//        _webView.delegate = self;
//    }
//    return _webView;
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
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSString *bodyContent = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerText"];
//    if ([bodyContent rangeOfString:@"恭喜您，开户绑卡成功"].length>0) {
//        NSDictionary *head = @{@"tradeCode" : @"0140",
//                               @"tradeType" : @"appService"};
//        NSDictionary *body = @{
//                               @"orderId":self.viewModel.orderId
//                               };
//        
//        [MBProgressHUD showMessage:nil toView:nil];
//        
//        [[AFNetManager manager] postRequestWithHeadParameter:head
//                                               bodyParameter:body
//                                                     success:^(ResponseModel *object) {
//                                                         [MBProgressHUD hideHUDForView:nil];
//                                                         NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
//                                                         self.viewModel.orderInfo.yfqStatus = yfqStatus;
//                                                         
//                                                         [self.viewModel.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//                                                             [self.navigationController pushViewController:controller animated:YES];
//                                                         } with:self.viewModel.orderType];
//                                                         
//                                                     } fail:^(ErrorModel *error) {
//                                                         [MBProgressHUD hideHUDForView:nil];
//                                                     }];
//    }
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end
