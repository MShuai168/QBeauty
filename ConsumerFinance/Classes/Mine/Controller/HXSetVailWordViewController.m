////
////  HXSetVailWordViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/16.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXSetVailWordViewController.h"
//
//@interface HXSetVailWordViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong) UIButton * referButton;
//@property (nonatomic,strong)BaseTableViewCell * passWordCell;
//@end
//
//@implementation HXSetVailWordViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"设置登录密码";
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
//    _tableView.backgroundColor = COLOR_BACKGROUND;
//    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
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
//    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 112)];
//    footView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableFooterView:footView];
//    
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
//    self.referButton = referButton;
//    referButton.enabled = NO;
//    [referButton setTitle:@"确认" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [footView addSubview:referButton];
//    
//    
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//        cell.writeTextfield.placeholder = @"请设置8-16位的登录密码";
//        cell.writeTextfield.tag = indexPath.row+1;
//        cell.nameLabel.text = @"设置密码";
//        cell.writeTextfield.delegate = self;
//        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        self.passWordCell = cell;
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
//    return 38;
//}
//
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (indexPath.section == 0) {
//        
//    }else if(indexPath.section==1) {
//        
//    }else {
//        
//    }
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
//    view.backgroundColor = COLOR_BACKGROUND;
//    
//    
//    UILabel * nameLabel = [[UILabel alloc] init];
//    nameLabel.font = [UIFont systemFontOfSize:13];
//    nameLabel.textColor = ComonCharColor;
//    [view addSubview:nameLabel];
//    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(view).offset(15);
//        make.center.equalTo(view);
//    }];
//    nameLabel.text = @"密码由8-16位英文字母、数字组成";
//    return view;
//}
//
//#pragma mark - UITextFieldDelegate
//
//-(void)textFieldDidChange:(UITextField *)textField
//{
//    [self changeButtonStates];
//}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    NSInteger allowedLength = 100;
//    NSString  *astring      = @"";
//    
//    
//    switch (textField.tag) {
//        case 1: {
//            allowedLength = 16;
//            astring       = LIMIT_ALPHANUM;
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
//    if (_passWordCell.writeTextfield.text.length >=8 ) {
//        _referButton.enabled = YES;
//        [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:_referButton style:UIControlStateNormal];
//    }else {
//        
//        _referButton.enabled = NO;
//        [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:_referButton style:UIControlStateNormal];
//    }
//}
//#pragma mark -- 确定
//-(void)registerAction {
//    [self.view endEditing:YES];
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
