//
//  HXPartnerBankViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerBankViewController.h"
#import "HXPartnerBankModel.h"

@interface HXPartnerBankViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,strong) BaseTableViewCell * bankCell;
@property (nonatomic,strong) BaseTableViewCell * cardCell;
@property (nonatomic,strong) BaseTableViewCell * nameCell;
@property (nonatomic,strong) BaseTableViewCell * subbranchCell;
@property (nonatomic,strong) UIButton * referButton;
@end

@implementation HXPartnerBankViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXPartnerBankViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self hiddeKeyBoard];
    [self createUI];
    self.view.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [self request];
}
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"银行卡";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
-(void) hiddeKeyBoard{
    
    [self.view endEditing:YES];
    
}
-(void)createUI {
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    headView.backgroundColor = kUIColorFromRGB(0xFEFCEC);
    _tableView.tableHeaderView = headView;
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"提现银行卡，请保证信息填写准确";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = kUIColorFromRGB(0xF5AE35);
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.left.equalTo(headView).mas_equalTo(15);
    }];
    
    
    /**
     *  footView
     */
    
    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
    footView.backgroundColor = COLOR_BACKGROUND;
    [_tableView setTableFooterView:footView];
    
    
    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
    self.referButton = referButton;
    referButton.enabled = NO;
    referButton.layer.cornerRadius = 25;
    referButton.layer.masksToBounds = YES;
    [referButton setTitle:@"保存" forState:UIControlStateNormal];
    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:referButton style:UIControlStateNormal];
    [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
    [footView addSubview:referButton];
    
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity1 = @"IdentityInfoCell1";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell creatLine:0 hidden:NO];
        cell.nameLabel.text = @"姓名";
        cell.writeTextfield.delegate = self;
        cell.writeTextfield.textAlignment = NSTextAlignmentLeft;
        cell.writeTextfield.font = [UIFont systemFontOfSize:14];
        cell.writeTextfield.tag = indexPath.row+indexPath.section*10;
        [cell.writeTextfield mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(90);
            make.right.equalTo(cell.contentView).offset(-15);
            make.centerY.equalTo(cell.contentView);
            make.top.and.bottom.equalTo(cell.contentView);
        }];
        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    cell.writeTextfield.keyboardType = UIKeyboardTypeDefault;
    
    if (indexPath.row==0) {
        cell.nameLabel.text = @"开户名";
        self.nameCell = cell;
        cell.writeTextfield.placeholder = @"请输入开户姓名";
        cell.writeTextfield.text = self.viewModel.nameStr.length!=0?self.viewModel.nameStr:@"";
    }else if (indexPath.row==1) {
        cell.nameLabel.text = @"所属银行";
        self.bankCell = cell;
        cell.writeTextfield.placeholder = @"请输入开户行";
        cell.writeTextfield.text = self.viewModel.bankStr.length!=0?self.viewModel.bankStr:@"";
    }else if (indexPath.row==2) {
        cell.nameLabel.text = @"支行";
        cell.writeTextfield.placeholder = @"请输入支行名称";
        self.subbranchCell = cell;
        cell.writeTextfield.text = self.viewModel.subbranchStr.length!=0?self.viewModel.subbranchStr:@"";
    }else {
        cell.nameLabel.text = @"卡号";
        cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
        self.cardCell = cell;
        cell.writeTextfield.placeholder = @"请输入银行卡号";
        cell.writeTextfield.text = self.viewModel.cardStr.length!=0?self.viewModel.cardStr:@"";
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
#pragma mark-textField代理

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //    [textField keyBoardEvent];
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if ([self.nameCell.writeTextfield isEqual:textField]) {
        [Helper textField:textField length:5];
        self.viewModel.nameStr = textField.text;
    }
    if ([textField isEqual:self.bankCell.writeTextfield]){
        [Helper textField:textField length:30];
        self.viewModel.bankStr = textField.text;
    }
    if ([textField isEqual:self.subbranchCell.writeTextfield]){
        [Helper textField:textField length:30];
        self.viewModel.subbranchStr = textField.text;
    }
    if ([textField isEqual:self.cardCell.writeTextfield]){
        if(textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:30];
        }
        self.viewModel.cardStr = textField.text;
    }
    
    
    [self changeButtonStates];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger allowedLength = 100;
    NSString  *astring      = @"";
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    
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
-(void)changeButtonStates {
    
    if (self.viewModel.nameStr.length!=0&&self.viewModel.bankStr.length!=0&&self.viewModel.cardStr.length!=0&&self.viewModel.subbranchStr.length!=0) {
        self.referButton.enabled = YES;
        [Helper createImageWithColor:ComonBackColor button:self.referButton style:UIControlStateNormal];
        
    }else {
        
        self.referButton.enabled = NO;
        [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:self.referButton style:UIControlStateNormal];
    }
}
#pragma mark -- 提交资料
-(void)registerAction {
    [self.view endEditing:YES];
    if (self.viewModel.nameStr.length==0) {
        [KeyWindow displayMessage:@"请填写正确的姓名"];
        return;
    }
    if (self.viewModel.bankStr.length==0) {
        [KeyWindow displayMessage:@"请填写所属银行"];
        return;
    }
    if (self.viewModel.cardStr.length==0) {
        [KeyWindow displayMessage:@"请填写卡号"];
        return;
    }
    [self submit];
}
-(void)request {
    [self.viewModel archiveBankInformationWithReuturnBlock:^{
        [self changeButtonStates];
        [_tableView reloadData];
    } failBlock:^{
        
    }];
    
}
-(void)submit {
    
    [self.viewModel submitBankInformationWithReuturnBlock:^{
        if ([self.delegate respondsToSelector:@selector(update)]) {
            [self.delegate update];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failBlock:^{
        
    }];
    
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
