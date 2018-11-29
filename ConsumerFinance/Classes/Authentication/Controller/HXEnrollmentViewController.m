////
////  HXEnrollmentViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/18.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXEnrollmentViewController.h"
//#import "HXSelectTableView.h"
//#import "AddressPickView.h"
//#import "HXJobPhotoViewController.h"
//#import "HXJobInforModel.h"
//#import "HXEllementViewModel.h"
//#import "FileManager.h"
//#import "MHDatePicker.h"
//#define cellTag 500
//@interface HXEnrollmentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,jobPhotoDelegate>
//{
//    UITableView * _tableView;
//    MHDatePicker *_pikerView;
//}
//@property (nonatomic,strong)HXJobInforModel * jobModel;
//@property (nonatomic,strong) UIButton * referButton;
//@property (nonatomic,strong)BaseTableViewCell * cityCell; //宿舍地址
//@property (nonatomic,strong)BaseTableViewCell * liveCell; //生活费
//@property (nonatomic,strong)BaseTableViewCell * revenueCell;//兼职收入
//@property (nonatomic,strong)BaseTableViewCell * schoolCell; //学校
//@property (nonatomic,strong)BaseTableViewCell * addressCell;
//@property (nonatomic,strong)BaseTableViewCell * majonCell;
//@property (nonatomic,strong)BaseTableViewCell * entryTimeCell;//入雪时间
//
//@property (nonatomic,strong)HXEllementViewModel * viewModel;
//@property (nonatomic,strong)UISwitch *switchView;
//@end
//
//@implementation HXEnrollmentViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXEllementViewModel alloc] initWithController:self];
//        self.jobModel.switchOn = @"2";
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
//    self.title = @"学籍信息";
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
//    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
//    footView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableFooterView:footView];
//
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
//    self.referButton = referButton;
//    [referButton setTitle:@"保存" forState:UIControlStateNormal];
//    referButton.enabled = NO;
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
//#pragma mark -- request
//-(void)request {
//
//    [self.viewModel archiveInformationWithReturnBlock:^{
//        self.jobModel.name = self.viewModel.model.schoolName?self.viewModel.model.schoolName:@"";
//        self.jobModel.unitcommenAddress = self.viewModel.model.dormAddress?self.viewModel.model.dormAddress:@"";
//        self.jobModel.provinceModel  = [[FileManager manager] getProvinceModel:self.viewModel.model.provinceId];
//        self.jobModel.cityModel = [[FileManager manager] getCityModel:self.viewModel.model.cityId];
//        if (self.jobModel.provinceModel.areaName.length !=0 ||self.jobModel.cityModel.areaName.length!=0) {
//            self.jobModel.address = [NSString stringWithFormat:@"%@ %@",self.jobModel.provinceModel.areaName?self.jobModel.provinceModel .areaName:@"",self.jobModel.cityModel.areaName?self.jobModel.cityModel.areaName:@""] ;
//        }
//        self.jobModel.majorIn = self.viewModel.model.discipline ?self.viewModel.model.discipline:@"";
//        self.jobModel.alimony = self.viewModel.model.livingExpenses?self.viewModel.model.livingExpenses:@"";
//        self.jobModel.revenue = self.viewModel.model.concurrentPostEarnings?self.viewModel.model.concurrentPostEarnings:@"";
//        self.jobModel.entryTime = self.viewModel.model.admissionAt?self.viewModel.model.admissionAt:@"";
//        self.jobModel.switchOn = self.viewModel.model.concurrentPost.length!=0?self.viewModel.model.concurrentPost:@"2";
//        self.switchView.on = [self.jobModel.switchOn isEqualToString:@"1"]?YES:NO;
//        [self changeButtonStates];
//        [_tableView reloadData];
//    }];
//
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.switchView.isOn) {
//        return 9;
//    }
//    return 8;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    static NSString *cellIdentity1 = @"IdentityInfoCell1";
//    static NSString *cellIdentity2 = @"IdentityInfoCell2";
//    if (indexPath.row==0||indexPath.row==1||indexPath.row==2||indexPath.row==5||indexPath.row==6||(self.switchView.isOn&&indexPath.row==8)) {
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//            [cell creatLine:15 hidden:NO];
//            cell.writeTextfield.textColor = ComonTitleColor;
//        }
//        cell.writeTextfield.delegate =self;
//        cell.writeTextfield.tag = indexPath.row+1;
//        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        cell.writeTextfield.keyboardType = UIKeyboardTypeDefault;
//        cell.writeTextfield.enabled = YES;
//        if (indexPath.row==0) {
//            cell.nameLabel.text = @"姓名";
//            cell.writeTextfield.enabled = NO;
//            cell.writeTextfield.text = self.viewModel.realName?self.viewModel.realName:@"";
//        }else if (indexPath.row==1) {
//            cell.nameLabel.text = @"就读学校";
//            cell.writeTextfield.placeholder = @"输入学校名称";
//            cell.writeTextfield.text = self.jobModel.name?self.jobModel.name:@"";
//            self.schoolCell = cell;
//        }else if (indexPath.row==5) {
//            cell.nameLabel.text = @"详细地址";
//            cell.writeTextfield.placeholder = @"请输入详细地址";
//            cell.writeTextfield.text = self.jobModel.unitcommenAddress?self.jobModel.unitcommenAddress:@"";
//            self.addressCell = cell;
//        }else if (indexPath.row==2) {
//            cell.nameLabel.text = @"主修专业";
//            cell.writeTextfield.placeholder = @"输入主修专业";
//            cell.writeTextfield.text = self.jobModel.majorIn?self.jobModel.majorIn:@"";
//            self.majonCell = cell;
//        }else if (indexPath.row==6) {
//            cell.nameLabel.text = @"月生活费";
//            cell.writeTextfield.placeholder = @"请输入月生活费";
//            cell.writeTextfield.text = self.jobModel.alimony.length!=0?self.jobModel.alimony:@"";
//            cell.writeTextfield.keyboardType = UIKeyboardTypeDecimalPad;
//            self.liveCell = cell;
//        }else if (indexPath.row==8) {
//            cell.nameLabel.text = @"兼职输入";
//            cell.writeTextfield.placeholder = @"请输入兼职收入";
//            cell.writeTextfield.text = self.jobModel.revenue.length!=0?self.jobModel.revenue:@"";
//            cell.writeTextfield.keyboardType = UIKeyboardTypeDecimalPad;
//            self.revenueCell = cell;
//        }
//        return cell;
//
//    }else if (indexPath.row==7){
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity2];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity2];
//            cell.nameLabel.text = @"是否兼职";
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            self.switchView = [[UISwitch alloc]init];
//            [self.switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
//            [cell.contentView addSubview:self.switchView];
//            [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView).offset(-10);
//                make.centerY.equalTo(cell.contentView);
//                make.width.mas_equalTo(60);
//                make.height.mas_equalTo(28);
//            }];
//            [cell creatLine:15 hidden:NO];
//
//        }
//
//        return cell;
//
//    }else {
//
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
//        if (!cell) {
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
//            [cell creatLine:15 hidden:NO];
//            [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(cell.contentView);
//            }];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        if (indexPath.row==3) {
//            cell.nameLabel.text = @"入学时间";
//            cell.titleLabel.text = self.jobModel.entryTime.length ?self.jobModel.entryTime : @"请选择";
//            cell.titleLabel.textColor = self.jobModel.entryTime.length ?kUIColorFromRGB(0x666666) :ComonCharColor;
//            self.entryTimeCell = cell;
//        }else if (indexPath.row==4) {
//            cell.nameLabel.text = @"宿舍地址";
//            cell.titleLabel.text = self.jobModel.address.length ?self.jobModel.address : @"选择城市";
//            cell.titleLabel.textColor = self.jobModel.address.length ?kUIColorFromRGB(0x666666) :ComonCharColor;
//            self.cityCell = cell;
//        }else {
//            //            cell.nameLabel.text = @"学生证明";
//            //            cell.titleLabel.text = self.viewModel.companyImgArr.count>0?@"已上传":@"上传";
//            //            cell.titleLabel.textColor = self.viewModel.companyImgArr.count>0?kUIColorFromRGB(0x666666): ComonCharColor;
//            //            [cell creatLine:15 hidden:YES];
//        }
//        return cell;
//
//
//    }
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
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    switch (indexPath.row) {
//        case 3:
//        {
//            [self.view endEditing:YES];
//            //入职时间
//            _pikerView = [[MHDatePicker alloc] init];
//            _pikerView.datePickerMode = UIDatePickerModeDate;
//            __weak HXEnrollmentViewController * weakSelf = self;
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
//        }
//            break;
//        case 4:
//        {
//            [self.view endEditing:YES];
//            //单位地址
//            AddressPickView *addressPickView = [AddressPickView shareInstance];
//            [self.view addSubview:addressPickView];
//            addressPickView.block = ^(AddressModel *provinceModel, AddressModel *cityModel){
//                _cityCell.titleLabel.text = [NSString stringWithFormat:@"%@ %@",provinceModel.areaName,cityModel.areaName] ;
//                if (provinceModel.areaName.length !=0 ||cityModel.areaName.length!=0) {
//
//                    _jobModel.address = [NSString stringWithFormat:@"%@ %@",provinceModel.areaName,cityModel.areaName] ;
//                }
//
//                _cityCell.titleLabel.textColor = kUIColorFromRGB(0x666666);
//                self.jobModel.provinceModel = provinceModel;
//                self.jobModel.cityModel = cityModel;
//                [self changeButtonStates];
//            };
//
//        }
//            break;
//
//        default:
//            break;
//    }
//    if (self.switchView.isOn) {
//        if (indexPath.row==9) {
//            //            HXJobPhotoViewController * jopPhoto = [[HXJobPhotoViewController alloc] init];
//            //            jopPhoto.delegate = self;
//            //            [self.navigationController pushViewController:jopPhoto animated:YES];
//        }
//    }else {
//        if (indexPath.row==8) {
//            //            HXJobPhotoViewController * jopPhoto = [[HXJobPhotoViewController alloc] init];
//            //            jopPhoto.delegate = self;
//            //            [self.navigationController pushViewController:jopPhoto animated:YES];
//        }
//
//    }
//
//}
//#pragma mark-textField代理
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    //    [textField keyBoardEvent];
//}
//-(void)textFieldDidChange:(UITextField *)textField
//{
//    if ([textField isEqual:self.schoolCell.writeTextfield]) {
//        if(textField.text.length > 20) {
//            textField.text = [textField.text substringToIndex:20];
//        }
//        self.jobModel.name = textField.text;
//    }else if ([textField isEqual:self.addressCell.writeTextfield]) {
//        if(textField.text.length > 30) {
//            textField.text = [textField.text substringToIndex:30];
//        }
//        self.jobModel.unitcommenAddress = textField.text;
//    }else if ([textField isEqual:self.majonCell.writeTextfield]) {
//        if(textField.text.length > 15) {
//            textField.text = [textField.text substringToIndex:15];
//        }
//        self.jobModel.majorIn = textField.text;
//    }else if([textField isEqual:self.liveCell.writeTextfield]) {
//        self.jobModel.alimony = textField.text;
//    }else if([textField isEqual:self.revenueCell.writeTextfield]){
//        self.jobModel.revenue = textField.text;
//    }else {
//
//    }
//
//    [self changeButtonStates];
//}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//    NSInteger allowedLength = 100;
//    NSString  *astring      = @"";
//
//    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
//        return NO;
//    }
//
//    if ([textField isEqual:_liveCell.writeTextfield]||[textField isEqual:_revenueCell.writeTextfield]) {
//
//        return [Helper justNumerWithTextField:textField shouldChangeCharactersInRange:range replacementString:string numberLength:6];
//    }
//
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
//#pragma mark -- jobPhotoDelegate
//-(void)archivePhoto:(NSMutableArray *)photoArr {
//    NSMutableArray * arr = [[NSMutableArray alloc] init];
//    [arr addObjectsFromArray:photoArr];
//    self.viewModel.companyImgArr = arr;
//    [_tableView reloadData];
//    [self changeButtonStates];
//}
//#pragma mark -- 提交
//-(void)registerAction {
//    [self.viewModel submitInformationWithJobModel:self.jobModel photoArr:nil returnBlock:^{
//        [KeyWindow displayMessage:@"认证成功"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Authentication object:nil userInfo:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//
//}
//#pragma mark -- 判断按钮状态
//-(void)changeButtonStates {
//    if (self.jobModel.name.length!=0&&self.jobModel.unitcommenAddress.length!=0&&self.jobModel.address.length!=0&&self.jobModel.majorIn.length!=0&&self.jobModel.alimony.length!=0&&self.jobModel.entryTime.length!=0&&((self.switchView.isOn&&self.jobModel.revenue.length!=0)||!self.switchView.isOn)) {
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
//-(void)switchAction:(id)sender
//{
//    UISwitch *switchButton = (UISwitch*)sender;
//    BOOL isButtonOn = [switchButton isOn];
//    if (isButtonOn) {
//        NSLog(@"开");
//        self.jobModel.switchOn = @"1";
//    }else {
//        NSLog(@"关");
//        self.jobModel.switchOn = @"2";
//    }
//    self.revenueCell.writeTextfield.text = @"";
//    self.jobModel.revenue = @"";
//    [_tableView reloadData];
//    [self changeButtonStates];
//}
//
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
//
