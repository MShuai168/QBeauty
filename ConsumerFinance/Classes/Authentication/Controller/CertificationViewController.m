////
////  CertificationViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/10.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "CertificationViewController.h"
//#import "BaseTableViewCell.h"
//#import "ComButton.h"
//#import "STIDCardScanner.h"
//#import "HXImageUploadViewController.h"
//#import "JCKeyBoardNum.h"
//#import "UITextField+JCTextField.h" // 自定义数字键盘
//#import "HXBillingdetailsViewController.h"
//#import "HXSecurityViewController.h"
//#import "HXIdCardVerificationViewController.h"
//
//#import <UMMobClick/MobClick.h>
//
//typedef NS_OPTIONS(NSInteger, RecogResultType) {
//    kResultTypeFront = 1,
//    kResultTypeBack = 2,
//    kResultTypeNameAndNumOnly = 3,
//    kResultTypeUICustom = 4,
//    kResultTypeScanFrontAndBack = 5,
//};
//#define takePhoto 100
//@interface CertificationViewController ()<UITableViewDelegate,UITableViewDataSource,STIDCardScannerDelegate,UITextFieldDelegate>
//{
//    UITableView *_tableView;
//    RecogResultType _type;
//}
//@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
//@property (nonatomic,strong) STIDCard * idCardFront; //身份证前面信息
//@property (nonatomic,strong) STIDCard * idCardBack; //身份证背面信息
//@property (nonatomic,strong) ComButton * idFrontButton; //身份正面按钮
//@property (nonatomic,strong) ComButton * idbackButton; //身份背面按钮
//@property (nonatomic, strong) STIDCardScanner *scanFrontAndBackVC;
//@property (nonatomic, strong) UIImageView * frontImage;
//@property (nonatomic,strong) UIImageView * backImage;
//@property (nonatomic,strong) NSString * name;
//@property (nonatomic,strong) NSString * idcardNumber;
//@property (nonatomic,strong) NSString * validity;//有效期
//@property (nonatomic,strong) NSString * strAuthority;
//@property (nonatomic,strong) BaseTableViewCell * idCardCell;
//
//@property (nonatomic, strong) JCKeyBoardNum *NumKeyBoard;
//@property (nonatomic,assign)BOOL certificationBool;
//@property (nonatomic,strong)UIButton * referButton;
//@end
//
//@implementation CertificationViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXCertificationViewModel alloc] initWithController:self];
//        self.certificationBool = NO;
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    /**
//     *  原身份认证界面 CertifyIdentityViewController
//     */
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
//    self.title = @"实名认证";
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
//    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
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
//    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 123)];
//    footView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableFooterView:footView];
//    
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 70, SCREEN_WIDTH-30, 50)];
//    self.referButton = referButton;
//    referButton.enabled  = NO;
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
//#pragma mark - requst
//-(void)request {
//    
//    [_viewModel archiveCertificationWithReturnBlock:^{
//        self.name = self.viewModel.certifiModel.realName;
//        self.idcardNumber = self.viewModel.certifiModel.idCard;
//        [self changeButtonStates];
//        self.validity = self.viewModel.certifiModel.validPeriod;
//        self.strAuthority = self.viewModel.certifiModel.issuingAuthority;
//        if ([Helper authBool:self.viewModel.certifiModel.isAuth]) {
//            if (self.viewModel.certifiModel.realName.length>=2) {
//                self.name =  [NSString stringWithFormat:@"＊%@", [self.viewModel.certifiModel.realName substringFromIndex:1]];
//            }
//            self.certificationBool = YES;
//            self.referButton.hidden = YES;
//            self.idFrontButton.enabled = NO;
//            if (self.viewModel.certifiModel.idCard.length!=0) {
//                if (self.viewModel.certifiModel.idCard.length>=18) {
//                    self.idcardNumber = [NSString stringWithFormat:@"%@******%@", [self.viewModel.certifiModel.idCard substringToIndex:4], [self.viewModel.certifiModel.idCard substringFromIndex:14]];
//                }
//            }
//        }else {
//            self.certificationBool = NO;
//            self.referButton.hidden = NO;
//            self.idFrontButton.enabled = YES;
//            self.idcardNumber = self.viewModel.certifiModel.idCard;
//            
//        }
//        /**
//         *  需求为确定 回显代码暂时注掉
//         */
//        //        if (self.viewModel.photoArr) {
//        //            if (self.viewModel.photoArr.count>=2) {
//        //          [_frontImage sd_setImageWithURL:[NSURL URLWithString:[self.viewModel.photoArr firstObject]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //              _frontImage.hidden = NO;
//        //          }];
//        //                [_backImage sd_setImageWithURL:[NSURL URLWithString:[self.viewModel.photoArr lastObject]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //                    _backImage.hidden = NO;
//        //                }];
//        ////                _backImage.image = [self.viewModel.photoArr lastObject];
//        //
//        //                self.idFrontButton.hidden = YES;
//        //            }
//        //        }
//        
//        [_tableView reloadData];
//    }];
//    
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
//            cell.nameLabel.text = @"真实姓名";
//            cell.writeTextfield.placeholder = @"请输入真实姓名";
//        }else {
//            cell.nameLabel.text = @"身份证号";
//            cell.writeTextfield.placeholder = @"请输入身份证号";
//            self.idCardCell = cell;
//        }
//    }
//    [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    cell.writeTextfield.delegate = self;
//    cell.writeTextfield.tag = indexPath.row + indexPath.section *10 +100;
//    if (indexPath.row==0) {
//        cell.writeTextfield.text = self.name.length!=0 ? self.name :@"";
//    }else  {
//        cell.writeTextfield.text = self.idcardNumber.length!=0 ? self.idcardNumber :@"";
//    }
//    if (self.certificationBool) {
//        cell.writeTextfield.enabled = NO;
//    }
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
//    
//}
//#pragma mark -- 提交资料
//-(void)registerAction {
//    [self.view endEditing:YES];
//    if (self.name.length==0) {
//        [KeyWindow displayMessage:@"请填写正确的姓名"];
//        return;
//    }
//    if (self.idcardNumber.length==0) {
//        [KeyWindow displayMessage:@"请填写身份证号码"];
//        return;
//    }
//    if (self.idcardNumber.length<18) {
//        [KeyWindow displayMessage:@"请填写正确的身份证号码"];
//        return;
//    }
//    if (![Helper justIdentityCard:self.idcardNumber]) {
//        [KeyWindow displayMessage:@"请填写正确的身份证号码"];
//        return;
//    }
//    [_viewModel cheakNameAndIdWithName:self.name idcard:self.idcardNumber ReturnValue:^{
//        
//        [_viewModel submitCertificationWithName:self.name idcard:self.idcardNumber  returnBlock:^{
//            [KeyWindow displayMessage:@"认证成功"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Authentication object:nil userInfo:nil];
//            
//            for (UIViewController *temp in self.navigationController.viewControllers) {
//                if ([temp isKindOfClass:[HXBillingdetailsViewController class]]) {
//                    [self.navigationController popToViewController:temp animated:YES];
//                    return ;
//                }
//            }
//            for (UIViewController *temp in self.navigationController.viewControllers) {
//                if ([temp isKindOfClass:[HXSecurityViewController class]]) {
//                    HXIdCardVerificationViewController * card = [[HXIdCardVerificationViewController alloc] init];
//                    [self.navigationController pushViewController:card animated:YES];
//                    
//                    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
//                    for (UIViewController *vc in marr) {
//                        if ([vc isKindOfClass:[CertificationViewController class]]) {
//                            [marr removeObject:vc];
//                            break;
//                        }
//                    }
//                    self.navigationController.viewControllers = marr;
//                    
//                    return ;
//                }
//                
//            }
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//    }];
//}
//
//#pragma mark-textField代理
//#pragma mark - UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if (textField == self.idCardCell.writeTextfield) {
//        self.NumKeyBoard = [JCKeyBoardNum show];
//        textField.inputView = self.NumKeyBoard;
//        __weak typeof(self) weakSelf = self;
//        //点击键盘
//        self.NumKeyBoard.completeBlock = ^(NSString *text,NSInteger tag) {
//            switch (tag) {
//                case 9:
//                    if (weakSelf.idcardNumber.length!=0 &&![weakSelf.idcardNumber containsString:@"X"]&&weakSelf.idcardNumber.length==17 ) {
//                        
//                        [weakSelf.idCardCell.writeTextfield changTextWithNSString:@"X"];
//                        weakSelf.idcardNumber = weakSelf.idCardCell.writeTextfield.text;
//                    }
//                    
//                    break;
//                case 11:
//                    //点击删除按钮
//                    [weakSelf clickDeleteBtn];
//                    weakSelf.idcardNumber = weakSelf.idCardCell.writeTextfield.text;
//                    break;
//                default:
//                    //点击数字键盘
//                    [weakSelf.idCardCell.writeTextfield changTextWithNSString:text];
//                    weakSelf.idcardNumber = weakSelf.idCardCell.writeTextfield.text;
//                    break;
//            }
//            [weakSelf changeButtonStates];
//        };
//    }
//    return YES;
//}
//- (void)clickDeleteBtn
//{
//    if (self.idCardCell.writeTextfield.text.length > 0) {
//        self.idCardCell.writeTextfield.text = [self.idCardCell.writeTextfield.text substringToIndex:self.idCardCell.writeTextfield.text.length - 1];
//    }
//}
//-(void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField.tag == 100) {
//        if(textField.text.length > 20) {
//            textField.text = [textField.text substringToIndex:20];
//        }
//        self.name = textField.text;
//    }
//    if (textField.tag == 101) {
//        self.idcardNumber = textField.text;
//    }
//    if (textField.tag == 102) {
//        self.validity = textField.text;
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
//        case 100: {
//            allowedLength = 20;
//        }
//            break;
//        case 101: {
//            allowedLength = 18;
//            astring       = LIMIT_NUMBERS;
//        }
//            break;
//        case 102: {
//            allowedLength = 17;
//            astring       = LIMIT_NUMBERS;
//            if (textField.text.length==8&&string.length!=0) {
//                
//                textField.text = [NSString stringWithFormat:@"%@-", textField.text];
//            }
//            
//        }
//            break;
//        default:
//            break;
//    }
//    
//    
//    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
//        return NO;
//    }
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
//#pragma mark -- 资料上传
//-(void)materialAction {
//    HXImageUploadViewController * imageUpload = [[HXImageUploadViewController alloc] init];
//    imageUpload.nameStr = self.viewModel.certifiModel.realName;
//    imageUpload.idCardNumber = self.viewModel.certifiModel.idCard;
//    [self.navigationController pushViewController:imageUpload animated:YES];
//}
//
//-(void)changeButtonStates {
//    
//    if (self.name.length!=0 && self.idcardNumber.length!=0) {
//        self.referButton.enabled = YES;
//        [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:self.referButton style:UIControlStateNormal];
//        
//    }else {
//        
//        self.referButton.enabled = NO;
//        [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:self.referButton style:UIControlStateNormal];
//    }
//    
//    
//    
//}
//
//#pragma mark - OCR Init Setting Method - OCR初始化设置
//
//- (void)scanFront:(id)sender{
//    
//    if (self.name.length==0 && self.idcardNumber.length == 0 && !self.frontImage.image) {
//        
//        STIDCardScanner * scanFrontAndBackVC = [[STIDCardScanner alloc] initWithOrientation:AVCaptureVideoOrientationPortrait];
//        scanFrontAndBackVC.delegate = self;
//        _scanFrontAndBackVC = scanFrontAndBackVC;
//        scanFrontAndBackVC.cardMode = kIDCardFrontal;
//        _type = kResultTypeScanFrontAndBack;
//        [self presentViewController:scanFrontAndBackVC animated:YES completion:nil];
//        [scanFrontAndBackVC.view addSubview:self.activityIndicatorView];
//    }else {
//        STIDCardScanner *scanVC = [[STIDCardScanner alloc] initWithOrientation:AVCaptureVideoOrientationPortrait];
//        scanVC.delegate = self;
//        scanVC.cardMode = kIDCardBack;
//        [self presentViewController:scanVC animated:YES completion:nil];
//        _type = kResultTypeBack;
//        [scanVC.view addSubview:self.activityIndicatorView];
//        
//    }
//    
//}
//
//#pragma mark - ID card delegate - ID Card回调方法
//
//- (void) getCardResult:(STIDCard *)idcard {
//    [MobClick event:Event_ocr_idcard_success];
//    switch (_type) {
//        case kResultTypeScanFrontAndBack:
//        {
//            [_scanFrontAndBackVC doRecognitionProcess:NO];
//            
//            if (_scanFrontAndBackVC.cardMode == kIDCardFrontal) {
//                [self praseIDCardFront:idcard];
//                
//                UILabel *label = [[UILabel alloc] init];
//                label.text = @"扫描成功";
//                label.textColor = [UIColor colorWithRed:83/255.0 green:239/255.0 blue:160/255.0 alpha:1];
//                [_scanFrontAndBackVC setHintLabel:label];
//                
//                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC));
//                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                    _scanFrontAndBackVC.cardMode = kIDCardBack;
//                    [_scanFrontAndBackVC doRecognitionProcess:YES];
//                });
//                return;
//            }else{
//                [self praseIDCardBack:idcard];
//                [_scanFrontAndBackVC doRecognitionProcess:NO];
//            }
//        }
//            break;
//        case kResultTypeBack:
//        {
//            [self praseIDCardBack:idcard];
//        }
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)praseIDCardFront:(STIDCard *)idcard{
//    self.idCardFront = idcard;
//    _frontImage.image = self.idCardFront.imgCardDetected ? self.idCardFront.imgCardDetected: [UIImage imageNamed:@"takephoto"];
//    self.name = self.idCardFront.strName;
//    self.idcardNumber = self.idCardFront.strID;
//    
//    [_tableView reloadData];
//    [self.idFrontButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(30+(SCREEN_WIDTH-75)/2+15);
//    }];
//    _frontImage.hidden = NO;
//    self.idFrontButton.nameLabel.text = @"身份证反面";
//}
//
//- (void)praseIDCardBack:(STIDCard *)idcard{
//    self.idCardBack = idcard;
//    _backImage.image = idcard.imgCardDetected ? idcard.imgCardDetected: [UIImage imageNamed:@"takephoto"];
//    self.validity = idcard.strValidity;
//    self.strAuthority = idcard.strAuthority;
//    self.idFrontButton.hidden = YES;
//    _backImage.hidden = NO;
//    _frontImage.hidden = NO;
//    [_tableView reloadData];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}
//
//- (void)removeErrorMessage {
//    //    self.lbError.hidden = YES;
//    //    self.lbError.text = @"";
//}
//
//
//- (void)didCancel {
//    [KeyWindow displayMessage:@"取消扫描"];
//    [_activityIndicatorView stopAnimating];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)getError:(STIDCardErrorCode)errorCode {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    });
//    self.scanFrontAndBackVC = nil;
//    switch (errorCode) {
//        case kIDCardAPIAcountFailed:
//        {
//            [KeyWindow displayMessage:@"API账户信息错误，请检查API_KEY和API_SECRET"];
//        }
//            break;
//        case kIDCardHandleInitFailed:
//        {
//            [KeyWindow displayMessage:@"算法SDK初始化失败：\n模型与算法库不匹配"];
//            
//        }
//            break;
//        case kIDCardCameraAuthorizationFailed:
//        {
//            [KeyWindow displayMessage:@"相机授权失败，请在设置中打开相机权限"];
//            
//        }
//            break;
//        case kIDCardAuthFileNotFound:
//        {
//            [KeyWindow displayMessage:@"授权文件不存在"];
//            
//        }
//            break;
//        case kIDCardModelFileNotFound:
//        {
//            [KeyWindow displayMessage:@"模型文件不存在"];
//            
//        }
//            break;
//        case kIDCardInvalidAuth:
//        {
//            [KeyWindow displayMessage:@"授权文件不合法"];
//        }
//            break;
//        case kIDCardInvalidAPPID:
//        {
//            [KeyWindow displayMessage:@"绑定包名错误"];
//        }
//            break;
//        case kIDCardAuthExpire:
//        {
//            [KeyWindow displayMessage:@"授权文件过期"];
//        }
//            break;
//        default:
//            break;
//    }
//}
//- (UIActivityIndicatorView *)activityIndicatorView{
//    if (!_activityIndicatorView) {
//        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//        _activityIndicatorView.center = self.view.center;
//        [_activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    }
//    return _activityIndicatorView;
//}
//- (void)isUploading:(BOOL)loadingStatus{
//    if (loadingStatus) {
//        [_activityIndicatorView startAnimating];
//    }else{
//        [_activityIndicatorView stopAnimating];
//    }
//    
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end
