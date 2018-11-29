//
//  HXPayConfirmViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/2.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXPayConfirmViewController.h"
#import "HXOrderSucessViewController.h"
#import "WTReTextField.h"
#import <RZDataBinding/RZDataBinding.h>
#import "GMDCircleLoader.h"
#import "HXIdCardVerificationViewController.h"
#import "SMSAuthenticationView.h"
#import "HXBankListModel.h"
#import "ComButton.h"
#define kPasswordLength  6
#define kLineTag 1000
#define kDotTag 3000
@interface HXPayConfirmViewController ()<UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong) UIView *serviceFeeView;
@property (nonatomic, strong) UILabel *servieFeeLabel;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UIImageView *bankImageView;
@property (nonatomic, strong) UILabel *confirmLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIImageView *payPwdImageView;
@property (nonatomic,strong)ComButton *colseButton;

@property (nonatomic,strong)SMSAuthenticationView * smsAuthenView; //验证码图框

@property (nonatomic, strong) UIButton *payButton;
@property(nonatomic,strong)YLPasswordTextFiled *textFiled;//输入文本框

@property (nonatomic,assign)OrderStatues states;
@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * statesLabel;

@property (nonatomic,strong)ComButton * backBtn;

@property (nonatomic,strong)UILabel * passWordError;//密码错误提示


@end

@implementation HXPayConfirmViewController
-(id)initWithOrderStates:(OrderStatues)orderStates {
    self = [super init];
    if (self) {
        self.states = orderStates;
        self.viewModel = [[HXPayConfirmViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.5];
    
    [self setUpServiceFeeView];
    [self setUpPayButton];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated {
    [_smsAuthenView stopTimer];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)setUpPayButton {
    self.payButton = [[UIButton alloc] init];
    NSString * btnTitle = _states == orderStatuesCommon ? @"确认支付":@"确认";
    if (_states ==orderZFB) {
        btnTitle = @"支付";
    }
    [self.payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.payButton setTitle:btnTitle forState:UIControlStateNormal];
    self.payButton.backgroundColor = ColorWithHex(0x4A90E2);
    self.payButton.layer.cornerRadius = 2;
    [self.serviceFeeView addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.serviceFeeView).offset(15);
        make.bottom.equalTo(self.serviceFeeView).offset(-15);
        make.width.mas_offset(SCREEN_WIDTH-30);
        make.height.mas_equalTo(50);
    }];
}

- (void)setUpServiceFeeView {
    [self.view addSubview:self.serviceFeeView];
    [self.serviceFeeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(395);
    }];
    
}

