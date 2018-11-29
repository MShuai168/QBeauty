//
//  HXPartnerViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerViewController.h"
#import "HXChoosePackageViewController.h"

@interface HXPartnerViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *referralView; //推荐码
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL keyboardDidShow;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGRect oldframe;

@end

@implementation HXPartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"千城招募";
    self.view.backgroundColor = ColorWithHex(0xffffff);
    
    [self setUpBgView];
    [self setUpNavigation];
    [self setUpReferralView];
    [self setUpCommitButton];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}

- (void)setUpBgView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    self.bgImageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"partnerHome"];
    self.bgImageView.image = image;
    [self.scrollView addSubview:self.bgImageView];
    
    CGFloat persent= SCREEN_WIDTH/image.size.width;
    CGFloat height = image.size.height *persent;
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(height);
    }];
}

- (void)setUpReferralView {
    [self.scrollView addSubview:self.referralView];
    [self.referralView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
//        make.top.equalTo(self.bgImageView.mas_bottom).offset(20);
        make.top.equalTo(self.bgImageView.mas_bottom).offset(-140);
    }];
}

- (void)setUpCommitButton {
    [self.scrollView addSubview:self.commitButton];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.referralView.mas_bottom).offset(14);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.scrollView).offset(-20);
    }];
}

- (UIView *)referralView {
    if (!_referralView) {
        _referralView = [[UIView alloc] init];
        _referralView.backgroundColor = ColorWithHex(0xffffff);
        _referralView.layer.cornerRadius = 25;
        _referralView.layer.borderWidth = 0.5;
        _referralView.layer.borderColor = ColorWithHex(0xFF6BA9).CGColor;

        self.textField = [[UITextField alloc] init];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.backgroundColor = ColorWithHex(0xffffff);
        if (self.inviterCode.length > 0) {
            self.textField.text = self.inviterCode;
            self.textField.enabled = NO;
            self.textField.textColor = ColorWithHex(0xFF6BA9);
        } else {
            self.textField.placeholder = @"填写邀请码";
            UIColor *color = ColorWithHex(0xFF6BA9);
            self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
        }
        [_referralView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_referralView).offset(15);
            make.right.equalTo(_referralView).offset(-15);
            make.top.bottom.equalTo(_referralView);
        }];
    }
    return _referralView;
}

- (UIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] init];
        _commitButton.backgroundColor = ColorWithHex(0xffffff);
        [_commitButton setTitle:@"成为合伙人" forState:UIControlStateNormal];
        [_commitButton setBackgroundImage:[UIImage imageNamed:@"packageEnableButton"] forState:UIControlStateNormal];
        [_commitButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_commitButton setTitleColor:ColorWithHex(0xffffff) forState:UIControlStateNormal];
        _commitButton.layer.cornerRadius = 25;
        _commitButton.layer.borderWidth = 0.5;
        _commitButton.layer.borderColor = ColorWithHex(0xD9D9D9).CGColor;
        
        [_commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (void)commitButtonClick:(UIButton *)button {
    if (self.textField.text.length > 8) {
        [KeyWindow displayMessage:@"推荐码最多8位"];
        return;
    }
//    NSLog(@"推荐码++++:%@",self.textField.text);
    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] post:@"prePartner/checkInviterCode" parameters:@{@"inviterCode":[self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]} sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            HXChoosePackageViewController *controller = [[HXChoosePackageViewController alloc] init];
            controller.viewModel.inviterCode = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//            NSLog(@"推荐码XXXX:%@",controller.viewModel.inviterCode);
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

#pragma mark - Private Methods

- (void)tapGestureClick:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
    
}

- (void)keyBoardDidShow:(NSNotification *)notif {
    if (self.keyboardDidShow) return;
    
    NSDictionary *userInfo = [notif userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect oldframe = [self.textField convertRect:self.textField.bounds toView:[UIApplication sharedApplication].keyWindow];
    self.oldframe = oldframe;
    self.height = SCREEN_HEIGHT-oldframe.size.height-oldframe.origin.y-keyboardRect.size.height-15;
    if (self.height<0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint scrollPoint = CGPointMake(0.0,_scrollView.contentOffset.y+ -self.height);
            [_scrollView setContentOffset:scrollPoint animated:YES];
        }];
    }
    self.keyboardDidShow = YES;
}

- (void)keyBoardDidHide:(NSNotification *)notif {
    if (self.height<0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint scrollPoint = CGPointMake(0.0,self.oldframe.origin.y+self.oldframe.size.height);
            [_scrollView setContentOffset:scrollPoint animated:YES];
        }];
    }
    self.keyboardDidShow = NO;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y>0) {
        self.height=0.00;
    }
    [self.textField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
