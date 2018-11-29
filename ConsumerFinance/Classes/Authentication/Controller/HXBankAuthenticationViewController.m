////
////  HXBankAuthenticationViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/12.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXBankAuthenticationViewController.h"
//#import "STBankCardScanner.h"
//#import "HXSupportBankViewController.h"
//#import "HXBankListViewController.h"
//#import "ComButton.h"
//
//@interface HXBankAuthenticationViewController ()<UITableViewDelegate,UITableViewDataSource,STBankCardScannerDelegate,UITextFieldDelegate>
//{
//    UITableView * _tableView;
//}
//@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
//@property (nonatomic,strong) STBankCard * bankcard;
//@property (nonatomic,strong) BaseTableViewCell * cardCell; //卡号cell
//@property (nonatomic,strong) BaseTableViewCell * nameCell;//姓名cell
//@property (nonatomic,strong) BaseTableViewCell * iphoneCell;//手机号cell
//@property (nonatomic,strong) UIButton * referButton;
//@end
//
//@implementation HXBankAuthenticationViewController
//
//- (void)viewDidLoad {
//    /**
//     *  原先银行卡信息 BankInfoViewController 
//     */
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
//    self.title = @"银行卡认证";
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
//    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
//    footView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableFooterView:footView];
//    
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
//    [referButton setTitle:@"提交" forState:UIControlStateNormal];
//    self.referButton = referButton;
//    referButton.enabled = NO;
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
//    /**
//     *  忘记密码
//     */
//    ComButton * bankButton = [[ComButton alloc] init];
//    [bankButton addTarget:self action:@selector(bankButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [bankButton setTitleColor:kUIColorFromRGB(0x4a90e2) forState:UIControlStateNormal];
//    [footView addSubview:bankButton];
//    [bankButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(footView).offset(15);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(30);
//        make.top.equalTo(footView);
//    }];
//    bankButton.nameLabel.text = @"支持银行";
//    bankButton.nameLabel.font = [UIFont systemFontOfSize:12];
//    bankButton.nameLabel.textColor = kUIColorFromRGB(0x4a90e2);
//    [bankButton.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(bankButton);
//        make.left.equalTo(bankButton);
//    }];
//    bankButton.photoImage.image = [UIImage imageNamed:@"info"];
//    [bankButton.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(bankButton.nameLabel);
//        make.left.equalTo(bankButton.nameLabel.mas_right).offset(5);
//    }];
//    
//    
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 2;
//    }
//    return 1;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    static NSString *cellIdentity1 = @"IdentityInfoCell1";
//    if (indexPath.section == 0) {
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//            cell.writeTextfield.delegate = self;
//            cell.writeTextfield.tag = indexPath.row +1;
//            [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//            if (indexPath.row==0) {
//                cell.nameLabel.text = @"姓名";
//                cell.writeTextfield.placeholder = @"请输入姓名";
//                [cell creatLine:15 hidden:NO];
//                self.nameCell  =cell;
//            }else {
//                cell.nameLabel.text = @"预留手机号";
//                cell.writeTextfield.placeholder = @"请输入手机号";
//                self.iphoneCell = cell;
//            }
//        }
//        return cell;
//        
//    }else {
//        
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
//            self.cardCell = cell;
//            cell.nameLabel.text = @"卡号";
//            [cell.rightButton addTarget:self action:@selector(selectInformation) forControlEvents:UIControlEventTouchUpInside];
//            [cell.rightButton setBackgroundImage:[UIImage imageNamed:@"cameraicon"] forState:UIControlStateNormal];
//            [cell.rightButton mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView).offset(-15);
//            }];
//            [cell.writeTextfield mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView.mas_right).offset(-40);
//                make.width.mas_equalTo(200);
//            }];
////                cell.rightButton.tag = indexPath.row + selectTag;
//        }
//        
//        return cell;
//    }
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
//    return 10;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    
//}
//#pragma mark -- 支持银行卡
//-(void)bankButtonAction {
//    
//    HXSupportBankViewController * bank = [[HXSupportBankViewController alloc] init];
//    [self.navigationController pushViewController:bank animated:YES];
//}
//#pragma mark --提交按钮
//-(void)registerAction {
//    
//    HXBankListViewController * bank = [[HXBankListViewController alloc] init];
//    [self.navigationController pushViewController:bank animated:YES];
//}
//#pragma mark-textField代理
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    //    [textField keyBoardEvent];
//}
//-(void)textFieldDidChange:(UITextField *)textField
//{
//    if (_nameCell.nameLabel.text.length!=0 && _iphoneCell.nameLabel.text.length==11&&_cardCell.writeTextfield.text.length!=0) {
//        
//        _referButton.enabled = YES;
//        [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:_referButton style:UIControlStateNormal];
//    }else
//    {
//        _referButton.enabled = NO;
//        [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:_referButton style:UIControlStateNormal];
//    }
//    
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
//            allowedLength = 12;
////            astring       = LIMIT_ALPHANUM;
//        }
//            break;
//        case 2: {
//            allowedLength = 11;
//            astring       = LIMIT_ALPHANUM;
//        }
//            break;
//        case 5: {
//            allowedLength = 13;
//            astring       = LIMIT_NUMBERS;
//            if (textField.text.length==4&&string.length!=0) {
//                
//                textField.text = [NSString stringWithFormat:@"%@-", textField.text];
//            }
//            
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
//
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
//    [self removeErrorMessage];
//    
////    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] ;
////    self.resultVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ResultViewController"];
////    self.resultVC.arrKeys = @[@"银行卡号",@"发卡行名称",@"发卡行标识代码",@"卡片名称",@"卡片类型"];
////    self.resultVC.dicRecogResult = @{@"银行卡号":bankcard.strNumber,@"发卡行名称":bankcard.strBankName, @"发卡行标识代码":bankcard.strBankIdentificationNumber,@"卡片名称":bankcard.strCardName, @"卡片类型": bankcard.strCardType};
//    _cardCell.writeTextfield.text = bankcard.strNumber ? bankcard.strNumber :@"";
//    [self dismissViewControllerAnimated:NO completion:nil];
//}
//
//- (void)removeErrorMessage {
////    self.lbError.hidden = YES;
////    self.lbError.text = @"";
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
//       [_activityIndicatorView startAnimating];
//    }else{
//         [_activityIndicatorView stopAnimating];
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
////- (void)willResignActive{
////    if (!((self.isViewLoaded && self.view.window)||(self.resultVC.isViewLoaded && self.resultVC.view.window))) {
////        [self didCancel];
////    }
////}
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