- (UIView *)serviceFeeView {
    if (!_serviceFeeView) {
        _serviceFeeView = [[UIView alloc] init];
        _serviceFeeView.backgroundColor = [UIColor whiteColor];
        
        self.titleView = [[UIView alloc] init];
        self.titleView.backgroundColor = ColorWithHex(0xF2F4F5);
        [_serviceFeeView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_serviceFeeView);
            make.height.mas_equalTo(50);
        }];
        
        ComButton * backBtn   = [[ComButton alloc] init];
        self.backBtn = backBtn;
        backBtn.hidden = YES;
        [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setTitleColor:ComonBackColor forState:UIControlStateNormal];
        [backBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.titleView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.titleView);
            make.left.equalTo(self.titleView).offset(0);
            make.width.mas_equalTo(50);
        }];
        [backBtn.photoImage setImage:[UIImage imageNamed:@"billBack"]];
        [backBtn.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backBtn).offset(15);
            make.centerY.equalTo(backBtn);
        }];
        
        NSString * confirmTitle = _states == orderStatuesCommon ? @"支付确认":@"支付结果";
        if (_states ==orderZFB) {
            confirmTitle = @"支付确认";
        }
        self.confirmLabel = [[UILabel alloc] init];
        self.confirmLabel.textAlignment = NSTextAlignmentCenter;
        self.confirmLabel.text = confirmTitle;
        self.confirmLabel.textColor = ColorWithHex(0x333333);
        self.confirmLabel.font = [UIFont systemFontOfSize:16];
        [self.titleView addSubview:self.confirmLabel];
        [self.confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.centerX.equalTo(self.titleView);
            make.width.mas_equalTo(300);
        }];
        
        ComButton *colseButton = [[ComButton alloc] init];
        self.colseButton = colseButton;
        [colseButton addTarget:self action:@selector(colseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [colseButton setImage:[UIImage imageNamed:@"payClose"] forState:UIControlStateNormal];
        [self.titleView addSubview:colseButton];
        [colseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.titleView);
            make.right.equalTo(self.titleView).offset(0);
            make.width.mas_equalTo(50);
        }];
        [colseButton.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(colseButton).offset(-15);
            make.centerY.equalTo(colseButton);
        }];
        
        /**
         *  未支付订单
         */
            [self creatCommenView];
            [self creatFinishView];
        
    }
    return _serviceFeeView;
}
#pragma mark -- 创建未支付订单对应界面
-(void)creatCommenView {
    self.containView = [[UIView alloc] init];
    [_serviceFeeView addSubview:self.containView];
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_serviceFeeView);
        make.left.equalTo(_serviceFeeView.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
    
    [self setUpContainView];
    [self creatBankCard];
    
    //        self.payPwdImageView = [[UIImageView alloc] init];
    //        self.payPwdImageView.hidden = YES;
    //        self.payPwdImageView.image = [UIImage imageNamed:@"payPwd"];
    //        [_serviceFeeView addSubview:self.payPwdImageView];
    //        [self.payPwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.left.equalTo(_serviceFeeView).offset(30);
    //            make.right.equalTo(_serviceFeeView).offset(-30);
    //            make.top.equalTo(self.titleView.mas_bottom).offset(40);
    //        }];
    _textFiled = [[YLPasswordTextFiled alloc]initWithFrame:CGRectMake(30, 80, SCREEN_WIDTH-60, 50)];
    _textFiled.backgroundColor = [kUIColorFromRGB(0xfafafa) colorWithAlphaComponent:0.12];
    _textFiled.layer.masksToBounds = YES;
    _textFiled.hidden = YES;
    _textFiled.layer.borderColor = kUIColorFromRGB(0x4990E2).CGColor;
    _textFiled.layer.borderWidth = 1;
    _textFiled.secureTextEntry = YES;
    _textFiled.delegate = self;
    _textFiled.tintColor = [UIColor clearColor];//看不到光标
    _textFiled.textColor = [UIColor clearColor];//看不到输入内容
    _textFiled.font = [UIFont systemFontOfSize:30];
    _textFiled.keyboardType = UIKeyboardTypeNumberPad;
    _textFiled.pattern = [NSString stringWithFormat:@"^\\d{%li}$",(long)kPasswordLength];
    [_textFiled addTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
    [_serviceFeeView addSubview:_textFiled];
    
    UIButton *forgetPwdButton = [[UIButton alloc] init];
    [_serviceFeeView addSubview:forgetPwdButton];
    [forgetPwdButton addTarget:self action:@selector(forgetPwdButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [forgetPwdButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPwdButton setTitleColor:ColorWithHex(0x999999) forState:UIControlStateNormal];
    forgetPwdButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [forgetPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_serviceFeeView).offset(-30);
        make.top.equalTo(_textFiled.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
    }];
    
    UILabel * passWordError = [[UILabel alloc] init];
    self.passWordError = passWordError;
    self.passWordError.hidden = YES;
    self.passWordError.text = @"支付密码错误";
    passWordError.font = [UIFont systemFontOfSize:12];
    passWordError.textColor = ComonBackColor;
    [_serviceFeeView addSubview:passWordError];
    [passWordError mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textFiled.mas_bottom).offset(5);
        make.left.equalTo(_textFiled);
    }];
    
    [forgetPwdButton rz_bindKey:RZDB_KP(UIButton, hidden) toKeyPath:RZDB_KP(UIImageView, hidden) ofObject:self.textFiled];

}
#pragma mark --创建银行卡列表tableView
-(void)creatBankCard {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = kUIColorFromRGB(0xffffff);
    [self.serviceFeeView addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_serviceFeeView);
        make.left.equalTo(_serviceFeeView.mas_right).offset(0);
        make.width.mas_offset(SCREEN_WIDTH);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.bankArr.count+1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(50);
        }];
        UIImageView * bankImage = [[UIImageView alloc] init];
        if ((indexPath.row == self.viewModel.bankArr.count) || self.viewModel.bankArr.count==0) {
            cell.nameLabel.text = @"添加银行卡";
            cell.bankImage.image = [UIImage imageNamed:@"billPlus"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else {
            HXBankListModel * model = [self.viewModel.bankArr objectAtIndex:indexPath.row];
            [bankImage sd_setImageWithURL:[NSURL URLWithString:model.bankIcon] placeholderImage:nil];
            cell.nameLabel.text = [NSString stringWithFormat:@"%@**%@",model.bankName,model.cardNo.length>4?[model.cardNo substringFromIndex:model.cardNo.length-4]:model.cardNo];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.headImage.hidden = YES;
            cell.headImage.image = [UIImage imageNamed:@"billChoes"];
            [cell.headImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-15);
                make.centerY.equalTo(cell.contentView);
                make.height.and.width.mas_equalTo(25);
            }];
        }
        [cell creatLine:15 hidden:NO];
        [cell.contentView addSubview:bankImage];
        [bankImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView).offset(15);
        }];
    }
    if (!((indexPath.row == self.viewModel.bankArr.count) || self.viewModel.bankArr.count==0)) {
    HXBankListModel * model = [self.viewModel.bankArr objectAtIndex:indexPath.row];
    if ([self.viewModel.selectBank isEqual:model]) {
        cell.headImage.hidden = NO;
    }else {
        cell.headImage.hidden = YES;
    }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     if ((indexPath.row == self.viewModel.bankArr.count) || self.viewModel.bankArr.count==0) {
         if ([self.delegate respondsToSelector:@selector(addBank)]) {
             [self dismissViewControllerAnimated:YES completion:^{
                 
                 [self.delegate addBank];
             }];
         }
         return;
     }
    
    self.backBtn.hidden = YES;
    self.confirmLabel.text = @"支付确认";
    HXBankListModel * model = [self.viewModel.bankArr objectAtIndex:indexPath.row];
    self.viewModel.selectBank = model;
    [self.bankImageView sd_setImageWithURL:[NSURL URLWithString:model.bankIcon] placeholderImage:nil];
    self.bankLabel.text = model.bankName;
    if (model.cardNo.length>=4) {
        self.bankLabel.text = [NSString stringWithFormat:@"%@(%@)",model.bankName,[model.cardNo  substringFromIndex:model.cardNo.length-4]];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_serviceFeeView.mas_left).offset(0);
        }];
        [self.payButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_serviceFeeView.mas_left).offset(15);
        }];
        [_tableView mas_updateConstraints   :^(MASConstraintMaker *make) {
            make.left.equalTo(_serviceFeeView.mas_right).offset(0);
        }];
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
         [_tableView reloadData];
    }];
}
#pragma mark --创建完成订单状态界面
-(void)creatFinishView {
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    photoImage.hidden = YES;
    [_serviceFeeView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_serviceFeeView);
        make.top.equalTo(_serviceFeeView.mas_top).offset(100);
    }];
    
    UILabel * statesLabel = [[UILabel alloc] init];
    self.statesLabel = statesLabel;
    self.statesLabel.hidden = YES;
    statesLabel.font = [UIFont systemFontOfSize:16];
    [_serviceFeeView addSubview:statesLabel];
    [statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_serviceFeeView);
        make.top.equalTo(_serviceFeeView.mas_top).offset(200);
    }];
    
