////
////  HXAddBankViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/6/12.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXAddBankViewController.h"
//#import "HXSupportBankViewController.h"
//#import "AddressPickView.h"
//#import "HXButton.h"
//#import "STBankCardScanner.h"
//#import "HXBillingdetailsViewController.h"
//
//#import <UMMobClick/MobClick.h>
//
//@interface HXAddBankViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,suportBankDelegate,STBankCardScannerDelegate>
//{
//    UITableView *_tableView;
//    HXButton * _msgCodeBut;
//}
//@property (nonatomic,strong) UIButton * referButton;
//@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
//@property (nonatomic,strong) BaseTableViewCell * cardCell; //卡号cell
//@end
//
//@implementation HXAddBankViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXAddBankViewModel alloc] init];
//        [self.viewModel archiveSuportBankInformation];
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
//    self.title = @"添加银行卡";
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
//
//    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    headView.backgroundColor = kUIColorFromRGB(0xFFF3F3);
//    _tableView.tableHeaderView = headView;
//
//    UIImageView * image = [[UIImageView alloc] init];
//    image.image = [UIImage imageNamed:@"orderfail"];
//    [headView addSubview:image];
//    [image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(headView).offset(15);
//        make.centerY.equalTo(headView);
//        make.height.and.width.mas_equalTo(15);
//
//    }];
//
//    UILabel * titleLabel = [[UILabel alloc] init];
//    titleLabel.text = @"每张银行卡每天点击“提交”限：3次";
//    titleLabel.font = [UIFont systemFontOfSize:13];
//    titleLabel.textColor = ComonBackColor;
//    [headView addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(headView);
//        make.left.equalTo(headView).mas_equalTo(40);
//    }];
//
//
//
//    /**
//     *  footView
//     */
//
//    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
//    footView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableFooterView:footView];
//
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
//    self.referButton = referButton;
//    referButton.enabled = NO;
//    [referButton setTitle:@"提交" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [footView addSubview:referButton];
//}
//
//-(void)request {
//
//    [self.viewModel archiveBankListWithReturnBlock:^{
//
//    }];
//
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
//        return 2;
//    }else if(section == 1){
//        return 3;
//    }else {
//    return 2;
//    }
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//        [cell creatLine:15 hidden:NO];
//        cell.writeTextfield.delegate = self;
//        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        cell.writeTextfield.tag = indexPath.row + indexPath.section *10 +100;
//        cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
//        if (indexPath.section==2&&indexPath.row==1) {
//            cell.writeTextfield.placeholder = @"输入验证码";
//            //            _codeTextField  = cell.writeTextfield;
//            cell.nameLabel.text = @"短信验证码";
//            /**
//             *   验证码按钮
//             */
//            _msgCodeBut = [[HXButton alloc] init];
//            [_msgCodeBut setTitle:@"发送验证码" forState:UIControlStateNormal];
//            _msgCodeBut.titleLabel.font = [UIFont systemFontOfSize:16];
//            [_msgCodeBut setTitleColor:HXRGB(60, 155, 255)
//                              forState:UIControlStateNormal];
//            [_msgCodeBut addTarget:self action:@selector(getSMSCode:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:_msgCodeBut];
//            [_msgCodeBut  mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(cell.contentView).offset(0);
//                make.right.lessThanOrEqualTo(cell.contentView.mas_right).offset(-15).with.priorityLow();
//                make.height.mas_equalTo(50);
//            }];
//            [cell.writeTextfield mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView.mas_right).offset(-100);
//            }];
//
//        }
//
//    }
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.writeTextfield.enabled =NO;
//    if (indexPath.section==0) {
//        if (indexPath.row==0) {
//            cell.nameLabel.text = @"开户名";
//            cell.writeTextfield.text = self.viewModel.nameStr?self.viewModel.nameStr:@"";
//        }else {
//            cell.nameLabel.text = @"身份证号";
//            if (self.viewModel.idCardStr.length>=16) {
//                cell.writeTextfield.text = self.viewModel.idCardStr?[self.viewModel.idCardStr stringByReplacingCharactersInRange:NSMakeRange(3, 11) withString:@"******"] :@"";
//            }else {
//                cell.writeTextfield.text = @"";
//            }
//        }
//
//    }else if(indexPath.section == 1){
//        if (indexPath.row==0) {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.nameLabel.text = @"开户银行";
//            cell.writeTextfield.placeholder = @"请选择银行";
//            cell.writeTextfield.text = self.viewModel.suportModel.bankName?self.viewModel.suportModel.bankName:@"";
//            [cell.writeTextfield mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView.mas_right).offset(0);
//            }];
//
//        }else if(indexPath.row==1){
//            cell.nameLabel.text = @"银行卡号";
//            self.cardCell = cell;
//            [cell.rightButton addTarget:self action:@selector(selectInformation) forControlEvents:UIControlEventTouchUpInside];
//            [cell.rightButton setBackgroundImage:[UIImage imageNamed:@"cameraicon"] forState:UIControlStateNormal];
//            [cell.rightButton mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView).offset(-15);
//            }];
//            [cell.writeTextfield mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView.mas_right).offset(-40);
//                make.width.mas_equalTo(200);
//            }];
//
//            cell.writeTextfield.placeholder = @"输入您的银行卡号";
//            cell.writeTextfield.enabled = YES;
//            cell.writeTextfield.text = self.viewModel.cardNumber?self.viewModel.cardNumber :@"";
//        }else {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.nameLabel.text = @"开户省市";
//            cell.writeTextfield.placeholder = @"请选择银行所在地";
//            [cell.writeTextfield mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView.mas_right).offset(0);
//            }];
//            cell.writeTextfield.text = self.viewModel.address ? self.viewModel.address:@"";
//        }
//
//    }else {
//        if (indexPath.row==0) {
//
//            cell.nameLabel.text = @"手机号";
//            cell.writeTextfield.placeholder = @"请输入银行预留手机号";
//            cell.writeTextfield.enabled = YES;
//            cell.writeTextfield.text = self.viewModel.iphoneNumber?self.viewModel.iphoneNumber:@"";
//        }else {
//            cell.writeTextfield.enabled = YES;
//        }
//
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
//    if (section==0) {
//        return 0;
//    }
//    return 10;
//}
//
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (indexPath.section == 1) {
//        if (indexPath.row==0) {
//            HXSupportBankViewController * suporBank = [[HXSupportBankViewController alloc] init];
//            suporBank.delegate = self;
//            suporBank.viewModel.banKArr = self.viewModel.supportBankArr;
//            [self.navigationController pushViewController:suporBank animated:YES];
//        }
//
//    }
//    if (indexPath.row==2) {
//        [self.view endEditing:YES];
//        //单位地址
//        AddressPickView *addressPickView = [AddressPickView shareInstance];
//        [self.view addSubview:addressPickView];
//        addressPickView.block = ^(AddressModel *provinceModel, AddressModel *cityModel){
//            self.viewModel.provinceId = provinceModel.areaCode;
//            self.viewModel.citiId = cityModel.areaCode;
//            if (provinceModel.areaName.length !=0 ||cityModel.areaName.length!=0) {
//                self.viewModel.address = [NSString stringWithFormat:@"%@ %@",provinceModel.areaName,cityModel.areaName] ;
//                [_tableView reloadData];
//            }
//            [self changeButtonStates];
//        };
//    }
//}
//#pragma mark --获取验证码
//-(void)getSMSCode:(HXButton*)button {
//    [self.view endEditing:YES];
//    if (self.viewModel.suportModel.bankName.length==0) {
//        [KeyWindow displayMessage:@"请选择开户银行"];
//        return;
//    }
//
//    if (self.viewModel.cardNumber.length<16 ||self.viewModel.cardNumber.length>19) {
//        [KeyWindow displayMessage:@"请输入正确的银行卡号"];
//        return;
//    }
//    if (![self isValidCardNumber:self.viewModel.cardNumber]) {
//        [KeyWindow displayMessage:@"请输入正确的银行卡号"];
//        return;
//    }
////    NSString * bankName = [Helper returnBankName:self.viewModel.cardNumber];
////    if (![bankName containsString:[Helper exchangeBankeName:self.viewModel.suportModel.bankName]]) {
////        [KeyWindow displayMessage:@"当前卡号不属于所选银行"];
////        return;
////    }
////
////    if (![Helper belogCardNumber:self.viewModel.cardNumber bankArr:self.viewModel.supportBankArr]) {
////        [KeyWindow displayMessage:@"暂不支持该银行"];
////        return;
////    }
//
//    if (self.viewModel.address.length == 0) {
//        [KeyWindow displayMessage:@"请选择开户省市"];
//        return;
//    }
//    if (![Helper justMobile:self.viewModel.iphoneNumber]) {
//        [KeyWindow displayMessage:@"请输入正确的手机号"];
//        return;
//    }
//    [self.viewModel archiveMessageWithReturnBlock:^{
//
//        [button timeStart];
//    }];
//}
//
//#pragma mark-textField代理
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    //    [textField keyBoardEvent];
//}
//-(void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField.tag == 111) {
//        self.viewModel.cardNumber = textField.text;
//    }
//    if (textField.tag == 120) {
//        self.viewModel.iphoneNumber = textField.text;
//    }
//    if (textField.tag == 121) {
//        self.viewModel.messageCode = textField.text;
//    }
//
//    [self changeButtonStates];
//}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//    NSInteger allowedLength = 100;
//    NSString  *astring      = @"";
//
//
//    switch (textField.tag) {
//        case 111: {
//            allowedLength = 19;
//            astring       = LIMIT_NUMBERS;
//        }
//            break;
//        case 120: {
//            allowedLength = 11;
//            astring       = LIMIT_NUMBERS;
//        }
//            break;
//        case 121: {
//            allowedLength = 6;
//            astring       = LIMIT_NUMBERS;
//
//        }
//            break;
//        case 7: {
//            allowedLength = 8;
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
//    if (self.viewModel.cardNumber.length!=0 && self.viewModel.address.length!=0&&self.viewModel.iphoneNumber.length!=0&&self.viewModel.messageCode.length!=0) {
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
//    if (self.viewModel.suportModel.bankName.length==0) {
//        [KeyWindow displayMessage:@"请选择开户银行"];
//        return;
//    }
//    if (self.viewModel.cardNumber.length<16 ||self.viewModel.cardNumber.length>19) {
//        [KeyWindow displayMessage:@"请输入正确的银行卡号"];
//        return;
//    }
//    if (![self isValidCardNumber:self.viewModel.cardNumber]) {
//        [KeyWindow displayMessage:@"请输入正确的银行卡号"];
//        return;
//    }
////    NSString * bankName = [Helper returnBankName:self.viewModel.cardNumber];
////    if (![bankName containsString:[Helper exchangeBankeName:self.viewModel.suportModel.bankName]]) {
////        [KeyWindow displayMessage:@"当前卡号不属于所选银行"];
////        return;
////    }
////
////    if (![Helper belogCardNumber:self.viewModel.cardNumber bankArr:self.viewModel.supportBankArr]) {
////        [KeyWindow displayMessage:@"暂不支持该银行"];
////        return;
////    }
//
//
//    if (self.viewModel.address.length == 0) {
//        [KeyWindow displayMessage:@"请选择开户省市"];
//        return;
//    }
//    if (![Helper justMobile:self.viewModel.iphoneNumber]) {
//        [KeyWindow displayMessage:@"请输入正确的手机号"];
//        return;
//    }
//    if (self.viewModel.messageCode.length<6) {
//        [KeyWindow displayMessage:@"请输入正确的短信验证码"];
//        return;
//    }
//    [self.viewModel submitBankInformationWithReturnBlock:^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_BankCard object:nil userInfo:nil];
//        for (UIViewController *temp in self.navigationController.viewControllers) {
//            if ([temp isKindOfClass:[HXBillingdetailsViewController class]]) {
//                [self.navigationController popToViewController:temp animated:YES];
//                return ;
//            }
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//
//    }];
//
//}
//#pragma mark -- OCR 银行卡
//-(void)selectInformation {
//    STBankCardScanner *scannerVC = [[STBankCardScanner alloc] initWithOrientation:AVCaptureVideoOrientationPortrait];
//    scannerVC.delegate = self;
//    [scannerVC.view addSubview:self.activityIndicatorView];
//    [self presentViewController:scannerVC animated:NO completion:nil];
//
//}
//#pragma mark - delegate
//- (void)getCardResult:(STBankCard *)bankcard {
//    [MobClick event:Event_ocr_bankcard_success];
//    [self removeErrorMessage];
//
//    if (bankcard.strNumber.length!=0) {
//        HXSuportBankModel * model = [Helper belogCardNumber:bankcard.strNumber bankArr:self.viewModel.supportBankArr];
//        if (model) {
//
//            _cardCell.writeTextfield.text = bankcard.strNumber ? bankcard.strNumber :@"";
//
//            self.viewModel.cardNumber = bankcard.strNumber ? bankcard.strNumber :@"";
//            self.viewModel.suportModel = model;
//            [_tableView reloadData];
//        }else {
//            _cardCell.writeTextfield.text = bankcard.strNumber ? bankcard.strNumber :@"";
//
//            self.viewModel.cardNumber = bankcard.strNumber ? bankcard.strNumber :@"";
//            [_tableView reloadData];
//
//        }
//
//    }
//
//    [self dismissViewControllerAnimated:NO completion:nil];
//}
//
//- (void)removeErrorMessage {
//    //    self.lbError.hidden = YES;
//    //    self.lbError.text = @"";
//}
//
//- (void)didCancel {
//    [KeyWindow displayMessage:@"取消扫描"];
//    [_activityIndicatorView stopAnimating];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)getError:(STBankCardErrorCode)errorCode {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    });
//    switch (errorCode) {
//        case kBankCardAPIAcountFailed:
//        {
//            [KeyWindow displayMessage:@"API账户信息错误，请检查API_KEY和API_SECRET"];
//        }
//            break;
//        case kBankCardHandleInitFailed:
//        {
//            [KeyWindow displayMessage:@"算法SDK初始化失败：\n模型与算法库不匹配"];
//        }
//            break;
//        case kBankCardCameraAuthorizationFailed:
//        {
//            [KeyWindow displayMessage:@"相机授权失败，请在设置中打开相机权限"];
//        }
//            break;
//        case kBankCardAuthFileNotFound:
//        {
//            [KeyWindow displayMessage:@"授权文件不存在"];
//        }
//            break;
//        case kBankCardModelFileNotFound:
//        {
//            [KeyWindow displayMessage:@"模型文件不存在"];
//        }
//            break;
//        case kBankCardInvalidAuth:
//        {
//            [KeyWindow displayMessage:@"授权文件不合法"];
//        }
//            break;
//        case kBankCardInvalidAPPID:
//        {
//            [KeyWindow displayMessage:@"授权文件不合法"];
//        }
//            break;
//        case kBankCardAuthExpire:
//        {
//            [KeyWindow displayMessage:@"授权文件过期"];
//        }
//            break;
//
//        default:
//            break;
//    }
//}
//- (void)isUploading:(BOOL)loadingStatus{
//    if (loadingStatus) {
//        [_activityIndicatorView startAnimating];
//    }else{
//        [_activityIndicatorView stopAnimating];
//    }
//
//}
//- (UIActivityIndicatorView *)activityIndicatorView{
//    if (!_activityIndicatorView) {
//        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//        _activityIndicatorView.center = self.view.center;
//        [_activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    }
//    return _activityIndicatorView;
//}
////剔除卡号里的非法字符
//-(NSString *)getDigitsOnly:(NSString*)s
//{
//    NSString *digitsOnly = @"";
//    char c;
//    for (int i = 0; i < s.length; i++)
//    {
//        c = [s characterAtIndex:i];
//        if (isdigit(c))
//        {
//            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
//        }
//    }
//    return digitsOnly;
//}
//
////检查银行卡是否合法
////Luhn算法
//-(BOOL)isValidCardNumber:(NSString *)cardNumber
//{
//    NSString *digitsOnly = [self getDigitsOnly:cardNumber];
//    int sum = 0;
//    int digit = 0;
//    int addend = 0;
//    BOOL timesTwo = false;
//    for (int i = digitsOnly.length - 1; i >= 0; i--)
//    {
//        digit = [digitsOnly characterAtIndex:i] - '0';
//        if (timesTwo)
//        {
//            addend = digit * 2;
//            if (addend > 9) {
//                addend -= 9;
//            }
//        }
//        else {
//            addend = digit;
//        }
//        sum += addend;
//        timesTwo = !timesTwo;
//    }
//    int modulus = sum % 10;
//    return modulus == 0;
//}
//
//#pragma mark --suportBankDelegate
//-(void)selectSuportBank:(HXSuportBankModel *)model {
//
//    self.viewModel.suportModel = model;
//    [_tableView reloadData];
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
