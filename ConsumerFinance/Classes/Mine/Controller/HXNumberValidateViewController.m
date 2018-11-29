////
////  HXNumberValidateViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/16.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXNumberValidateViewController.h"
//#import "HDTextField.h"
//#import "HXButton.h"
//#import "HXSetVailWordViewController.h"
//@interface HXNumberValidateViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
//{
//    UITableView *_tableView;
//    HXButton * _msgCodeBut;
//    HDTextField * _codeTextField;
//}
//@property (nonatomic,strong) UIButton * referButton;
//@end
//
//@implementation HXNumberValidateViewController
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
//    self.title = @"安全认证";
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
//    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 112)];
//    footView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableFooterView:footView];
//    
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
//    self.referButton = referButton;
//    referButton.enabled = NO;
//    [referButton setTitle:@"下一步" forState:UIControlStateNormal];
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
//        cell.writeTextfield.placeholder = @"输入验证码";
//        _codeTextField  = cell.writeTextfield;
//        cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
//        cell.writeTextfield.tag = indexPath.row+1;
//        cell.nameLabel.text = @"短信验证码";
//        /**
//         *   验证码按钮
//         */
//        _msgCodeBut = [[HXButton alloc] init];
//        [_msgCodeBut setTitle:@"重新发送" forState:UIControlStateNormal];
//        _msgCodeBut.titleLabel.font = [UIFont systemFontOfSize:16];
//        [_msgCodeBut setTitleColor:HXRGB(60, 155, 255)
//                          forState:UIControlStateNormal];
//        [_msgCodeBut addTarget:self action:@selector(getSMSCode:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:_msgCodeBut];
//        [_msgCodeBut  mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(cell.contentView).offset(0);
//            make.right.lessThanOrEqualTo(cell.contentView.mas_right).offset(-15).with.priorityLow();
//            make.height.mas_equalTo(50);
//        }];
//        [cell.writeTextfield mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(cell.contentView.mas_right).offset(-85);
//        }];
//        cell.writeTextfield.delegate =self;
//        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
//    nameLabel.text = @"短信已发送至手机：1234543213";
//    return view;
//}
//#pragma mark -- 获取短信验证码
///**
// *  获取短信验证码
// */
//-(void)getSMSCode:(HXButton*)but{
//    
//    [self.view endEditing:YES];
//    //    if (_imgCodeText.text.length == 0) {
//    //        [KeyWindow displayMessage:@"图形验证码不能为空"];
//    //        return;
//    //    }
//    //    if (_phoneText.text.length == 0) {
//    //        [KeyWindow displayMessage:@"手机号码不能为空"];
//    //        return;
//    //    }
//    //    NSDictionary *head = @{@"tradeCode" : @"0005",
//    //                           @"tradeType" : @"authService"};
//    //    NSDictionary *body = @{@"UUID"      : K_UUID,
//    //                           @"verificationCode" : _imgCodeText.text,
//    //                           @"phoneNumber" : _phoneText.text,
//    //                           @"type" : @"2"};
//    //    [MBProgressHUD showMessage:nil toView:self.view];
//    //    [MobClick event:Event_get_verification_code];
//    //
//    //    [[AFNetManager manager] postRequestWithHeadParameter:head
//    //                                           bodyParameter:body
//    //                                                 success:^(ResponseModel *object) {
//    //
//    //                                                     [MBProgressHUD hideHUDForView:self.view];
//    //                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//    //                                                         [but timeStart];
//    //                                                     }
//    //                                                 } fail:^(ErrorModel *error) {
//    //
//    //                                                     [MBProgressHUD hideHUDForView:self.view];
//    //                                                     [self showImgCode];
//    //                                                 }];
////    [_query getMessage];
//    
//    
//}
//#pragma mark-textField代理
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    //    [textField keyBoardEvent];
//}
//-(void)textFieldDidChange:(UITextField *)textField
//{
//        if (_codeTextField.text.length==6) {
//    
//            _referButton.enabled = YES;
//            [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:_referButton style:UIControlStateNormal];
//        }else
//        {
//            _referButton.enabled = NO;
//            [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:_referButton style:UIControlStateNormal];
//        }
//    
//}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    NSInteger allowedLength = 100;
//    NSString  *astring      = @"";
//    
//    
//    switch (textField.tag) {
//        case 1: {
//            allowedLength = 6;
//            astring       = LIMIT_NUMBERS;
//        }
//            break;
//        case 2: {
//            allowedLength = 6;
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
//#pragma mark -- 下一步
//-(void)registerAction {
//    HXSetVailWordViewController * pass = [[HXSetVailWordViewController alloc] init];
//    
//    [self.navigationController pushViewController:pass animated:YES];
//    
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
