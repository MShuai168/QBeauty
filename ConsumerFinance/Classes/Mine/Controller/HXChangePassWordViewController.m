//
//  HXChangePassWordViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXChangePassWordViewController.h"
#import "HXChangePassWordViewModel.h"
#define eyeBtnTag 500
@interface HXChangePassWordViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,strong) UIButton * referButton;
@property (nonatomic,strong)HXChangePassWordViewModel * viewModel;
@end

@implementation HXChangePassWordViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXChangePassWordViewModel alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    [self hiddeKeyBoard];
    
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"修改密码";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = HXRGB(255, 255, 255);
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
    
    /**
     *  footView
     */
    
    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
    footView.backgroundColor = COLOR_BACKGROUND;
    [_tableView setTableFooterView:footView];
    
    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
    self.referButton = referButton;
    referButton.enabled = NO;
    [referButton setTitle:@"确认" forState:UIControlStateNormal];
    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [referButton.layer setMasksToBounds:YES];
    [referButton.layer setCornerRadius:4];
    [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:referButton style:UIControlStateNormal];
    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
    [footView addSubview:referButton];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        [cell creatLine:15 hidden:NO];
        cell.writeTextfield.delegate = self;
        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.writeTextfield.textAlignment = NSTextAlignmentLeft;
        [cell.writeTextfield  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView).offset(15);
            make.right.equalTo(cell.contentView).offset(-80);
        }];
        cell.writeTextfield.tag = indexPath.row+100;
        cell.writeTextfield.secureTextEntry = YES;
        
        /**
         *   眼睛
         */
        
        UIButton * eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        eyeButton.tag = eyeBtnTag+indexPath.row;
        [eyeButton setImage:[UIImage imageNamed:@"eyes1"] forState:UIControlStateNormal];
        [eyeButton setImage:[UIImage imageNamed:@"eyes2"] forState:UIControlStateSelected];
        [eyeButton addTarget:self action:@selector(eyeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:eyeButton];
        [eyeButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).offset(-30);
        }];
       
    }
    if (indexPath.row==0) {
        cell.writeTextfield.placeholder = @"请输入原密码";
        cell.writeTextfield.text = self.viewModel.oldPassWord?self.viewModel.oldPassWord:@"";
    }else if (indexPath.row==1){
        cell.writeTextfield.placeholder = @"请输入您的新密码";
        cell.writeTextfield.text = self.viewModel.firstPassWord?self.viewModel.firstPassWord:@"";
    }else {
        cell.writeTextfield.placeholder = @"请再次输入您的新密码";
        cell.writeTextfield.text = self.viewModel.secondPassWord?self.viewModel.secondPassWord:@"";
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark-textField代理
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //    [textField keyBoardEvent];
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField.tag == 100) {
        self.viewModel.oldPassWord = textField.text;
    }
    if (textField.tag == 101) {
        self.viewModel.firstPassWord = textField.text;
    }
    if (textField.tag == 102) {
        self.viewModel.secondPassWord = textField.text;
    }
    
    [self changeButtonStates];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger allowedLength = 100;
    NSString  *astring      = @"";
    
    
    switch (textField.tag) {
        case 100: {
            allowedLength = 16;
            astring       = LIMIT_ALPHANUM;
        }
            break;
        case 101: {
            allowedLength = 16;
            astring       = LIMIT_ALPHANUM;
        }
            break;
        case 102: {
            allowedLength = 16;
            astring       = LIMIT_ALPHANUM;
            
        }
            break;
        default:
            break;
    }
    
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
#pragma mark -- 判断按钮状态
-(void)changeButtonStates {
    if (self.viewModel.oldPassWord.length!=0 && self.viewModel.firstPassWord.length!=0&&self.viewModel.secondPassWord.length!=0) {
        _referButton.enabled = YES;
        [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:_referButton style:UIControlStateNormal];
    }else {
        
        _referButton.enabled = NO;
        [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:_referButton style:UIControlStateNormal];
    }
    
    
}

#pragma mark -- 提交
-(void)registerAction {
    [self.view endEditing:YES];

    if (self.viewModel.oldPassWord.length == 0) {
        [KeyWindow displayMessage:@"原密码不能为空"];
        return;
    }
    if (self.viewModel.oldPassWord.length < 4) {
        [KeyWindow displayMessage:@"密码必须为4位以上16位以下数字或字母"];
        return;
    }
    
    if (self.viewModel.firstPassWord.length == 0) {
        [KeyWindow displayMessage:@"新密码不能为空"];
        return;
    }
    if (self.viewModel.firstPassWord.length < 8) {
        [KeyWindow displayMessage:@"密码必须为8位以上16位以下数字或字母"];
        return;
    }
    if (self.viewModel.secondPassWord.length == 0) {
        [KeyWindow displayMessage:@"确认密码不能为空"];
        return;
    }
    if (![self.viewModel.secondPassWord isEqualToString:self.viewModel.firstPassWord]) {
        [KeyWindow displayMessage:@"您两次输入的密码不一致,请重新输入"];
        return;
    }
   [self.viewModel submitPassWordWithReturnBlock:^{
       [KeyWindow displayMessage:@"修改密码成功"];
       [self.navigationController popToRootViewControllerAnimated:YES];
   }];
    

}
-(void)eyeButtonAction:(id)sender {
    UIButton * button = (UIButton *)sender;
    HDTextField * textField = (HDTextField *)[_tableView viewWithTag:button.tag-eyeBtnTag+100];
    if (!button.selected) {
        
        textField.secureTextEntry = NO;
        
    }else
    {
        textField.secureTextEntry = YES;
    }
    button.selected = !button.selected;
    
    
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
