////
////  HXAutoBankListViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/6/21.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXAutoBankListViewController.h"
//
//@interface HXAutoBankListViewController ()
//
//@property (nonatomic, strong) UIWebView *webView;
//
//@end
//
//@implementation HXAutoBankListViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // 批扣卡银行卡列表
//    self.title = @"银行卡";
//    
//    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
//    
//    [self setUpNavigation];
//    
//    [self setUpView];
//    [self request];
//}
//
//- (void)request {
//    NSDictionary *head = @{@"tradeCode" : @"0212",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{
//                           @"userId" :[AppManager manager].userInfo.userId
//                           };
//    
//    [MBProgressHUD showMessage:nil toView:self.view];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:self.view];
//                                                     NSString *html = [object.body objectForKey:@"html"];
//                                                     [self.webView loadHTMLString:html baseURL:nil];
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:self.view];
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
//- (UIWebView *)webView {
//    if (!_webView) {
//        _webView = [[UIWebView alloc] init];
//    }
//    return _webView;
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
