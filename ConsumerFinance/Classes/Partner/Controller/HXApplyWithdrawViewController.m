//
//  HXApplyWithdrawViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXApplyWithdrawViewController.h"
#import "HXPartneInformationViewController.h"
#import "HXPartnerBankViewController.h"
#import "HXApplyWithdrawModel.h"
#import "HXPartnerResultViewController.h"
@interface HXApplyWithdrawViewController ()<UITextFieldDelegate,HXPartnerBankDelegate>
@property (nonatomic,strong) UIButton * referButton;
@property (nonatomic,strong) DZCustomTextField * writeTextfield;

@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * bankNameLabel;
@property (nonatomic,strong)UILabel * banNoLabel;
@property (nonatomic,strong)UILabel * withdrawLabel;
@property (nonatomic,strong)UILabel * overtopLabel;
@property (nonatomic,strong)UILabel * attentionLabel;
@end

@implementation HXApplyWithdrawViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXApplyWithdrawViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self editNavi];
    [self createUI];
    self.view.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tap];
    self.view.userInteractionEnabled = YES;
    [self request];
}
-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:NO];
}
/*
 *
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"申请提现";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
-(void)createUI {
    
    UIButton * addBankBtn = [[UIButton alloc] init];
    [self.view addSubview:addBankBtn];
    [addBankBtn addTarget:self action:@selector(addBankBtnAction) forControlEvents:UIControlEventTouchUpInside];
    addBankBtn.backgroundColor = CommonBackViewColor;
    [addBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(70);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.text = @"添加银行卡";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = ComonTextColor;
    [addBankBtn addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addBankBtn);
        make.left.equalTo(addBankBtn).offset(15);
    }];
    
    UIImageView * arrorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listarrow"]];
    [addBankBtn addSubview:arrorImage];
    [arrorImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addBankBtn);
        make.right.equalTo(addBankBtn).offset(-15);
    }];
    
    UILabel * bankNameLabel = [[UILabel alloc] init];
    self.bankNameLabel = bankNameLabel;
    bankNameLabel.textColor = ComonTextColor;
    bankNameLabel.font = [UIFont systemFontOfSize:16];
    bankNameLabel.hidden = YES;
    [addBankBtn addSubview:bankNameLabel];
    [bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addBankBtn).offset(16);
        make.left.equalTo(addBankBtn).offset(15);
    }];
    
    UILabel * banNoLabel = [[UILabel alloc] init];
    self.banNoLabel = banNoLabel;
    banNoLabel.hidden = YES;
    banNoLabel.textColor = ComonCharColor;
    banNoLabel.font = [UIFont systemFontOfSize:13];
    [addBankBtn addSubview:banNoLabel];
    [banNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addBankBtn).offset(40);
        make.left.equalTo(addBankBtn).offset(15);
    }];
    
    
    UIView * backView  =[[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 257/2)];
    backView.backgroundColor = CommonBackViewColor;
    [self.view addSubview:backView];
    
    UILabel * tsLabel = [[UILabel alloc] init];
    tsLabel.text = @"提现金额";
    tsLabel.font = [UIFont systemFontOfSize:14];
    tsLabel.textColor = ComonTextColor;
    [backView addSubview:tsLabel];
    [tsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(16);
        make.left.equalTo(backView).offset(15);
    }];
    
    UILabel * rmbLabel = [[UILabel alloc] init];
    rmbLabel.font =[UIFont systemFontOfSize:16];
    rmbLabel.text = @"¥";
    rmbLabel.textColor = ComonCharColor;
    [backView addSubview:rmbLabel];
    [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(15);
        make.top.equalTo(backView).offset(60);
    }];
    
    _writeTextfield = [[DZCustomTextField alloc] initWithFrame:CGRectMake(0, 80, 320, 49)];
    _writeTextfield.textColor = ComonTextColor;
    _writeTextfield.keyboardType = UIKeyboardTypeDecimalPad;
    _writeTextfield.delegate = self;
    [_writeTextfield customWithPlaceholder:@"输入提现金额" color:ComonCharColor font:[UIFont boldSystemFontOfSize:20]];
    
    [_writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _writeTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _writeTextfield.font = [UIFont systemFontOfSize:32];
    self.writeTextfield.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    [backView addSubview:_writeTextfield];
    [_writeTextfield  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(40);
        make.left.equalTo(backView).offset(65/2);
        make.width.mas_equalTo(SCREEN_WIDTH-65/2-15);
        make.height.mas_equalTo(50);
    }];
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(hiddenKeyBoard)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [bar setItems:[NSArray arrayWithObjects:item1,item2, nil]];
    _writeTextfield.inputAccessoryView = bar;
    
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(90);
        make.left.equalTo(backView).offset(15);
        make.right.equalTo(backView);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel * withdrawLabel = [[UILabel alloc] init];
    self.withdrawLabel = withdrawLabel;
    withdrawLabel.font = [UIFont systemFontOfSize:13];
    withdrawLabel.text = @"可提现金额：0.00";
    withdrawLabel.textColor = ComonCharColor;
    [backView addSubview:withdrawLabel];
    [withdrawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView).offset(-12);
        make.left.equalTo(backView).offset(15);
    }];
    
    
    UILabel * overtopLabel = [[UILabel alloc] init];
    self.overtopLabel = overtopLabel;
    overtopLabel.hidden = YES;
    overtopLabel.font = [UIFont systemFontOfSize:13];
    overtopLabel.textColor = ComonBackColor;
    overtopLabel.text = @"金额已超出可提现额度";
    [self.view addSubview:overtopLabel];
    [overtopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(16);
        make.left.equalTo(self.view).offset(15);
    }];
    
    UILabel * attentionLabel = [[UILabel alloc] init];
    attentionLabel.numberOfLines = 0;
    self.attentionLabel = attentionLabel;
    attentionLabel.font = [UIFont systemFontOfSize:13];
    attentionLabel.textColor = ComonCharColor;
    [self.view addSubview:attentionLabel];
    [attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(45);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    
    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 306.5, SCREEN_WIDTH-30, 50)];
    self.referButton = referButton;
    referButton.enabled = NO;
    referButton.layer.cornerRadius = 25;
    referButton.layer.masksToBounds = YES;
    [referButton setTitle:@"申请提现" forState:UIControlStateNormal];
    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:referButton style:UIControlStateNormal];
    [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
    [self.view addSubview:referButton];
    
}
-(void)addBankBtnAction {
    [self.view endEditing:YES];
    HXPartnerBankViewController * information = [[HXPartnerBankViewController alloc] init];
    information.delegate = self;
    [self.navigationController pushViewController:information animated:YES];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger allowedLength = 100;
    NSString  *astring      = @"";
    
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    return [Helper justNumerWithTextField:textField shouldChangeCharactersInRange:range replacementString:string numberLength:9];
    
    
    if ([NSString isBlankString:astring]) {
        if ([textField.text length] < allowedLength || [string length] == 0) {
            return YES;
        }else {
            [textField shakeAnimation];
            return NO;
        }
    } else {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:astring] invertedSet];
        //按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL canChange     = [string isEqualToString:filtered];
        
        if ((canChange && [textField.text length] < allowedLength) || [string length] == 0) {
            return YES;
        }else {
            [textField shakeAnimation];
            return NO;
        }
    }
}
-(void)textFieldDidChange:(UITextField *)textField
{
    self.viewModel.applyMoeny = textField.text;
    if ([self.viewModel.applyMoeny floatValue]>[self.viewModel.model.balance floatValue]) {
        self.overtopLabel.hidden = NO;
    }else {
        self.overtopLabel.hidden = YES;
    }
    
    [self changeButtonStates];
}
-(void)changeButtonStates {
    
    if (self.writeTextfield.text.length!=0) {
        self.referButton.enabled = YES;
        [Helper createImageWithColor:ComonBackColor button:self.referButton style:UIControlStateNormal];
    }else {
        self.referButton.enabled = NO;
        [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:self.referButton style:UIControlStateNormal];
    }
}


-(void)registerAction {
    [_writeTextfield resignFirstResponder];
    if (!(self.viewModel.model.bankName.length!=0&&self.viewModel.model.cardNo.length!=0)) {
        [KeyWindow displayMessage:@"请添加银行卡"];
        return;
    }
    if ([self.viewModel.applyMoeny floatValue]>[self.viewModel.model.balance floatValue]) {
        [KeyWindow displayMessage:@"提现金额超限"];
        return;
    }
    if ([self.viewModel.model.minMoney floatValue]>[self.viewModel.applyMoeny floatValue]) {
        [KeyWindow displayMessage:[NSString stringWithFormat:@"最低提现:%@元",self.viewModel.model.minMoney.length!=0?self.viewModel.model.minMoney:@"0"]];
        return;
    }
    [self.viewModel submitApplyWithdrawWithReturnBlock:^{
        if ([self.delegate respondsToSelector:@selector(update)]) {
            [self.delegate update];
        }
        HXPartnerResultViewController * result = [[HXPartnerResultViewController alloc] init];
        result.viewModel.orderStates = PartnerOrderStatesSuccess;
        [self.navigationController pushViewController:result animated:YES];
    } failBlock:^{
        
    }];
    
}
-(void)request {
    
    [self.viewModel archiveApplyBankInformationWithReturnBlock:^{
        if (self.viewModel.model.bankName.length!=0&&self.viewModel.model.cardNo.length!=0) {
            self.titleLabel.hidden = YES;
            self.banNoLabel.hidden = NO;
            self.bankNameLabel.hidden = NO;
            self.banNoLabel.text = self.viewModel.model.cardNo;
            self.bankNameLabel.text = self.viewModel.model.bankName;
        }else {
            self.titleLabel.hidden = NO;
            self.banNoLabel.hidden = YES;
            self.bankNameLabel.hidden = YES;
        }
        NSString * money = self.viewModel.model.balance.length!=0?[NumAgent roundDown:self.viewModel.model.balance ifKeep:YES]:@"0.00";
        self.withdrawLabel.text = [NSString stringWithFormat:@"可提现金额：%@",money];
        NSString * attentionStr = self.viewModel.careful.length!=0?self.viewModel.careful:@"";
        self.attentionLabel.text = attentionStr.length!=0?attentionStr:@"";
    } failBlock:^{
        
    }];
    
}
-(void)update {
    [self request];
}
-(void)hiddenKeyBoard {
    
    [self.writeTextfield resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