//    if (_states == orderStatuesfail) {
//        photoImage.image = [UIImage imageNamed:@"orderfail"];
//        statesLabel.text = @"支付失败";
//        statesLabel.textColor = ComonBackColor;
//    }else if(_states == orderStatuesSuccess) {
//        photoImage.image = [UIImage imageNamed:@"ordersuccessFirst"];
//        statesLabel.text = @"支付成功";
//        statesLabel.textColor = kUIColorFromRGB(0x4A90E2);
//    }else if(_states == orderStatuesOngoing) {
//        photoImage.image = [UIImage imageNamed:@"orderwait"];
//        statesLabel.text = @"银行处理中...";
//        statesLabel.textColor = kUIColorFromRGB(0x4A90E2);
//    }else {
//        
//    }
    
}
- (void)setUpBlack:(int)account {
    UIView *preView = nil;
    [self.payPwdImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i=0; i<account; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blackColor];
        view.layer.cornerRadius = 5;
        [self.payPwdImageView addSubview:view];
        int leftOffset = (self.payPwdImageView.image.size.width/12)-5;
        if (preView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.payPwdImageView);
                make.width.height.mas_equalTo(10);
                make.left.equalTo(preView.mas_right).offset(leftOffset*2);
            }];
        } else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.payPwdImageView);
                make.width.height.mas_equalTo(10);
                make.left.equalTo(self.payPwdImageView).offset(leftOffset);
            }];
        }
        
        preView = view;
    }
}

