////
////  HXBankWebViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/12/28.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBankWebViewController.h"
//
//@interface HXBankWebViewController ()<UIWebViewDelegate>
//{
//    NSInteger _second;
//}
//@property (nonatomic,strong)NSTimer * timer;
//@property (nonatomic,strong)UILabel * timeLabel;
//@end
//
//@implementation HXBankWebViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        _second = 3;
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//    [self.view addSubview:webView];
//    webView.delegate = self;
//    [webView loadData:_data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
//    
//    
//    UILabel * timeLabel = [[UILabel alloc] init];
//    self.timeLabel = timeLabel;
//    timeLabel.text = @"3s后返回";
//    timeLabel.hidden = YES;
//    timeLabel.font = [UIFont systemFontOfSize:14];
//    timeLabel.textColor = ComonCharColor;
//    [webView addSubview:timeLabel];
//    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(webView.mas_top).offset(275);
//        make.centerX.equalTo(webView);
//    }];
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"银行卡验证";
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSString *bodyContent = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerText"];
//    if ([bodyContent rangeOfString:@"恭喜您，银行卡更换成功"].length>0) {
//        [HXSingletonView signletonView].bankSuccessBool = YES;
//        self.timeLabel.hidden = NO;
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(delayMethod) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//    }
//}
//-(void)delayMethod {
//    _second--;
//    self.timeLabel.hidden = NO;
//    self.timeLabel.text = [NSString stringWithFormat:@"%lds后返回",_second];
//    if(_second==0||_second<0){
//        [_timer invalidate];
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
//-(void)onBack {
//    [_timer invalidate];
//    [self.navigationController popViewControllerAnimated:YES];
//    if (![HXSingletonView signletonView].bankSuccessBool) {
//        [HXSingletonView signletonView].backView.hidden = NO;
//    }
//    
//}
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
