////
////  HXAuthenticationStatusViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/25.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXAuthenticationStatusViewController.h"
//#import "AuthenTitleBar.h"
//#import "ComButton.h"
//#import "DataAuthenticationCell.h"
//#import "HXOrderStatusTagView.h"
//#import "MoxieSDK.h"
//#import "HXBankAuthViewController.h"
//
//#import "CertificationViewController.h"
//#import "PersonalInformationViewController.h"
//#import "HXBankAuthenticationViewController.h"
//#import "HXJobInformationViewController.h"
//#import "HXEnrollmentViewController.h"
//#import "HXImageViewController.h"
//#import "HXHomeInformationViewController.h"
//
//#import "HXAuthenticationStatusViewController.h"
//#import "HXJobPhotoViewController.h"
//#import "PhotoSave.h"
//#import "CurrentLocation.h"
//
//@interface HXAuthenticationStatusViewController ()<UITableViewDelegate,UITableViewDataSource,MoxieSDKDelegate>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong) UIButton * referButton;
//@property (nonatomic,strong)NSArray * nameArr;
//@property (nonatomic,strong)UIView * headView;
//
//
//
//@property (nonatomic,strong)UILabel * promptLabel;//审核状态描述 申请金额
//@property (nonatomic,strong)UILabel * derateLabel;// 降额
//@property (nonatomic,strong)UILabel * statesLabel;//审核状态
//@property (nonatomic,strong)UIView * backView ; //白色背景
//@property (nonatomic,strong)NSArray * photoArr;
//@end
//
//@implementation HXAuthenticationStatusViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXDataAuthenticationViewModel alloc] initWithController:self];
//        self.viewModel.orderAuth = YES;
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self.viewModel changeStates];
//    [self createUI];
//    [self hiddeKeyBoard];
//    [self configMoxieSDK];
//    [MBProgressHUD showMessage:nil toView:self.view];
//    [self request];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_Authentication object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updaStates) name:Notification_Authentication object:nil];
//}
//-(void)viewWillAppear:(BOOL)animated {
//
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"资料认证";
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//    self.view.backgroundColor = HXRGB(255, 255, 255);
//    
//}
//
//- (void)onBack {
//    if ([self.navigationController.viewControllers objectAtIndex:1]) {
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//        return;
//    }
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//
//-(void) hiddeKeyBoard{
//    [self.view endEditing:YES];
//}
///**********************SDK 使用***********************/
//-(void)configMoxieSDK{
//    /***必须配置的基本参数*/
//    [MoxieSDK shared].delegate = self;
//    [MoxieSDK shared].userId = theUserID;
//    [MoxieSDK shared].apiKey = theApiKey;
//    [MoxieSDK shared].fromController = self;
//    [MoxieSDK shared].cacheDisable = YES;
//    [MoxieSDK shared].useNavigationPush = NO;
//    //Navbar是否透明
//    [MoxieSDK shared].navigationController.navigationBar.translucent = NO;
//    //NavBar背景色
//    [MoxieSDK shared].navigationController.navigationBar.barTintColor = ColorWithHex(0xFFFFFF);
//    //按钮文字和图片颜色
//    [MoxieSDK shared].navigationController.navigationBar.tintColor = ComonBackColor;
//    //Title文字颜色
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:ColorWithHex(0x131313),NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
//    [MoxieSDK shared].navigationController.navigationBar.titleTextAttributes = dict;
//    
//    //自定义返回按钮图片
//    [MoxieSDK shared].backImageName = @"mx_back@2x";
//    [MoxieSDK shared].hideRightButton = YES;
//    
//    //-------------更多自定义参数，请参考文档----------------//
//};
//
//-(void)createUI {
//    HXOrderStatusTagView *statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"选择分期",@"认证资料",@"开户绑卡",@"签署合同"] selectedIndex:1 isFirst:NO];
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//    
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
//        make.top.equalTo(statusTagView.mas_bottom).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//    }];
//    
//    /**
//     *  headView
//     */
//    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 86)];
//    self.headView = headView;
//    headView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableHeaderView:headView];
//    
//    UIView * backView = [[UIView alloc] init];
//    self.backView = backView;
//    backView.layer.cornerRadius = 5;
//    backView.layer.masksToBounds = YES;
//    backView.backgroundColor = kUIColorFromRGB(0xffffff);
//    [headView addSubview:backView];
//    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(headView);
//        make.left.equalTo(headView).offset(15);
//        make.width.mas_equalTo(SCREEN_WIDTH-30);
//        make.height.mas_equalTo(71);
//    }];
//    
//    UILabel * statesLabel = [[UILabel alloc] init];
//    self.statesLabel = statesLabel;
//    statesLabel.font = [UIFont systemFontOfSize:18];
//    statesLabel.textColor = kUIColorFromRGB(0x4990e2);
//    [backView addSubview:statesLabel];
//    [statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backView.mas_left).offset(15);
//        make.top.equalTo(backView.mas_top).offset(15);
//    }];
//    
//    UILabel * promptLabel = [[UILabel alloc] init];
//    promptLabel.numberOfLines = 0;
//    self.promptLabel = promptLabel;
//    promptLabel.textColor = ComonCharColor;
//    promptLabel.font = [UIFont systemFontOfSize:13];
//    [backView addSubview:promptLabel];
//    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backView.mas_left).offset(15);
//        make.right.equalTo(backView.mas_right).offset(-15);
//        make.top.equalTo(backView.mas_top).offset(43);
//        make.height.mas_equalTo(13);
//    }];
//    
//    UILabel * derateLabel = [[UILabel alloc] init];
//    self.derateLabel = derateLabel;
//    self.derateLabel.hidden = YES;
//    derateLabel.textColor = ComonBackColor  ;
//    derateLabel.font = [UIFont systemFontOfSize:13];
//    [backView addSubview:derateLabel];
//    [derateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backView.mas_left).offset(15);
//        make.top.equalTo(backView.mas_top).offset(61);
//        make.height.mas_equalTo(13);
//    }];
//    
//    
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
//    self.referButton.hidden = YES;
//    self.referButton.enabled = YES;
//    if (self.viewModel.states == OrderStatuesReplenish) {
//        [referButton setTitle:@"重新提交" forState:UIControlStateNormal];
//    } else if(self.viewModel.states == OrderStatuesCommen) {
//        [referButton setTitle:@"提交申请" forState:UIControlStateNormal];
//    } else {
//        [referButton setTitle:@"下一步" forState:UIControlStateNormal];
//    }
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0x4A90E2) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x4A90E2) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [footView addSubview:referButton];
//    
//    [self getTitle];
//    
//}
//
//- (void)getTitle {
//    [self.viewModel replaceTitleWithTileBlock:^(NSString *title, NSString *description,float titleHeight) {
//        self.promptLabel.text = description.length?description:@"";
//        self.statesLabel.text = title.length?title:@"";
//        self.referButton.hidden = !self.viewModel.hiddSubmitBtn;
//        if (self.viewModel.states == OrderStatuesPass) {
//            
//            self.promptLabel.text = [NSString stringWithFormat:@"审批金额:%@",self.viewModel.applyMoney?self.viewModel.applyMoney:@"0"];
//            [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(71);
//            }];
//            [self.promptLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(13);
//            }];
//            self.derateLabel.hidden = YES;
//            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 86);
//            _tableView.tableHeaderView = self.headView;
//            return;
//        }
//        
//        if (self.viewModel.states == OrderStatuesDerate) {
//            
//            self.promptLabel.text = [NSString stringWithFormat:@"申请金额:%@",self.viewModel.applyMoney?self.viewModel.applyMoney:@"0"];
//            [self.promptLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(13);
//            }];
//            [self.derateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(13);
//            }];
//            self.derateLabel.text = [NSString stringWithFormat:@"降额至:%@",self.viewModel.derate?self.viewModel.derate:@"0"];
//            [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(84);
//            }];
//            self.derateLabel.hidden = NO;
//            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 99);
//            _tableView.tableHeaderView = self.headView;
//            return;
//        }
//        
//        
//        if (titleHeight != 0) {
//            [self.promptLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(titleHeight);
//            }];
//            [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(58+titleHeight);
//            }];
//            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30+58+titleHeight);
//            _tableView.tableHeaderView = self.headView;
//            
//            if (self.viewModel.states == OrderStatuesReplenish || self.viewModel.states == OrderStatuesCancel|| self.viewModel.states == OrderStatuesRefuse) {
//                self.statesLabel.textColor = ComonBackColor;
//            }
//        }else {
//            [self.promptLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(13);
//            }];
//            [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(71);
//            }];
//            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 86);
//            _tableView.tableHeaderView = self.headView;
//            
//            if (self.viewModel.states == OrderStatuesReplenish || self.viewModel.states == OrderStatuesCancel|| self.viewModel.states == OrderStatuesRefuse) {
//                self.statesLabel.textColor = ComonBackColor;
//            }
//            
//            
//        }
//        
//    }];
//}
//
//#pragma mark -- request
//-(void)request {
//    [self.viewModel archiveDataAtuthenStatesWithReturnBlock:^{
//        [_tableView reloadData];
//    }];
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
////    return self.viewModel.nameArr.count;
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [[self.viewModel.nameArr objectAtIndex:section] count];
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    DataAuthenticationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        
//        cell = [[DataAuthenticationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//        
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        [cell creatLine:15 hidden:NO];
//    }
//    cell.nameLabel.text = [[self.viewModel.nameArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    NSString * states = [ProfileManager getAuthenticatingStateWithCode:[[self.viewModel.statesArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
//    cell.stateLabel.text = states.length!=0?states:@"未填写";
//    
//    if ([cell.nameLabel.text isEqualToString:@"影像信息"]) {
//        cell.stateLabel.text  = @"待上传";
//        if (self.viewModel.photoUploadBool) {
//            cell.stateLabel.text = @"已上传";
//            cell.stateLabel.textColor = kUIColorFromRGB(0x55A0FC);
//        }else {
//            cell.stateLabel.text  = @"待上传";
//            cell.stateLabel.textColor = ComonCharColor;
//        }
//    }else {
//        
//        cell.stateLabel.textColor = [cell.stateLabel.text isEqualToString:@"未填写"] ?ComonCharColor:kUIColorFromRGB(0x55A0FC);
//    }
//    
//    
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
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
//    backView.backgroundColor = COLOR_BACKGROUND;
//    
//    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 38)];
//    titleLabel.font = [UIFont systemFontOfSize:13];
//    titleLabel.textColor = kUIColorFromRGB(0x666666);
//    [backView addSubview:titleLabel];
//    if (section==0) {
//        titleLabel.text = @"基本信息";
//    }else if(section == 1) {
//        titleLabel.text = @"选填资料（有助于更全面的评估您的额度）";
//    }else {
//        titleLabel.text = @"其他资料";
//    }
//    return backView;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (!(self.viewModel.states == OrderStatuesCommen || self.viewModel.states == OrderStatuesReplenish)) {
//        return;
//    }
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//            {
//                CertificationViewController * certification = [[CertificationViewController alloc] init];
//                certification.viewModel.orderNo = self.viewModel.orderInfo.orderNo;
//                [self.navigationController pushViewController:certification animated:YES];
//                
//            }
//                break;
//            case 1:
//            {
//                if (!([self.viewModel.model.isAuth isEqualToString:@"1"] ||[self.viewModel.model.isAuth isEqualToString:@"2"])) {
//                    
//                    [KeyWindow displayMessage:@"请先完成实名认证"];
//                    return;
//                    
//                }
//                [MoxieSDK shared].taskType = @"carrier";
//                [MoxieSDK shared].themeColor = kUIColorFromRGB(0x56A0FC);
//                [[MoxieSDK shared] start];
//            }
//                break;
//            case 2:
//            {
//                if (!([self.viewModel.model.isAuth isEqualToString:@"1"] ||[self.viewModel.model.isAuth isEqualToString:@"2"])) {
//                    
//                    [KeyWindow displayMessage:@"请先完成实名认证"];
//                    return;
//                    
//                }
//                PersonalInformationViewController* personal = [[PersonalInformationViewController alloc] init];
//                [self.navigationController pushViewController:personal animated:YES];
//            }
//                break;
//            case 3:
//            {
//                if (!([self.viewModel.model.isAuth isEqualToString:@"1"] ||[self.viewModel.model.isAuth isEqualToString:@"2"])) {
//                    
//                    [KeyWindow displayMessage:@"请先完成实名认证"];
//                    return;
//                    
//                }
//                if (self.viewModel.style == WorkStyle) {
//                    HXJobInformationViewController* job = [[HXJobInformationViewController alloc] init];
//                    [self.navigationController pushViewController:job animated:YES];
//                }else if(self.viewModel.style == StudentStyle){
//                    
//                    HXEnrollmentViewController* job = [[HXEnrollmentViewController alloc] init];
//                    [self.navigationController pushViewController:job animated:YES];
//                }else if(self.viewModel.style == FreeStyle){
//                    HXHomeInformationViewController * home = [[HXHomeInformationViewController alloc] init];
//                    [self.navigationController pushViewController:home animated:YES];
//                }else {
//                    HXImageViewController * image = [[HXImageViewController alloc] init];
//                    image.viewModel.firstPayment = self.viewModel.orderInfo.firstPayment;
//                    image.viewModel.orderId = self.viewModel.orderId;
//                    image.viewModel.style = self.viewModel.style;
//                    image.viewModel.orderNumber = self.viewModel.orderInfo.orderNo;
//                    [self.navigationController pushViewController:image animated:YES];
//                }
//            }
//                break;
//            case 4:
//            {
//                if (!([self.viewModel.model.isAuth isEqualToString:@"1"] ||[self.viewModel.model.isAuth isEqualToString:@"2"])) {
//                    
//                    [KeyWindow displayMessage:@"请先完成实名认证"];
//                    return;
//                    
//                }
//                HXImageViewController * image = [[HXImageViewController alloc] init];
//                image.viewModel.firstPayment = self.viewModel.orderInfo.firstPayment;
//                image.viewModel.orderId = self.viewModel.orderId;
//                image.viewModel.orderNumber = self.viewModel.orderInfo.orderNo;
//                image.viewModel.style = self.viewModel.style;
//                [self.navigationController pushViewController:image animated:YES];
//                
//            }
//                break;
//            default:
//                break;
//        }
//        
//    }else if(indexPath.section==1) {
//        if (!([self.viewModel.model.isAuth isEqualToString:@"1"] ||[self.viewModel.model.isAuth isEqualToString:@"2"])) {
//            
//            [KeyWindow displayMessage:@"请先完成实名认证"];
//            return;
//            
//        }
//        if (indexPath.row==0) {
//            [MoxieSDK shared].taskType = @"email";
//            //打开某个具体邮箱，具体有哪些loginCode参考文档第四个条目
//            //    [MoxieSDK shared].loginCustom = @{
//            //      @"loginCode":@"qq.com",
//            //      @"loginParams":@{
//            //        @"username":@"xxxxxxx@qq.com",
//            //        @"password":@"yyyyyy",
//            //        @"sepwd":@"zzzzzz"
//            //      }
//            //    };
//            [[MoxieSDK shared] start];
//            return;
//        }
//        
//        [MoxieSDK shared].taskType = @"zhengxin";
//        //打开征信v2版本
//        [MoxieSDK shared].loginVersion = @"v2";
//        [[MoxieSDK shared] start];
//        
//        
//    }else {
//        if (!([self.viewModel.model.isAuth isEqualToString:@"1"] ||[self.viewModel.model.isAuth isEqualToString:@"2"])) {
//            
//            [KeyWindow displayMessage:@"请先完成实名认证"];
//            return;
//            
//        }
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
//    //    if ([textField isEqual:self.unitCell.writeTextfield]) {
//    //        self.jobModel.unitStr = textField.text;
//    //    }else if ([textField isEqual:self.commenCell.writeTextfield]) {
//    //        self.jobModel.unitcommenAddress = textField.text;
//    //    }else if ([textField isEqual:self.iphoneCell.writeTextfield]) {
//    //        self.jobModel.iphoneNumber = textField.text;
//    //    }else if ([textField isEqual:self.reventCell.writeTextfield]) {
//    //        self.jobModel.revenue = textField.text;
//    //    }else {
//    //
//    //    }
//    
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
//            astring       = LIMIT_ALPHANUM;
//        }
//            break;
//        case 5: {
//            allowedLength = 20;
//            astring       = LIMIT_ALPHANUM;
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
//
//#pragma MoxieSDK Result Delegate
//-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
//    int code = [resultDictionary[@"code"] intValue];
//    NSString *taskType = resultDictionary[@"taskType"];
//    NSString *taskId = resultDictionary[@"taskId"];
//    NSString *searchId = resultDictionary[@"searchId"];
//    NSString *message = resultDictionary[@"message"];
//    NSString *account = resultDictionary[@"account"];
//    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,searchId:%@,message:%@,account:%@",code,taskType,taskId,searchId,message,account);
//    //用户没有做任何操作
//    if(code == -1){
//        NSLog(@"用户未进行操作");
//    }
//    //假如code是2则继续查询该任务进展
//    else if(code == 2){
//        NSLog(@"任务进行中，可以继续轮询");
//    }
//    //假如code是1则成功
//    else if(code == 1){
//        if ([taskType isEqualToString:@"email"]) {
//            [self.viewModel cheakCarrieroperatorCodeNumber:@"0142" statesWithReturnBlock:^{
//                [self request];
//            }];
//        }
//        if ([taskType isEqualToString:@"zhengxin"]) {
//            [self.viewModel cheakCarrieroperatorCodeNumber:@"0141" statesWithReturnBlock:^{
//                [self request];
//            }];
//        }
//        
//        if ([taskType isEqualToString:@"carrier"]) {
//            
//            [self.viewModel cheakCarrieroperatorCodeNumber:@"0164" statesWithReturnBlock:^{
//                [self request];
//            }];
//        }
//    }
//    //该任务失败按失败处理
//    else{
//        NSLog(@"任务失败");
//    }
//    NSLog(@"任务结束，可以根据taskid，在租户管理系统查询该次任何的最终数据，在魔蝎云监控平台查询该任务的整体流程信息。SDK只会回调状态码及部分基本信息，完整数据会最终通过服务端回调。（记得将本demo的apikey修改成公司对应的正确的apikey）");
//}
//
//#pragma mark --delegate
//-(void)updaStates {
//    [self request];
//}
//#pragma mark -- setter
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_Authentication object:nil];
//}
//#pragma mark -- 提交
//-(void)registerAction {
//    if (self.viewModel.states == OrderStatuesPass ||self.viewModel.states == OrderStatuesDerate) {
//        
//    }else {
//        if ([self.viewModel.model.isAuth isEqualToString:@"0"]||[self.viewModel.model.isAuth isEqualToString:@"3"]||[self.viewModel.model.isAuth isEqualToString:@"4"] ||self.viewModel.model.isAuth.length==0) {
//            [KeyWindow displayMessage:@"请先进行实名认证"];
//            return;
//        }
//        if ([self.viewModel.model.isOperatorAuth isEqualToString:@"0"]||[self.viewModel.model.isOperatorAuth isEqualToString:@"3"]||[self.viewModel.model.isOperatorAuth isEqualToString:@"4"]||self.viewModel.model.isOperatorAuth.length==0) {
//            [KeyWindow displayMessage:@"请先进行运营商认证"];
//            return;
//        }
//        if ([self.viewModel.model.isPersonalAuth isEqualToString:@"0"]||[self.viewModel.model.isPersonalAuth isEqualToString:@"3"]||[self.viewModel.model.isPersonalAuth isEqualToString:@"4"]||self.viewModel.model.isPersonalAuth.length==0) {
//            [KeyWindow displayMessage:@"请先进行个人信息认证"];
//            return;
//        }
//        
//        
//        if (self.viewModel.style == DefaultStyle) {
//            
//            
//        }else if (self.viewModel.style == WorkStyle){
//            if ([self.viewModel.model.isWorkAuth isEqualToString:@"0"]||[self.viewModel.model.isWorkAuth isEqualToString:@"3"]||[self.viewModel.model.isWorkAuth isEqualToString:@"4"]) {
//                [KeyWindow displayMessage:@"请先进行工作信息认证"];
//                return;
//            }
//            
//        }else if (self.viewModel.style == StudentStyle){
//            if ([self.viewModel.model.isSchoolAuth isEqualToString:@"0"]||[self.viewModel.model.isSchoolAuth isEqualToString:@"3"]||[self.viewModel.model.isSchoolAuth isEqualToString:@"4"]) {
//                [KeyWindow displayMessage:@"请先进行学籍信息认证"];
//                return;
//            }
//            
//            
//        }else if (self.viewModel.style == FreeStyle){
//            if ([self.viewModel.model.isHomeAuth isEqualToString:@"0"]||[self.viewModel.model.isHomeAuth isEqualToString:@"3"]||[self.viewModel.model.isHomeAuth isEqualToString:@"4"]) {
//                [KeyWindow displayMessage:@"请先进行家庭信息认证"];
//                return;
//            }
//            
//        }else {
//            [KeyWindow displayMessage:@"请先进行信息认证"];
//            return;
//        }
//        BOOL photo = self.viewModel.photoUploadBool;
//        
//        if (!photo) {
//            [KeyWindow displayMessage:@"请先进行影像上传"];
//            return;
//        }
//        
//    }
//    
//    if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"88"] || [self.viewModel.orderInfo.yfqStatus isEqualToString:@"89"]) {
//        HXBankAuthViewController *controller = [[HXBankAuthViewController alloc] init];
//        controller.viewModel.orderId = self.viewModel.orderId;
//        controller.viewModel.orderInfo = self.viewModel.orderInfo;
//        controller.viewModel.orderType = self.viewModel.orderType;
//        [self.navigationController pushViewController:controller animated:YES];
//        
//        return;
//    }
//    //补充资料
//    if (self.viewModel.states == OrderStatuesReplenish) {
//        NSDictionary *head = @{@"tradeCode" : @"0135",
//                               @"tradeType" : @"appService"};
//        NSDictionary *body = @{@"orderId" : self.viewModel.orderId?self.viewModel.orderId:@"",
//                               @"userUuid" :user_id
//                               };
//        
//        [MBProgressHUD showMessage:nil toView:self.view];
//        
//        [[AFNetManager manager] postRequestWithHeadParameter:head
//                                               bodyParameter:body
//                                                     success:^(ResponseModel *object) {
//                                                         [MBProgressHUD hideHUDForView:self.view];
//                                                         if (IsEqualToSuccess(object.head.responseCode)) {
//                                                             NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
//                                                             self.viewModel.orderInfo.yfqStatus = yfqStatus;
//                                                             [self.viewModel.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//                                                                 if ([controller isMemberOfClass:self.class]) {
//                                                                     HXAuthenticationStatusViewController *tempController = (HXAuthenticationStatusViewController *)controller;
//                                                                     self.viewModel.supplyDescription = tempController.viewModel.supplyDescription;
//                                                                     self.viewModel.states = tempController.viewModel.states;
//                                                                     [self getTitle];
//                                                                 }
//                                                                 
//                                                             } with:self.viewModel.orderType];
//                                                             
//                                                         }
//                                                         
//                                                         
//                                                     } fail:^(ErrorModel *error) {
//                                                         [MBProgressHUD hideHUDForView:self.view];
//                                                     }];
//        
//        
//        return;
//    }
//    
//    
//    
//    [[CurrentLocation sharedManager] gpsCityWithLocationAddress:^(AddressModelInfo *addressModel) {
//        
//        NSDictionary *head = @{@"tradeCode" : @"0176",
//                               @"tradeType" : @"appService"};
//        NSDictionary *body = @{@"orderId" : self.viewModel.orderId?self.viewModel.orderId:@"",
//                               @"userUuid" :userUuid,
//                               @"gpsCode":[NSString stringWithFormat:@"%@,%@",addressModel.longitude.length!=0?addressModel.longitude:@"-1",addressModel.latitude.length!=0?addressModel.latitude:@""]
//                               };
//        
//        [MBProgressHUD showMessage:nil toView:self.view];
//        
//        [[AFNetManager manager] postRequestWithHeadParameter:head
//                                               bodyParameter:body
//                                                     success:^(ResponseModel *object) {
//                                                         [MBProgressHUD hideHUDForView:self.view];
//                                                         if (IsEqualToSuccess(object.head.responseCode)) {
//                                                             NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
//                                                             self.viewModel.orderInfo.yfqStatus = yfqStatus;
//                                                             [self.viewModel.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//                                                                 if ([controller isMemberOfClass:self.class]) {
//                                                                     HXAuthenticationStatusViewController *tempController = (HXAuthenticationStatusViewController *)controller;
//                                                                     self.viewModel.supplyDescription = tempController.viewModel.supplyDescription;
//                                                                     self.viewModel.states = tempController.viewModel.states;
//                                                                     [self getTitle];
//                                                                 }
//                                                                 
//                                                             } with:self.viewModel.orderType];
//                                                             
//                                                         }
//                                                         
//                                                         
//                                                     } fail:^(ErrorModel *error) {
//                                                         [MBProgressHUD hideHUDForView:self.view];
//                                                     }];
//    }];
//    
//}
//#pragma mark -- setter
//-(NSArray *)nameArr {
//    if (_nameArr == nil) {
//        _nameArr = [[NSMutableArray alloc] init];
//    }
//    return _nameArr;
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