- (void)setUpContainView {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"还款总额";
    if (self.states == orderZFB) {
        label.text = @"支付总额";
    }
    label.textColor = ColorWithHex(0x666666);
    label.font = [UIFont systemFontOfSize:14];
    [self.containView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containView);
        make.top.equalTo(self.containView).offset(20);
    }];
    
    [self.containView addSubview:self.servieFeeLabel];
    [self.servieFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(15);
        make.left.equalTo(self.containView).offset(15);
        make.width.mas_offset(SCREEN_WIDTH-30);
//        make.left.right.equalTo(self.containView);
        make.height.mas_lessThanOrEqualTo(50);
    
    }];

    
    self.servieFeeLabel.text = [NSString stringWithFormat:@"¥%@",self.viewModel.totalMoney?self.viewModel.totalMoney:@"0.00"];
    if (self.states == orderZFB) {
        self.servieFeeLabel.textColor =kUIColorFromRGB(0xE6BF73);
        [Helper changeTextWithFont:25 title:self.servieFeeLabel.text changeTextArr:@[@"¥"] label:self.servieFeeLabel color:kUIColorFromRGB(0xE6BF73)];
    }
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    [self.containView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView).offset(15);
        make.right.equalTo(self.containView);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.servieFeeLabel.mas_bottom).offset(24);
    }];
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = ColorWithHex(0xE6E6E6);
    [self.containView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView).offset(15);
        make.right.equalTo(self.containView);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(lineView.mas_bottom).offset(50);
    }];
    
    UIButton * cellBtn = [[UIButton alloc] init];
    cellBtn.backgroundColor = [UIColor clearColor];
    if (self.states == orderZFB) {
        cellBtn.enabled = NO;
    }
    [cellBtn addTarget:self action:@selector(selectOtherBank) forControlEvents:UIControlEventTouchUpInside];
    [self.containView addSubview:cellBtn];
    [cellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView.mas_left).offset(0);
        make.bottom.equalTo(bottomLineView.mas_top);
        make.top.equalTo(lineView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.text = @"支付方式";
    rightLabel.userInteractionEnabled = YES;
    rightLabel.textColor = ColorWithHex(0x999999);
    rightLabel.font = [UIFont systemFontOfSize:14];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
//    [tapGesture addTarget:self action:@selector(selectOtherBank:)];
//    
//    [rightLabel addGestureRecognizer:tapGesture];
    
    [cellBtn addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBtn.mas_left).offset(15 );
        make.bottom.equalTo(cellBtn);
        make.top.equalTo(cellBtn);
        make.width.mas_equalTo(75);
    }];
    
    
    
    HXBankListModel * model;
    if (self.viewModel.bankArr.count>0) {
        model = [self.viewModel.bankArr firstObject];
    }
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:@"listarrow"];
    [cellBtn addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cellBtn).offset(-15);
        make.size.mas_equalTo([UIImage imageNamed:@"listarrow"].size);
        make.bottom.equalTo(cellBtn.mas_bottom).offset(-18);
        make.top.equalTo(cellBtn.mas_top).offset(18);
    }];
    
    self.bankLabel = [[UILabel alloc] init];
    self.bankLabel.text = model.bankName;
    if (model.cardNo.length>=4) {
        self.bankLabel.text = [NSString stringWithFormat:@"%@(%@)",model.bankName,[model.cardNo  substringFromIndex:model.cardNo.length-4]];
    }
    self.bankLabel.textColor = ColorWithHex(0x333333);
    self.bankLabel.font = [UIFont systemFontOfSize:14];
    [cellBtn addSubview:self.bankLabel];
    [self.bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightImageView.mas_left).offset(-10);
        make.bottom.equalTo(cellBtn);
        make.top.equalTo(cellBtn);
    }];
    
    self.bankImageView = [[UIImageView alloc] init];
    [self.bankImageView sd_setImageWithURL:[NSURL URLWithString:model.bankIcon] placeholderImage:nil];
    [cellBtn addSubview:self.bankImageView];
    [self.bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bankLabel.mas_left).offset(-10);
        make.top.equalTo(cellBtn).offset(25/2);
        make.width.and.height.mas_equalTo(25);
    }];
    
    if (_states ==orderZFB) {
        [self.bankImageView setImage:[UIImage imageNamed:@"orderzhifubao"]];
        self.bankLabel.text = @"支付宝";
        rightImageView.hidden = YES;
    }

    
}

