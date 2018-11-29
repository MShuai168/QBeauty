////
////  HXHomeInformationViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/24.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXHomeInformationViewController.h"
//#import "HXSelectTableView.h"
//#import "HXHomeInformationViewModel.h"
//@interface HXHomeInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong) UIButton * referButton;
//@property (nonatomic,strong) BaseTableViewCell * houseCell;
//@property (nonatomic,strong) BaseTableViewCell * incomeCell;
//@property (nonatomic,strong) NSString * income;
//@property (nonatomic,strong) NSString * house;
//
//@property (nonatomic,strong)HXHomeInformationViewModel*viewModel;
//@end
//
//@implementation HXHomeInformationViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXHomeInformationViewModel alloc] initWithController:self];
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
//    [self request];
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"家庭认证";
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//    self.view.backgroundColor = HXRGB(255, 255, 255);
//}
//-(void) hiddeKeyBoard{
//    
//    [self.view endEditing:YES];
//    
//}
//-(void)createUI {
//    /**
//     *  tableView
//     */
//    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
//    _tableView.backgroundColor = COLOR_BACKGROUND;
//    [self.view addSubview:_tableView];
//    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top);
//        make.right.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//    }];
//    /**
//     *  footView
//     */
//    
//    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
//    footView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableFooterView:footView];
//    
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
//    self.referButton  = referButton;
//    self.referButton.enabled = NO;
//    [referButton setTitle:@"保存" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [footView addSubview:referButton];
//
//}
//#pragma mark request 
//-(void)request {
//    
//    [self.viewModel archiveHomeInformationWithReturnBlock:^{
//        self.house = [ProfileManager getEstateStringWithCode:self.viewModel.model.houseProperty];
//        self.income = self.viewModel.model.income;
//        [self changeButtonStates];
//        [_tableView reloadData];
//    }];
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//        if (indexPath.row == 0) {
//            [cell creatLine:15 hidden:NO];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.titleLabel.text = @"请选择";
//            cell.nameLabel.text = @"房产信息";
//            [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView);
//            }];
//            self.houseCell = cell;
//         
//        }else {
//            cell.nameLabel.text = @"家庭收入";
//            cell.writeTextfield.placeholder = @"请输入家庭年收入";
//            cell.writeTextfield.tag = indexPath.row+1;
//            cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
//            cell.writeTextfield.delegate =self;
//            [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//            cell.writeTextfield.textColor = kUIColorFromRGB(0x666666);
//            self.incomeCell = cell;
//        }
//    }
//    if (indexPath.row==0) {
//        cell.titleLabel.text = _house.length?_house:@"请选择";
//        cell.titleLabel.textColor = _house.length?kUIColorFromRGB(0x666666): ComonCharColor;
//    }else {
//        cell.writeTextfield.text = _income.length?_income:@"";
//    }
//    
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 50;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.1;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 10;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (indexPath.row == 0) {
//        [self.view endEditing:YES];
//        [[HXSelectTableView shareSheet] hx_selectTableWithSelectArray:@[@"自有房产,无按揭",@"自有房产,有按揭",@"亲属房产",@"其它"] title:@"选择房产信息" select:^(NSString * name){
//            _houseCell.titleLabel.text = name;
//            _houseCell.titleLabel.textColor = name?kUIColorFromRGB(0x666666): ComonCharColor;
//            self.house = name;
//            [self changeButtonStates];
//        }];
//    }else if(indexPath.section==1) {
//        
//    }else {
//        
//    }
//}
//#pragma mark-textField代理
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    //    [textField keyBoardEvent];
//}
//-(void)textFieldDidChange:(UITextField *)textField
//{
//        if ([textField isEqual:self.incomeCell.writeTextfield]) {
//            self.income = textField.text;
//        }
//    [self changeButtonStates];
//}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    NSInteger allowedLength = 100;
//    NSString  *astring      = @"";
//    
//    
//    switch (textField.tag) {
//        case 2: {
//            allowedLength = 8;
//            astring       = LIMIT_NUMBERS;
//        }
//            break;
//        case 5: {
//            allowedLength = 20;
//        }
//            break;
//        case 6: {
//            allowedLength = 13;
//            astring       = LIMIT_NUMBERS;
//            if (textField.text.length==4&&string.length!=0) {
//                
//                textField.text = [NSString stringWithFormat:@"%@-", textField.text];
//            }
//            
//        }
//            break;
//        case 7: {
//            allowedLength = 10;
//            astring       = LIMIT_NUMBERS;
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
//        return NO;
//    }
//    
//    if ([NSString isBlankString:astring]) {
//        if ([textField.text length] < allowedLength || [string length] == 0) {
//            return YES;
//        }else {
//            [textField shakeAnimation];
//            return NO;
//        }
//    } else {
//        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:astring] invertedSet];
//        //按cs分离出数组,数组按@""分离出字符串
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL canChange     = [string isEqualToString:filtered];
//        
//        if ((canChange && [textField.text length] < allowedLength) || [string length] == 0) {
//            return YES;
//        }else {
//            [textField shakeAnimation];
//            return NO;
//        }
//    }
//    
//}
//#pragma mark -- 判断按钮状态
//-(void)changeButtonStates {
//    if (_income.length!=0&&_house.length !=0) {
//        _referButton.enabled = YES;
//        [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:_referButton style:UIControlStateNormal];
//    }else {
//        
//        _referButton.enabled = NO;
//        [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:_referButton style:UIControlStateNormal];
//    }
//    
//    
//}
//#pragma mark -- 提交
//-(void)registerAction {
//    [self.view endEditing:YES];
//    [self.viewModel submitInformationWithHoutse:self.house income:self.income returnBlock:^{
//        [KeyWindow displayMessage:@"认证成功"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Authentication object:nil userInfo:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//
//    }];
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
