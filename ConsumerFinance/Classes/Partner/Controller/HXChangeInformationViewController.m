//
//  HXChangeInformationViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXChangeInformationViewController.h"
#import "JCKeyBoardNum.h"
#import "UITextField+JCTextField.h" // 自定义数字键盘
#import "HXChangeInformationModel.h"
@interface HXChangeInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,strong) UIButton * referButton;
@property (nonatomic,strong) BaseTableViewCell * nameCell;
@property (nonatomic,strong) BaseTableViewCell * identyCell;
@property (nonatomic,strong) BaseTableViewCell * iphoneCell;
@property (nonatomic, strong) JCKeyBoardNum *NumKeyBoard;
@end

@implementation HXChangeInformationViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXChangeInformationViewModel alloc] initWithController:self];
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
    self.title = @"修改个人信息";
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

-(void)request {
    [self.viewModel archiveInformationWithReturnBlock:^{
        [self changeButtonStates];
        [_tableView reloadData];
    } failBlock:^{
        
    }];
    
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
        cell.nameLabel.text = @"姓名";
        cell.writeTextfield.placeholder = @"请输入姓名";
        cell.writeTextfield.text = self.viewModel.nameStr.length!=0?self.viewModel.nameStr:@"";
        self.nameCell = cell;
    }else if (indexPath.row==1){
        cell.nameLabel.text = @"身份证";
        cell.writeTextfield.placeholder = @"请输入身份证";
        cell.writeTextfield.text = self.viewModel.identyStr.length!=0?self.viewModel.identyStr:@"";
        self.identyCell = cell;
    }else {
        cell.nameLabel.text = @"电话";
        cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
        cell.writeTextfield.placeholder = @"请输入电话";
        cell.writeTextfield.text = self.viewModel.iphoneStr.length!=0?self.viewModel.iphoneStr:@"";
        self.iphoneCell = cell;
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
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.identyCell.writeTextfield) {
        self.NumKeyBoard = [JCKeyBoardNum show];
        textField.inputView = self.NumKeyBoard;
        __weak typeof(self) weakSelf = self;
        //点击键盘
        self.NumKeyBoard.completeBlock = ^(NSString *text,NSInteger tag) {
            switch (tag) {
                case 9:
                    if (weakSelf.viewModel.identyStr.length!=0 &&![weakSelf.viewModel.identyStr containsString:@"X"]&&weakSelf.viewModel.identyStr.length==17 ) {
                        
                        [weakSelf.identyCell.writeTextfield changTextWithNSString:@"X"];
                        weakSelf.viewModel.identyStr = weakSelf.identyCell.writeTextfield.text;
                    }
                    
                    break;
                case 11:
                    //点击删除按钮
                    [weakSelf clickDeleteBtn];
                    weakSelf.viewModel.identyStr = weakSelf.identyCell.writeTextfield.text;
                    break;
                default:
                    //点击数字键盘
                    [weakSelf.identyCell.writeTextfield changTextWithNSString:text];
                    weakSelf.viewModel.identyStr = weakSelf.identyCell.writeTextfield.text;
                    break;
            }
            if ([textField isEqual:weakSelf.identyCell.writeTextfield]) {
                if(textField.text.length > 18) {
                    textField.text = [textField.text substringToIndex:18];
                }
                weakSelf.viewModel.identyStr = textField.text;
            }
             [weakSelf changeButtonStates];
        };
    }
    return YES;
}
- (void)clickDeleteBtn
{
    if (self.identyCell.writeTextfield.text.length > 0) {
        self.identyCell.writeTextfield.text = [self.identyCell.writeTextfield.text substringToIndex:self.identyCell.writeTextfield.text.length - 1];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //    [textField keyBoardEvent];
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if ([self.nameCell.writeTextfield isEqual:textField]) {
        [Helper textField:textField length:5];
        self.viewModel.nameStr = textField.text;
    }
    if ([textField isEqual:self.identyCell.writeTextfield]) {
        if(textField.text.length > 18) {
            textField.text = [textField.text substringToIndex:18];
        }
        self.viewModel.identyStr = textField.text;
    }
    if ([textField isEqual:self.iphoneCell.writeTextfield]){
        if(textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        self.viewModel.iphoneStr = textField.text;
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
    
    if (self.viewModel.nameStr.length!=0 && self.viewModel.identyStr.length!=0&&self.viewModel.iphoneStr.length!=0) {
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
    if (self.viewModel.identyStr.length==0) {
        [KeyWindow displayMessage:@"请填写身份证号码"];
        return;
    }
    if (self.viewModel.identyStr.length<15) {
        [KeyWindow displayMessage:@"请填写正确的身份证号码"];
        return;
    }
//    if (![Helper justIdentityCard:self.viewModel.identyStr]) {
//        [KeyWindow displayMessage:@"请填写正确的身份证号码"];
//        return;
//    }
    if (self.viewModel.iphoneStr.length==0) {
        [KeyWindow displayMessage:@"请填写电话号码"];
        return;
    }
    [self submit];
}
-(void)submit {
    [self.viewModel submitInformationWithReturnBlock:^{
        if ([self.delegate respondsToSelector:@selector(updateStates)]) {
            [self.delegate updateStates];
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