- (UILabel *)servieFeeLabel {
    if (!_servieFeeLabel) {
        _servieFeeLabel = [[UILabel alloc] init];
        _servieFeeLabel.textAlignment = NSTextAlignmentCenter;
        _servieFeeLabel.font = [UIFont systemFontOfSize:35];
        _servieFeeLabel.textColor = ColorWithHex(0x4C4C4C);
    }
    return _servieFeeLabel;
}

#pragma mark - UITextfieldDelegate
-(void)textFiledEdingChanged
{
    self.passWordError.hidden = YES;
    NSInteger length = _textFiled.text.length;
    NSLog(@"lenght=%li",(long)length);
    if(length==kPasswordLength){
        for(NSInteger i=0;i<kPasswordLength;i++){
            UILabel *dotLabel = (UILabel *)[_textFiled viewWithTag:kDotTag + i];
            if(dotLabel){
                dotLabel.hidden = YES;
            }
        }
        _textFiled.hidden = YES;
        self.payButton.hidden = YES;
        [_textFiled resignFirstResponder];
         [GMDCircleLoader setOnView:_serviceFeeView withTitle:@"Loading..." animated:YES];
        [self.viewModel submitPassWord:_textFiled.text returnBlock:^(ResponseModel *object){
            if ([object.head.responseCode isEqualToString:@"1206"]) {
                [GMDCircleLoader hideFromView:_serviceFeeView animated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                return ;
            }
            if ([self.viewModel.payPasswordLockNum isEqualToString:@"0"]) {
                [self creatMessUI];
                self.confirmLabel.text = @"支付结果";
                self.backBtn.hidden = YES;
                [GMDCircleLoader hideFromView:_serviceFeeView animated:YES];
                self.serviceFeeView.hidden = YES;
                [self sendMessage];
            }else {
                if ([self.viewModel.payPasswordLockNum isEqualToString:@"3"]) {
                    
                    [self stopCircleLoaderEnd];
                }else {
                    
                    [self stopCircleLoader];
                }
                
            }
            
        } failBlock:^{
            [GMDCircleLoader hideFromView:_serviceFeeView animated:YES];
            _textFiled.hidden = NO;
        }];
        
        _textFiled.text = @"";
//        [self performSelector:@selector(stopCircleLoader) withObject:nil afterDelay:4];
    
        return;
        
    }
    for(NSInteger i=0;i<kPasswordLength;i++){
        UILabel *dotLabel = (UILabel *)[_textFiled viewWithTag:kDotTag + i];
        if(dotLabel){
            dotLabel.hidden = length <= i;
        }
    }
    [_textFiled sendActionsForControlEvents:UIControlEventValueChanged];
}
#pragma mark -- 发送短信验证码
-(void)sendMessage {
    NSString *numberString ;
    if (self.viewModel.selectBank.cellphone.length !=0) {
        numberString =  [self.viewModel.selectBank.cellphone stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"******"];
    }
    _smsAuthenView.sendLabel.text =[NSString stringWithFormat:@"短信正在发送至 :%@",numberString];
    [self.viewModel archivePaymentMessageWithReturnBlock:^{
        _smsAuthenView.sendLabel.text =[NSString stringWithFormat:@"短信已发送至 :%@",numberString];
        [_smsAuthenView startTimer];
    } failBlock:^{
        _smsAuthenView.sendLabel.text =[NSString stringWithFormat:@"短信发送失败 请从新发送"];
    }];
    
    
}
#pragma mark - Private
-(void)creatMessUI {
    SMSAuthenticationView * smsAuthenView = [[SMSAuthenticationView alloc] init];
    self.smsAuthenView = smsAuthenView;
    smsAuthenView.backgroundColor =kUIColorFromRGB(0xffffff);
    [self.view addSubview:smsAuthenView];
    [smsAuthenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-250);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(235);
    }];
    __weak typeof(self) weakSelf = self;
    smsAuthenView.clickBtn = ^(NSString * message) {
        self.viewModel.message = message;
        [self.viewModel submitRepayInformationWithReturnBlock:^{
            self.viewModel.message = message;
            self.smsAuthenView.hidden = YES;
            self.serviceFeeView.hidden = NO;
            self.photoImage.hidden = NO;
            self.statesLabel.hidden = NO;
            self.photoImage.image = [UIImage imageNamed:@"ordersuccessFirst"];
            self.statesLabel.text = @"支付成功";
            self.statesLabel.textColor = kUIColorFromRGB(0x4A90E2);
            [self.payButton setTitle:@"确认" forState:UIControlStateNormal];
            self.payButton.hidden = NO;
            self.colseButton.hidden = YES;
            
        } failBlock:^(ResponseModel *object){
            if ([object.head.responseCode isEqualToString:@"BF00105"]) {
                [self.smsAuthenView clearnMessage:@"短信验证码错误"];
                
            }else if ([object.head.responseCode isEqualToString:@"BF00106"]){
                [self.smsAuthenView clearnMessage:@"短信验证码失效"];
                
            }else if ([object.head.responseCode isEqualToString:@"1204"]) {
                self.smsAuthenView.hidden = YES;
                self.serviceFeeView.hidden = NO;
                self.photoImage.hidden = NO;
                self.statesLabel.hidden = NO;
                self.photoImage.image = [UIImage imageNamed:@"orderwait"];
                self.statesLabel.text = @"银行处理中...";
                self.statesLabel.textColor = ComonBackColor;
                self.payButton.hidden = NO;
                [self.payButton setTitle:@"确认" forState:UIControlStateNormal];
                self.colseButton.hidden = YES;
                
            }else {
            self.smsAuthenView.hidden = YES;
            self.serviceFeeView.hidden = NO;
            self.photoImage.hidden = NO;
            self.statesLabel.hidden = NO;
            self.photoImage.image = [UIImage imageNamed:@"orderfail"];
            self.statesLabel.text = @"支付失败";
            self.statesLabel.textColor = ComonBackColor;
           self.payButton.hidden = NO;
            [self.payButton setTitle:@"确认" forState:UIControlStateNormal];
            self.colseButton.hidden = YES;
            }
        }];

        
    };
    smsAuthenView.cancel = ^(){
        [weakSelf.smsAuthenView removeFromSuperview];
        weakSelf.smsAuthenView = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    smsAuthenView.timerClick = ^{
        [self sendMessage];
    };
}
- (void)selectOtherBank {
    self.backBtn.hidden =NO;
    // 选择其他银行卡
    self.confirmLabel.text = @"选择银行卡";
    [UIView animateWithDuration:0.5 animations:^{
       [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(_serviceFeeView.mas_left).offset(-SCREEN_WIDTH);
       }];
        [self.payButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_serviceFeeView.mas_left).offset(-SCREEN_WIDTH);
        }];
        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_serviceFeeView.mas_right).offset(-SCREEN_WIDTH);
        }];
