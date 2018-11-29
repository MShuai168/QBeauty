//
//  HXMessageDetailsViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMessageDetailsViewController.h"

@interface HXMessageDetailsViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation HXMessageDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editNavi];
    [self setUpTitled];
    
    [self request];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:NO];
}
-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}

-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"详情";
    
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

- (void)setUpTitled {
    [self.view addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.timeLable];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLable);
        make.top.equalTo(self.titleLable.mas_bottom).offset(15);
        make.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(72);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView).offset(30);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"壹分期系统通知";
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.textColor = ColorWithHex(0x333333);
    }
    return _titleLable;
}

- (UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.font = [UIFont systemFontOfSize:11];
        _timeLable.textColor = ColorWithHex(0x999999);
        _timeLable.text = @"2017年10月1号 壹分期";
    }
    return _timeLable;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    }
    return _lineView;
}

- (void)request {
    NSDictionary *head = @{@"tradeCode" : @"0207",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"noticeId":self.noticeId};
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSDictionary *dic = [object.body objectForKey:@"notice"];
                                                         [self.webView loadHTMLString:[dic objectForKey:@"noticeDetail"] baseURL:nil];
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                 }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
