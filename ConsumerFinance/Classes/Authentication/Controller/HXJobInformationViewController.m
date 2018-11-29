////
////  HXJobInformationViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/12.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXJobInformationViewController.h"
//#import "HXSelectTableView.h"
//#import "AddressPickView.h"
//#import "HXJobPhotoViewController.h"
//#import "HXJobInforModel.h"
//#import "HXJobViewModel.h"
//#import "FileManager.h"
//#import "MHDatePicker.h"
//#define cellTag 500
//@interface HXJobInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,jobPhotoDelegate>
//{
//    UITableView * _tableView;
//    MHDatePicker *_pikerView;
//}
//@property (nonatomic,strong)HXJobInforModel * jobModel;
//@property (nonatomic,strong)BaseTableViewCell * natureCell; //公司性质
//@property (nonatomic,strong)BaseTableViewCell * addressCell; //地址
//@property (nonatomic,strong)BaseTableViewCell * unitCell ;//就职单位cell
//@property (nonatomic,strong)BaseTableViewCell * commenCell;// 常用地址cell
//@property (nonatomic,strong)BaseTableViewCell * iphoneCell ;//单位电话cell
//@property (nonatomic,strong)BaseTableViewCell * reventCell; //月收入cell
//@property (nonatomic,strong)BaseTableViewCell * entryTimeCell;//入职时间
//@property (nonatomic,strong)HDTextField * areaText;
//@property (nonatomic,strong)HDTextField * iphoneText;
//@property (nonatomic,strong) UIButton * referButton;
//
//@property (nonatomic,strong)HXJobViewModel * viewModel;
//
//@end
//
//@implementation HXJobInformationViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXJobViewModel alloc] initWithController:self];
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
//-(void)request {
//    [self.viewModel archiveJobInformationWithReturnBlock:^{
//        if (self.viewModel.model) {
//            self.jobModel.nature = [self.viewModel natureWithTag:self.viewModel.model.type];
//            self.jobModel.provinceModel  = [[FileManager manager] getProvinceModel:self.viewModel.model.provinceId];
//            self.jobModel.cityModel = [[FileManager manager] getCityModel:self.viewModel.model.cityId];
//            if (self.jobModel.provinceModel.areaName.length !=0 ||self.jobModel.cityModel.areaName.length!=0) {
//                self.jobModel.address = [NSString stringWithFormat:@"%@ %@",self.jobModel.provinceModel.areaName?self.jobModel.provinceModel .areaName:@"",self.jobModel.cityModel.areaName?self.jobModel.cityModel.areaName:@""] ;
//            }
//            self.jobModel.unitStr = self.viewModel.model.name ?self.viewModel.model.name:@"";
//            self.jobModel.entryTime = self.viewModel.model.entryTime?self.viewModel.model.entryTime:@"";
//            NSArray *iphoneArr = [self.viewModel.model.telephone componentsSeparatedByString:@"-"];
//            if (iphoneArr.count>1) {
//                self.jobModel.iphoneNumber = [iphoneArr lastObject]?[iphoneArr lastObject]:@"";
//                self.jobModel.areaNumber = [iphoneArr firstObject]?[iphoneArr firstObject]:@"";
//            }
//            self.jobModel.revenue = self.viewModel.model.monthlySalary?self.viewModel.model.monthlySalary:@"";
//            self.jobModel.unitcommenAddress = self.viewModel.model.address?self.viewModel.model.address:@"";
//            [self changeButtonStates];
//        }
//        [_tableView reloadData];
//        
//    }];
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"工作信息";
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
//    self.referButton = referButton;
//    referButton.enabled = NO;
//    [referButton setTitle:@"保存" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [footView addSubview:referButton];
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 8;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    static NSString *cellIdentity1 = @"IdentityInfoCell1";
//    static NSString *cellIdentity2 = @"IdentityInfoCell2";
//    if (indexPath.row==0||indexPath.row==1||indexPath.row==5||indexPath.row==7) {
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//            if (indexPath.row==0) {
//                cell.nameLabel.text = @"姓名";
//            }else if (indexPath.row==1) {
//                cell.nameLabel.text = @"工作单位";
//                self.unitCell = cell;
//                cell.writeTextfield.placeholder = @"输入就职单位";
//            }else if (indexPath.row==5) {
//                cell.nameLabel.text = @"详细地址";
//                self.commenCell = cell;
//                cell.writeTextfield.placeholder = @"请输入单位详细地址";
//            }else if(indexPath.row==6){
//                
//                
//            }else {
//                cell.nameLabel.text = @"月收入";
//                self.reventCell = cell;
//                cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
//                cell.writeTextfield.placeholder = @"请输入月收入";
//            }
//            [cell creatLine:15 hidden:NO];
//            cell.writeTextfield.delegate =self;
//            [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//            cell.writeTextfield.textColor = kUIColorFromRGB(0x666666);
//        }
//        cell.writeTextfield.enabled = YES;
//        if (indexPath.row==0) {
//            cell.writeTextfield.enabled = NO;
//            cell.writeTextfield.text = self.viewModel.realName.length?self.viewModel.realName:@"";
//        }else if(indexPath.row==1){
//            cell.writeTextfield.text = self.jobModel.unitStr.length ?self.jobModel.unitStr:@"";
//        }else if(indexPath.row==5){
//            cell.writeTextfield.text = self.jobModel.unitcommenAddress.length? self.jobModel.unitcommenAddress:@"";
//        }else if(indexPath.row==6){
//            cell.writeTextfield.text = self.jobModel.iphoneNumber.length?self.jobModel.iphoneNumber:@"";
//        }else if(indexPath.row==7){
//            cell.writeTextfield.text = self.jobModel.revenue.length ?self.jobModel.revenue:@"";
//        }
//        cell.writeTextfield.tag = indexPath.row+1;
//        cell.writeTextfield.textColor = ComonTitleColor;
//        return cell;
//    }else if (indexPath.row==6){
//        
//        
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity2];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity2];
//            cell.nameLabel.text = @"单位电话";
//            self.iphoneCell = cell;
//            [cell creatLine:15 hidden:NO];
//            //            cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
//            //                cell.writeTextfield.placeholder = @"区号-电话";
//            //                cell.writeTextfield.tag = indexPath.row;
//            HDTextField * iphoneText = [[HDTextField alloc] init];
//            self.iphoneText = iphoneText;
//            iphoneText.placeholder = @"电话";
//            iphoneText.keyboardType = UIKeyboardTypeNumberPad;
//            iphoneText.tag = indexPath.row+100;
//            iphoneText.textColor = ComonTitleColor;
//            [iphoneText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//            iphoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
//            iphoneText.textAlignment = NSTextAlignmentRight;
//            iphoneText.font = [UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:iphoneText];
//            [iphoneText  mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.and.bottom.equalTo(cell.contentView);
//                make.right.equalTo(cell.contentView.mas_right).offset(-15);
//                make.width.mas_equalTo(90);
//            }];
//            
//            UIView * hxView = [[UIView alloc] init];
//            hxView.backgroundColor = HXRGB(221, 221, 221);
//            [cell.contentView addSubview:hxView];
//            [hxView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(cell.contentView);
//                make.right.mas_equalTo(cell.contentView).offset(-106);
//                make.height.mas_equalTo(35);
//                make.width.mas_equalTo(0.5);
//            }];
//            
//            HDTextField * areaText = [[HDTextField alloc] init];
//            self.areaText = areaText;
//            [areaText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//            areaText.placeholder = @"区号";
//            areaText.keyboardType = UIKeyboardTypeNumberPad;
//            areaText.tag = indexPath.row+101;
//            areaText.textColor = ComonTitleColor;
//            areaText.clearButtonMode = UITextFieldViewModeWhileEditing;
//            areaText.textAlignment = NSTextAlignmentRight;
//            areaText.font = [UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:areaText];
//            [areaText  mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.and.bottom.equalTo(cell.contentView);
//                make.right.equalTo(hxView.mas_left).offset(-10);
//                make.width.mas_equalTo(80);
//            }];
//        }
//        self.iphoneText.text = self.jobModel.iphoneNumber.length?self.jobModel.iphoneNumber:@"";
//        self.areaText.text = self.jobModel.areaNumber.length?self.jobModel.areaNumber:@"";
//        return cell;
//    }
//    else {
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
//            [cell creatLine:15 hidden:NO];
//            [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView);
//            }];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        if (indexPath.row==2) {
//            cell.nameLabel.text = @"公司性质";
//            cell.titleLabel.text = self.jobModel.nature.length?self.jobModel.nature: @"请选择";
//            cell.titleLabel.textColor = self.jobModel.nature.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            _natureCell = cell;
//        }else if(indexPath.row == 3) {
//            cell.nameLabel.text = @"入职时间";
//            cell.titleLabel.text = self.jobModel.entryTime.length?self.jobModel.entryTime: @"请选择";
//            cell.titleLabel.textColor = self.jobModel.entryTime.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            _entryTimeCell = cell;
//            
//        }else if (indexPath.row == 4) {
//            cell.nameLabel.text = @"单位地址";
//            cell.titleLabel.text = self.jobModel.address.length?self.jobModel.address: @"选择城市";
//            cell.titleLabel.textColor = self.jobModel.address.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            _addressCell = cell;
//        }else {
//            cell.nameLabel.text = @"工作证明";
//            cell.titleLabel.text = self.viewModel.companyImgArr.count>0?@"已上传":@"上传";
//            cell.titleLabel.textColor = self.viewModel.companyImgArr.count>0?kUIColorFromRGB(0x666666): ComonCharColor;
//            [cell creatLine:15 hidden:YES];
//        }
//        return cell;
//        
//        
//    }
//    
//    
//    
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
//    [self.view endEditing:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    switch (indexPath.row) {
//        case 2:
//        {
//            [[HXSelectTableView shareSheet] hx_selectTableWithSelectArray:@[@"政府机关",@"事业单位",@"国企",@"外企",@"合资",@"民营",@"私企",@"个体"] title:@"选择公司性质" select:^(NSString * name){
//                _natureCell.titleLabel.text = name;
//                _jobModel.nature = name;
//                _natureCell.titleLabel.textColor = kUIColorFromRGB(0x666666);
//                [self changeButtonStates];
//            }];
//        }
//            break;
//        case 3:
//        {
//            //入职时间
//            _pikerView = [[MHDatePicker alloc] init];
//            _pikerView.datePickerMode = UIDatePickerModeDate;
//            __weak HXJobInformationViewController * weakSelf = self;
//            [_pikerView didFinishSelectedDate:^(NSString *selectedDate) {
//                
//                weakSelf.entryTimeCell.titleLabel.text = selectedDate;
//                weakSelf.jobModel.entryTime = selectedDate;
//                weakSelf.entryTimeCell.titleLabel.textColor = kUIColorFromRGB(0x666666);
//                [weakSelf changeButtonStates];
//            }];
//            
//            
//            [self.view addSubview:_pikerView];
//            
//        }
//            break;
//        case 4:
//        {
//            //单位地址
//            AddressPickView *addressPickView = [AddressPickView shareInstance];
//            [self.view addSubview:addressPickView];
//            addressPickView.block = ^(AddressModel *provinceModel, AddressModel *cityModel){
//                self.addressCell.titleLabel.text = [NSString stringWithFormat:@"%@ %@",provinceModel.areaName,cityModel.areaName] ;
//                self.jobModel.provinceModel = provinceModel;
//                self.jobModel.cityModel = cityModel;
//                //                self.provinceId = provinceModel.areaCode;
//                //                self.cityId = cityModel.areaCode;
//                if (provinceModel.areaName.length !=0 ||cityModel.areaName.length!=0) {
//                    
//                    _jobModel.address = [NSString stringWithFormat:@"%@ %@",provinceModel.areaName,cityModel.areaName] ;
//                    self.addressCell.titleLabel.textColor = kUIColorFromRGB(0x666666);
//                }
//                [self changeButtonStates];
//            };
//            
//        }
//            break;
//        case 8: {
//            HXJobPhotoViewController * jopPhoto = [[HXJobPhotoViewController alloc] init];
//            jopPhoto.work = YES;
//            jopPhoto.viewModel.catory = CertificateWork;
//            jopPhoto.delegate = self;
//            [self.navigationController pushViewController:jopPhoto animated:YES];
//        }
//            break;
//            
//        default:
//            break;
//    }
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
//    if ([textField isEqual:self.unitCell.writeTextfield]) {
//        if(textField.text.length > 20) {
//            textField.text = [textField.text substringToIndex:20];
//        }
//        self.jobModel.unitStr = textField.text;
//    }else if ([textField isEqual:self.commenCell.writeTextfield]) {
//        if(textField.text.length > 30) {
//            textField.text = [textField.text substringToIndex:30];
//        }
//        self.jobModel.unitcommenAddress = textField.text;
//    }else if ([textField isEqual:self.reventCell.writeTextfield]) {
//        self.jobModel.revenue = textField.text;
//    }else if ([textField isEqual:self.iphoneText]) {
//        if(textField.text.length > 8) {
//            textField.text = [textField.text substringToIndex:8];
//        }
//        self.jobModel.iphoneNumber = textField.text;
//    }else if ([textField isEqual:self.areaText]) {
//        if(textField.text.length > 4) {
//            textField.text = [textField.text substringToIndex:4];
//        }
//        self.jobModel.areaNumber = textField.text;
//    }else {
//        
//    }
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
//            allowedLength = 20;
//            
//        }
//            break;
//        case 6: {
//            allowedLength = 30;
//        }
//            break;
//        case 7: {
//            allowedLength = 13;
//            astring       = LIMIT_NUMBERS;
//            if (textField.text.length==4&&string.length!=0) {
//                
//                textField.text = [NSString stringWithFormat:@"%@-", textField.text];
//            }
//            
//        }
//            break;
//        case 8: {
//            allowedLength = 8;
//            astring       = LIMIT_NUMBERS;
//        }
//            break;
//        case 106: {
//            allowedLength = 8;
//            astring       = LIMIT_NUMBERS;
//        }
//            break;
//        case 107: {
//            allowedLength = 4;
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
//#pragma mark -- 提交
//-(void)registerAction {
//    [self.view endEditing:YES];
//    if (self.jobModel.unitStr.length==0) {
//        [KeyWindow displayMessage:@"请输入就职单位"];
//        return;
//    }
//    if (self.jobModel.unitStr.length==0) {
//        [KeyWindow displayMessage:@"请输入就职单位"];
//        return;
//    }
//    if (self.jobModel.nature.length==0) {
//        [KeyWindow displayMessage:@"请选择公司性质"];
//        return;
//    }
//    if (self.jobModel.address.length==0) {
//        [KeyWindow displayMessage:@"请选择单位地址"];
//        return;
//    }
//    if (self.jobModel.unitcommenAddress.length==0) {
//        [KeyWindow displayMessage:@"请输入详细地址"];
//        return;
//    }
//    if (self.jobModel.iphoneNumber.length==0) {
//        [KeyWindow displayMessage:@"请输入单位电话"];
//        return;
//    }
//    if (self.jobModel.revenue.length==0) {
//        [KeyWindow displayMessage:@"请输入月收入"];
//        return;
//    }
//    if (self.jobModel.entryTime.length==0) {
//        [KeyWindow displayMessage:@"请选择入职时间"];
//        return;
//    }
//    if (self.jobModel.areaNumber.length<3) {
//        [KeyWindow displayMessage:@"请输入正确的区号"];
//        return;
//    }
//    if (self.jobModel.iphoneNumber.length<7) {
//        [KeyWindow displayMessage:@"请输入正确的电话号码"];
//        return;
//    }
//    
//    
//    BOOL telBool =  [Helper validateCellPhoneNumber:[NSString stringWithFormat:@"%@%@",self.jobModel.areaNumber,self.jobModel.iphoneNumber]];
//    if (!telBool) {
//        [KeyWindow displayMessage:@"请输入正确的固定电话号码"];
//        return;
//    }
//    
//    [self.viewModel submitJobInformationWithJobModel:self.jobModel photoArr:nil returnBlock:^{
//        [KeyWindow displayMessage:@"认证成功"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Authentication object:nil userInfo:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//    
//    
//}
//#pragma mark -- 判断按钮状态
//-(void)changeButtonStates {
//    if (self.jobModel.unitStr.length!=0&&self.jobModel.unitcommenAddress.length!=0&&self.jobModel.nature.length!=0&&self.jobModel.address.length!=0&&self.jobModel.iphoneNumber.length!=0&&self.jobModel.revenue.length!=0&&self.jobModel.areaNumber.length!=0&&self.jobModel.entryTime.length!=0) {
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
//#pragma mark -- jobPhotoDelegate
//-(void)archivePhoto:(NSMutableArray *)photoArr {
//    NSMutableArray * arr = [[NSMutableArray alloc] init];
//    [arr addObjectsFromArray:photoArr];
//    self.viewModel.companyImgArr = arr;
//    [_tableView reloadData];
//    [self changeButtonStates];
//}
//#pragma mark -- setter and getter
//-(HXJobInforModel *)jobModel {
//    if (_jobModel == nil) {
//        _jobModel = [[HXJobInforModel alloc] init];
//    }
//    return _jobModel;
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//@end