//        [self.confirmLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.titleView).offset(15);
//            make.centerY.equalTo(self.titleView);
//        }];
       [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}
#pragma mark --点击确认按钮
- (void)payButtonClick:(UIButton *)button {
//    [self.viewModel archivePaymentMessageWithReturnBlock:^{
//        [self creatMessUI];
//        self.serviceFeeView.hidden = YES;
//        [_smsAuthenView startTimer];
//    } failBlock:^{
//        
//    }];
    if (self.states == orderZFB) {
        if (self.payConfirmBlcok) {
            [self dismissViewControllerAnimated:YES completion:^{
                self.payConfirmBlcok();
            }];
        }
        return;
    }
    
    
    if ([button.titleLabel.text isEqualToString:@"确认"]) {
        if (self.payConfirmBlcok) {
            [self dismissViewControllerAnimated:YES completion:^{
                self.payConfirmBlcok();
            }];
        }
        return;
    }
    if ([self.viewModel.hasPassWordBool boolValue]) {
        self.backBtn.hidden = NO;
            [self updatePaymentUI];
        }else {
            [[UIAlertTool alloc] showAlertView:self :@"" :@"设置交易密码" :@"取消" :@"去设置" :^{
                [self forgetPwdButtonAction];
            } :^{
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
    }
    
}
-(void)updatePaymentUI {
    [self.smsAuthenView removeFromSuperview];
    self.confirmLabel.text = @"输入支付密码";
    self.serviceFeeView.hidden = NO;
    self.containView.hidden = YES;
    _textFiled.hidden = NO;
    self.payButton.hidden = YES;
    [self.textFiled becomeFirstResponder];
    
}

- (void)colseButtonClick:(UIButton *)button {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 停止加载
- (void)stopCircleLoader {
//    [[UIAlertTool alloc] showAlertView:self :@"" :@"支付密码不正确" :@"重新输入" :@"忘记密码" :^{
//        [self forgetPwdButtonAction];
//     
//    } :^{
//        [GMDCircleLoader hideFromView:_serviceFeeView animated:YES];
//        _textFiled.hidden = NO;
//        [_textFiled becomeFirstResponder];
//    }];
    
    [GMDCircleLoader hideFromView:_serviceFeeView animated:YES];
    self.passWordError.hidden = NO;
    _textFiled.hidden = NO;
    [_textFiled becomeFirstResponder];
    
}
-(void)stopCircleLoaderEnd {
    [[UIAlertTool alloc] showAlertView:self :@"" :@"账户已冻结" :@"取消" :@"去解冻" :^{
        [self forgetPwdButtonAction];
    } :^{
       
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

#pragma mark -- 返回
-(void)backBtnAction {
    self.backBtn.hidden = YES;
    if ([self.confirmLabel.text isEqualToString:@"选择银行卡"]) {
        self.confirmLabel.text = @"支付确认";
        [UIView animateWithDuration:0.5 animations:^{
            [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_serviceFeeView.mas_left).offset(0);
            }];
            [self.payButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_serviceFeeView.mas_left).offset(15);
            }];
            [_tableView mas_updateConstraints   :^(MASConstraintMaker *make) {
                make.left.equalTo(_serviceFeeView.mas_right).offset(0);
            }];
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        return;
    }
    self.confirmLabel.text = @"支付确认";
    self.serviceFeeView.hidden = NO;
    self.containView.hidden = NO;
    _textFiled.hidden = YES;
    self.payButton.hidden = NO;
    [self.textFiled resignFirstResponder];
    _textFiled.text = @"";
    for(NSInteger i=0;i<kPasswordLength;i++){
        UILabel *dotLabel = (UILabel *)[_textFiled viewWithTag:kDotTag + i];
        if(dotLabel){
            dotLabel.hidden = YES;
        }
    }
    
}

#pragma mark -- 忘记密码
-(void)forgetPwdButtonAction {
    if ([self.delegate respondsToSelector:@selector(forgot)]) {
        [self.textFiled resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.delegate forgot];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
@implementation YLPasswordTextFiled
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat perWidth = (frame.size.width - kPasswordLength + 1)*1.0/kPasswordLength;
    for(NSInteger i=0;i<kPasswordLength;i++){
        if(i < kPasswordLength - 1){
            UILabel *vLine = (UILabel *)[self viewWithTag:kLineTag + i];
            if(!vLine){
                vLine = [[UILabel alloc]init];
                vLine.tag = kLineTag + i;
                [self addSubview:vLine];
            }
            vLine.frame = CGRectMake(perWidth + (perWidth + 1)*i, 0, 1, frame.size.height);
            vLine.backgroundColor = kUIColorFromRGB(0xD8D8D8);
        }
        UILabel *dotLabel = (UILabel *)[self viewWithTag:kDotTag + i];
        if(!dotLabel){
            dotLabel = [[UILabel alloc]init];
            dotLabel.tag = kDotTag + i;
            [self addSubview:dotLabel];
        }
        dotLabel.frame = CGRectMake((perWidth + 1)*i + (perWidth - 10)*0.5, (frame.size.height - 10)*0.5, 10, 10);
        dotLabel.layer.masksToBounds = YES;
        dotLabel.layer.cornerRadius = 5;
        dotLabel.backgroundColor = [UIColor blackColor];
        dotLabel.hidden = YES;
    }
}

//禁止复制粘帖
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if(menuController){
        menuController.menuVisible = NO;
    }
    return NO;
}
@end

