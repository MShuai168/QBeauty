////
////  PersonalInformationViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/11.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "PersonalInformationViewController.h"
//#import "PersonalInformationCell.h"
//#import "HXSheet.h"
//#import "HXRelationView.h"
//#import "HXSelectTableView.h"
//#import "AddressPickView.h"
//#import "AddressBookManager.h"
//#import "HXPersonalInformationViewModel.h"
//#import "FileManager.h"
//#define selectTag 500
//#define cellTag 100
//@interface PersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong) BaseTableViewCell * certificationCell; //身份cell
//@property (nonatomic,strong) BaseTableViewCell * educationCell ; //教育cell
//@property (nonatomic,strong) BaseTableViewCell * marriageCell; //婚姻cell
//@property (nonatomic,strong) BaseTableViewCell * addressCell; //地址
//@property (nonatomic,strong) BaseTableViewCell * nameCell; //名字Cell
//@property (nonatomic,strong) BaseTableViewCell * commenAddressCell; //常驻地Cell
//@property (nonatomic,strong) NSMutableDictionary * telInformationDic;
//@property (nonatomic,strong) HXRelationView * relationView; //联系人关系
//@property (nonatomic,strong) HXRelationView * relationView1; //联系人关系1
//@property (nonatomic,strong) HXRelationView * relationView2; //联系人关系2
//@property (nonatomic,strong) UIButton * referButton;
//@property (nonatomic,strong) BaseTableViewCell * commenCell; //常用地址
//
//@property (nonatomic,strong)HXPersonalInformationViewModel * viewModel;
//@end
//
//@implementation PersonalInformationViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXPersonalInformationViewModel alloc] initWithController:self];
//        [self.viewModel identityStates:@""];
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    /**
//     *  原先联系人信息 ContactInfoViewController
//     */
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
//    [self request];
//    /**
//     *  获取全部通讯录 访问权限
//     */
////    [[AddressBookManager manager] readAddressBookContent:^(BOOL completed) {
////        if (!completed) {
////        }else {
////            //获取全部通讯录
//////                                    [[AddressBookManager manager] getAddressBookContent:^(NSDictionary *addressBook) {
//////            
//////                                    }];
////        }
////        
////    }];
//    
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"个人信息";
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
//    [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [footView addSubview:referButton];
//    
//}
//#pragma mark -- request
//-(void)request {
//    [_viewModel archiveinformationWithReturnBlock:^{
//        
//        [self changeButtonStates];
//        [_tableView reloadData];
//    }];
//}
//
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2+self.viewModel.identityArr.count;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
//        return 6;
//    }else {
//        return 3;
//    }
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    static NSString *cellIdentity1 = @"IdentityInfoCell1";
//    static NSString *cellIdentity2 = @"IdentityInfoCell2";
//    static NSString *cellIdentity3 = @"IdentityInfoCell3";
//    if ((indexPath.section == 0 && (indexPath.row==0 ||indexPath.row==5))) {
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//            cell.writeTextfield.delegate = self;
//            cell.writeTextfield.tag = indexPath.row +1;
//            [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//            if (indexPath.row==0) {
//                cell.nameLabel.text = @"姓名";
//                [cell creatLine:15 hidden:NO];
//            }else {
//                cell.nameLabel.text = @"详细地址";
//                cell.writeTextfield.placeholder = @"请输入详细地址";
//                self.commenCell = cell;
//            }
//        }
//        if (indexPath.row==0) {
//            cell.writeTextfield.text = self.viewModel.personalModel.name ? self.viewModel.personalModel.name :@"";
//            self.nameCell = cell;
//            cell.writeTextfield.enabled = NO;
//        }else {
//            cell.writeTextfield.text = self.viewModel.personalModel.commenAddress ? self.viewModel.personalModel.commenAddress :@"";
//            self.commenAddressCell = cell;
//            cell.writeTextfield.enabled = YES;
//        }
//        cell.tag = indexPath.section*cellTag +indexPath.row +cellTag;
//        return cell;
//        
//    }else if(((indexPath.section == 1 || indexPath.section==2 || indexPath.section==3) && indexPath.row==0)) {
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
//            [cell creatLine:15 hidden:NO];
//            cell.nameLabel.text = @"关系";
//            NSArray * nameArr;
//            if (indexPath.section == 1) {
//                nameArr= @[@"兄妹",@"子女",@"配偶",@"母亲",@"父亲"];
//            }else {
//            nameArr= @[[self.viewModel.identityArr objectAtIndex:indexPath.section-2]];
//            }
//           
//            HXRelationView * relationView = [[HXRelationView alloc] initWithNameArray:nameArr view:cell.contentView];
//            if (indexPath.section==1) {
//                self.relationView = relationView;
//            }else if(indexPath.section==2){
//                self.relationView1 = relationView;
//            }else {
//                self.relationView2 = relationView;
//            }
//        }
//        if (indexPath.section==1) {
//            __block typeof(self) weakSelf = self;
//            self.relationView.select = ^(NSString * name){
//                weakSelf.viewModel.personalModel.firstSelctName = name;
//            };
//            [self.relationView screeButton:self.viewModel.personalModel.firstSelctName?self.viewModel.personalModel.firstSelctName: @"父亲"];
//        }else if(indexPath.section==2){
//            [self.relationView1 screeButton:[self.viewModel.identityArr objectAtIndex:indexPath.section-2]];
//            [self.relationView1 updateButtonName:[self.viewModel.identityArr objectAtIndex:indexPath.section-2]];
//        }else {
//            [self.relationView2 screeButton:[self.viewModel.identityArr objectAtIndex:indexPath.section-2]];
//            [self.relationView2 updateButtonName:[self.viewModel.identityArr objectAtIndex:indexPath.section-2]];
//        }
//        cell.tag = indexPath.section*cellTag +indexPath.row +cellTag;
//        return cell;
//    }else if(((indexPath.section == 1 || indexPath.section==2 || indexPath.section==3) && indexPath.row==2)){
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity2];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity2];
//            cell.nameLabel.text = @"姓名";
//            cell.writeTextfield.delegate = self;
//            cell.writeTextfield.tag = indexPath.row +1+indexPath.section*10;
//            [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        }
//        if (indexPath.section==1) {
//            cell.writeTextfield.text = self.viewModel.personalModel.firstName.length?self.viewModel.personalModel.firstName :@"";
//            cell.writeTextfield.textColor = self.viewModel.personalModel.firstName.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            cell.writeTextfield.placeholder = @"联系人姓名";
//        }else if (indexPath.section==2) {
//            cell.writeTextfield.text = self.viewModel.personalModel.secondName.length ?self.viewModel.personalModel.secondName :@"";
//            cell.writeTextfield.textColor = self.viewModel.personalModel.secondName.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            cell.writeTextfield.placeholder = @"联系人姓名";
//        }else  {
//            cell.writeTextfield.text = self.viewModel.personalModel.thirdName.length ?self.viewModel.personalModel.thirdName :@"";
//            cell.writeTextfield.textColor = self.viewModel.personalModel.thirdName.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            cell.writeTextfield.placeholder = @"联系人姓名";
//        }
//        cell.tag = indexPath.section*cellTag +indexPath.row +cellTag;
//        return cell;
//        
//    }else {
//        
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity3];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity3];
//            [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView);
//            }];
//            [cell creatLine:15 hidden:NO];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        if (indexPath.section==0) {
//            NSArray * array = @[@"身份",@"学历",@"婚姻状况",@"居住地省市"];
//            cell.nameLabel.text = [array objectAtIndex:indexPath.row-1];
//            if (indexPath.row==1) {
//                _certificationCell = cell;
//                cell.titleLabel.text = self.viewModel.personalModel.certificationStr.length ? self.viewModel.personalModel.certificationStr :@"请选择";
//                cell.titleLabel.textColor = self.viewModel.personalModel.certificationStr.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            }else if (indexPath.row==2) {
//                _educationCell = cell;
//                cell.titleLabel.text = self.viewModel.personalModel.educationStr.length ? self.viewModel.personalModel.educationStr :@"请选择";
//                cell.titleLabel.textColor = self.viewModel.personalModel.educationStr.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            }else if (indexPath.row==3) {
//                _marriageCell  = cell;
//                cell.titleLabel.text = self.viewModel.personalModel.marriageStr.length ? self.viewModel.personalModel.marriageStr :@"请选择";
//                cell.titleLabel.textColor = self.viewModel.personalModel.marriageStr.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            }else {
//                _addressCell = cell;
//                cell.titleLabel.text = self.viewModel.personalModel.addressStr.length ? self.viewModel.personalModel.addressStr :@"请选择";
//                cell.titleLabel.textColor = self.viewModel.personalModel.addressStr.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            }
//        }else {
//            cell.nameLabel.text = @"手机号";
//            if (indexPath.section==1) {
//                cell.titleLabel.text = self.viewModel.personalModel.firstNumber.length?self.viewModel.personalModel.firstNumber :@"联系人手机号";
//                cell.titleLabel.textColor = self.viewModel.personalModel.firstNumber.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            }else if (indexPath.section==2) {
//               cell.titleLabel.text = self.viewModel.personalModel.secondNumber.length ?self.viewModel.personalModel.secondNumber :@"联系人手机号";
//                cell.titleLabel.textColor = self.viewModel.personalModel.secondNumber.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            }else  {
//                cell.titleLabel.text = self.viewModel.personalModel.thirdNumber.length ?self.viewModel.personalModel.thirdNumber :@"联系人手机号";
//                cell.titleLabel.textColor = self.viewModel.personalModel.thirdNumber.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            }
//        }
//        cell.tag = indexPath.section*cellTag +indexPath.row +cellTag;
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
//    if (section ==0 ) {
//        
//        return 10;
//    }
//    return 38;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section != 0) {
//        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
//        view.backgroundColor = COLOR_BACKGROUND;
//        
//        
//        UILabel * nameLabel = [[UILabel alloc] init];
//        nameLabel.font = [UIFont systemFontOfSize:13];
//        nameLabel.textColor = ComonCharColor;
//        [view addSubview:nameLabel];
//        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view).offset(15);
//            make.center.equalTo(view);
//        }];
//        if (section == 1) {
//           nameLabel.text = @"联系人1";
//        }else if (section == 2){
//            nameLabel.text = @"联系人2";
//        }else {
//            nameLabel.text = @"联系人3";
//        }
//        return view;
//        
//    }
//    return nil;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    switch (indexPath.section) {
//        case 0:
//        {
//            if (indexPath.row==1) {
//                [self.view endEditing:YES];
//                [[HXSelectTableView shareSheet] hx_selectTableWithSelectArray:@[@"上班族",@"学生党",@"企业主",@"自由职业者"] title:@"选择身份" select:^(NSString * name){
//                    if (![_certificationCell.titleLabel.text isEqualToString:name]) {
//                        self.viewModel.personalModel.secondName = @"";
//                        self.viewModel.personalModel.secondNumber = @"";
//                        self.viewModel.personalModel.thirdName = @"";
//                        self.viewModel.personalModel.thirdNumber = @"";
//                    }
//                    _certificationCell.titleLabel.text = name;
//                    self.viewModel.personalModel.certificationStr = name;
//                    _certificationCell.titleLabel.textColor = name?kUIColorFromRGB(0x666666): ComonCharColor;
//                    [self.viewModel identityStates:[self.viewModel identityWithName:name]];
//                    self.viewModel.personalModel.firstNumber = @"";
//                    self.viewModel.personalModel.firstName = @"";
//                    self.viewModel.personalModel.firstSelctName = @"父亲";
//                    [_tableView reloadData];
//                    [self changeButtonStates];
//                }];
//            }else if(indexPath.row==2) {
//                [self.view endEditing:YES];
//                [[HXSelectTableView shareSheet] hx_selectTableWithSelectArray:@[@"研究生及以上",@"本科",@"大专",@"大专以下"] title:@"选择学历" select:^(NSString * name){
//                    _educationCell.titleLabel.text = name;
//                    self.viewModel.personalModel.educationStr = name;
//                    _educationCell.titleLabel.textColor = name?kUIColorFromRGB(0x666666): ComonCharColor;
//                    [self changeButtonStates];
//                }];
//            }else if(indexPath.row==3) {
//                [self.view endEditing:YES];
//                [[HXSelectTableView shareSheet] hx_selectTableWithSelectArray:@[@"已婚",@"未婚",@"离异",@"丧偶"] title:@"选择婚姻状况" select:^(NSString * name){
//                    _marriageCell.titleLabel.text = name;
//                    self.viewModel.personalModel.marriageStr = name;
//                    _marriageCell.titleLabel.textColor = name?kUIColorFromRGB(0x666666): ComonCharColor;
//                    [self changeButtonStates];
//                }];
//                
//            }else if(indexPath.row==4) {
//                [self.view endEditing:YES];
//                //单位地址
//                AddressPickView *addressPickView = [AddressPickView shareInstance];
//                [self.view addSubview:addressPickView];
//                addressPickView.block = ^(AddressModel *provinceModel, AddressModel *cityModel){
//                    self.viewModel.personalModel.provinceModel = provinceModel;
//                    self.viewModel.personalModel.cityModel = cityModel;
//                    if (self.viewModel.personalModel.provinceModel.areaName.length !=0 ||self.viewModel.personalModel.cityModel.areaName.length!=0) {
//                        
//                        _addressCell.titleLabel.text = [NSString stringWithFormat:@"%@ %@",provinceModel.areaName,cityModel.areaName] ;
//                        self.viewModel.personalModel.addressStr = [NSString stringWithFormat:@"%@ %@",provinceModel.areaName,cityModel.areaName] ;
//                        _addressCell.titleLabel.textColor = self.viewModel.personalModel.addressStr?kUIColorFromRGB(0x666666): ComonCharColor;
//                    }
//                    [self changeButtonStates];
//                };
//                
//            }else {
//                
//            }
//        }
//            break;
//        case 1:
//        {
//            if (indexPath.row==1) {
//                [self.view endEditing:YES];
//                [[AddressBookManager manager] readAddressBookContent:^(BOOL completed) {
//                    if (!completed) {
//                        
//                    }else {
//                        [self reloadContactTableView:indexPath];
//                    }
//                    
//                }];
//                
//            }
//            
//        }
//            break;
//        case 2:
//        {
//            if (indexPath.row==1) {
//                [self.view endEditing:YES];
//                [[AddressBookManager manager] readAddressBookContent:^(BOOL completed) {
//                    if (!completed) {
//                        
//                    }else {
//                        [self reloadContactTableView:indexPath];
//                    }
//                    
//                }];
//            }
//            
//        }
//            break;
//        case 3:
//        {
//            if (indexPath.row==1) {
//                [self.view endEditing:YES];
//                [[AddressBookManager manager] readAddressBookContent:^(BOOL completed) {
//                    if (!completed) {
//                        
//                    }else {
//                     [self reloadContactTableView:indexPath];
//                    }
//                    
//                }];
//
//            }
//            
//        }
//            break;
//        case 4:
//        {
//            
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//
//}
//
//- (void)reloadContactTableView:(NSIndexPath *)indexPath{
//    BaseTableViewCell * numberCell = (BaseTableViewCell *)[_tableView viewWithTag:indexPath.row+indexPath.section*cellTag+cellTag];
//    BaseTableViewCell * nameCell = (BaseTableViewCell *)[_tableView viewWithTag:indexPath.row+indexPath.section*cellTag+cellTag+1];
//    [[AddressBookManager manager] prepareABPeoplePicker:self contactBlock:^(BOOL canceled, NSString *tel, NSString *name) {
//        if (!canceled) {
//            if (tel.length==0 || name.length==0) {
//                [KeyWindow displayMessage:@"联系人信息有误请重新添加"];
//                return ;
//            }
////            if (![tel isValidMobileNumber]) {
////                [KeyWindow displayMessage:@"联系人手机号错误 请重新选择"];
////                return;
////            }
////            tel = [[tel componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""]; 
//            if (indexPath.section==1) {
//                if ([tel isEqualToString:self.viewModel.personalModel.thirdNumber]||[tel isEqualToString:self.viewModel.personalModel.secondNumber]) {
//                    [KeyWindow displayMessage:@"当前电话号码已存在请重新选择"];
//                    return;
//                }
//            }else if (indexPath.section==2){
//                if ([tel isEqualToString:self.viewModel.personalModel.thirdNumber]||[tel isEqualToString:self.viewModel.personalModel.firstNumber]) {
//                    [KeyWindow displayMessage:@"当前电话号码已存在请重新选择"];
//                    return;
//                }
//            }else {
//                if ([tel isEqualToString:self.viewModel.personalModel.secondNumber]||[tel isEqualToString:self.viewModel.personalModel.firstNumber]) {
//                    [KeyWindow displayMessage:@"当前电话号码已存在请重新选择"];
//                    return;
//                }
//                
//            }
//            
//            numberCell.titleLabel.text  = tel;
//            nameCell.writeTextfield.text = name;
//            numberCell.titleLabel.textColor = tel.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            nameCell.writeTextfield.textColor = name.length?kUIColorFromRGB(0x666666): ComonCharColor;
//            if (indexPath.section==1) {
//                self.viewModel.personalModel.firstNumber = tel;
//                self.viewModel.personalModel.firstName = name;
//            }else if (indexPath.section==2) {
//                self.viewModel.personalModel.secondNumber = tel;
//                self.viewModel.personalModel.secondName = name;
//            }else {
//                self.viewModel.personalModel.thirdNumber = tel;
//                self.viewModel.personalModel.thirdName  = name;
//            }
//            [self changeButtonStates];
//        }
//    }];
//    
//}
//#pragma mark-textField代理
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    //    [textField keyBoardEvent];
//}
//-(void)textFieldDidChange:(UITextField *)textField
//{
//    if ([self.commenCell.writeTextfield isEqual:textField]) {
//        if(textField.text.length > 30) {
//            textField.text = [textField.text substringToIndex:30];
//        }
//        self.viewModel.personalModel.commenAddress = textField.text;
//    }
//    if (textField.tag == 13) {
//        if(textField.text.length > 15) {
//            textField.text = [textField.text substringToIndex:15];
//        }
//        self.viewModel.personalModel.firstName = textField.text;
//    }
//    if (textField.tag ==23){
//        if(textField.text.length > 15) {
//            textField.text = [textField.text substringToIndex:15];
//        }
//        self.viewModel.personalModel.secondName = textField.text;
//    }
//    if (textField.tag ==33){
//        if(textField.text.length > 15) {
//            textField.text = [textField.text substringToIndex:15];
//        }
//        self.viewModel.personalModel.thirdName = textField.text;
//    }
//
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
//        case 6: {
//            
//        }
//            break;
//        case 2: {
//            allowedLength = 16;
//        }
//            break;
//        case 13: {
//            
//        }
//            break;
//        case 23: {
//            
//        }
//            break;
//        case 33: {
//            
//        }
//            break;
//
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
//#pragma mark --提交
//-(void)registerAction {
//    if (self.viewModel.personalModel.certificationStr.length==0) {
//        [KeyWindow displayMessage:@"请选择身份信息"];
//        return;
//    }
//    if (self.viewModel.personalModel.educationStr.length==0) {
//        [KeyWindow displayMessage:@"请选择学历信息"];
//        return;
//    }
//    if (self.viewModel.personalModel.marriageStr.length==0) {
//        [KeyWindow displayMessage:@"请选择婚姻状况"];
//        return;
//    }
//    if (self.viewModel.personalModel.addressStr.length==0) {
//        [KeyWindow displayMessage:@"请选择居住地址"];
//        return;
//    }
//    if (self.viewModel.personalModel.commenAddress.length==0) {
//        [KeyWindow displayMessage:@"请填写详细地址"];
//        return;
//    }
//    if (self.viewModel.personalModel.firstNumber.length == 0) {
//        [KeyWindow displayMessage:@"请选择联系人1"];
//        return;
//    }
//    if (self.viewModel.personalModel.firstName.length == 0) {
//        [KeyWindow displayMessage:@"请重新选择联系人1"];
//        return;
//    }
//    if (self.viewModel.personalModel.secondNumber.length == 0) {
//        [KeyWindow displayMessage:@"请选择联系人2"];
//        return;
//    }
//    if (self.viewModel.personalModel.secondName.length == 0) {
//        [KeyWindow displayMessage:@"请重新选择联系人2"];
//        return;
//    }
//     if ([self.viewModel.personalModel.certificationStr isEqualToString:@"企业主"]||[self.viewModel.personalModel.certificationStr isEqualToString:@"上班族"]) {
//    if (self.viewModel.personalModel.thirdNumber.length == 0) {
//        [KeyWindow displayMessage:@"请选择联系人3"];
//        return;
//    }
//    if (self.viewModel.personalModel.thirdName.length == 0) {
//        [KeyWindow displayMessage:@"请重新选择联系人3"];
//        return;
//    }
//     }
//    [_viewModel postToServer];
//    [_viewModel submitPersonInformationWithReturnBlock:^{
//        [KeyWindow displayMessage:@"认证成功"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Authentication object:nil userInfo:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//}
//#pragma mark -- 判断按钮状态
//-(void)changeButtonStates {
//    BOOL thireBool = NO;
//    if ([self.viewModel.personalModel.certificationStr isEqualToString:@"企业主"]||[self.viewModel.personalModel.certificationStr isEqualToString:@"上班族"]) {
//        if (self.viewModel.personalModel.thirdNumber.length!=0 && self.viewModel.personalModel.thirdName!=0) {
//            thireBool = YES;
//        }
//    }else {
//        thireBool = YES;
//    }
//    
//    if (self.viewModel.personalModel.certificationStr.length!=0&&self.viewModel.personalModel.educationStr.length!=0&&self.viewModel.personalModel.marriageStr!=0&&self.viewModel.personalModel.commenAddress.length!=0&&self.viewModel.personalModel.addressStr.length!=0&&self.viewModel.personalModel.firstName.length!=0&&self.viewModel.personalModel.firstNumber.length !=0&&self.viewModel.personalModel.secondName.length!=0&&self.viewModel.personalModel.secondName.length !=0&&thireBool) {
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
//
//
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
