////
////  DataAuthenticationViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/10.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "DataAuthenticationViewController.h"
//#import "DataAuthenticationCell.h"
//#import "CertificationViewController.h"
//#import "PersonalInformationViewController.h"
//#import "HXBankAuthenticationViewController.h"
//#import "HXJobInformationViewController.h"
//#import "HXEnrollmentViewController.h"
//#import "HXImageViewController.h"
//#import "HXHomeInformationViewController.h"
//
//#import "HXAuthenticationStatusViewController.h"
//#import "MoxieSDK.h"
//
//@interface DataAuthenticationViewController ()<UITableViewDelegate,UITableViewDataSource,MoxieSDKDelegate>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong) UIButton * referButton;
//@end
//
//@implementation DataAuthenticationViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXDataAuthenticationViewModel alloc] initWithController:self];
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
//    
//    [self request];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updaStates) name:Notification_Authentication object:nil];
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
//}
//-(void) hiddeKeyBoard{
//    
//    [self.view endEditing:YES];
//    
//}
///**********************SDK 使用***********************/
//-(void)configMoxieSDK{
//    /***必须配置的基本参数*/
//    
//    [MoxieSDK shared].delegate = self;
//    [MoxieSDK shared].userId = theUserID;
//    [MoxieSDK shared].apiKey = theApiKey;
//    [MoxieSDK shared].fromController = self;
//    [MoxieSDK shared].useNavigationPush = NO;
//    [MoxieSDK shared].cacheDisable = YES;
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
//    self.referButton.hidden = !self.viewModel.hiddSubmitBtn;
//    [referButton setTitle:@"提交申请" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0x4A90E2) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x4A90E2) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [footView addSubview:referButton];
//}
//#pragma mark -- request
//-(void)request {
//    [self.viewModel archiveDataAtuthenStatesWithReturnBlock:^{
//        [_tableView reloadData];
//    }];
//    
//    
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
//     }
//    cell.nameLabel.text = [[self.viewModel.nameArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    NSString * states = [ProfileManager getAuthenticatingStateWithCode:[[self.viewModel.statesArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
//    cell.stateLabel.text = states.length!=0?states:@"未填写";
//   
//    cell.stateLabel.textColor = [states isEqualToString:@"未填写"] ?ComonCharColor:kUIColorFromRGB(0x55A0FC);
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
//    return 40;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    backView.backgroundColor = COLOR_BACKGROUND;
//    
//    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 40)];
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
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//            {
//                CertificationViewController * certification = [[CertificationViewController alloc] init];
//                [self.navigationController pushViewController:certification animated:YES];
//                
//            }
//                break;
//            case 1:
//            {
////                OperatorCertificationViewController * operatorcation = [[OperatorCertificationViewController alloc] init];
////                [self.navigationController pushViewController:operatorcation animated:YES];
//                if (!([self.viewModel.model.isAuth isEqualToString:@"1"] ||[self.viewModel.model.isAuth isEqualToString:@"2"])) {
//                    
//                    [KeyWindow displayMessage:@"请先完成实名认证"];
//                    return;
//                    
//                }
//                
//                [MoxieSDK shared].taskType = @"carrier";
//                
////                //自定义运营商
////                [MoxieSDK shared].carrier_phone = @"18600486133";
////                [MoxieSDK shared].carrier_password = @"132635";
////                [MoxieSDK shared].carrier_name = @"胡承群";
////                [MoxieSDK shared].carrier_idcard = @"340825199104244318";
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
//                   [KeyWindow displayMessage:@"请先完成实名认证"];
//                    return;
//
//                }
//                if (self.viewModel.style == WorkStyle) {
//                    
//                    HXJobInformationViewController* job = [[HXJobInformationViewController alloc] init];
//                    [self.navigationController pushViewController:job animated:YES];
//                }else if(self.viewModel.style == StudentStyle){
//                    
//                    HXEnrollmentViewController* job = [[HXEnrollmentViewController alloc] init];
//                    [self.navigationController pushViewController:job animated:YES];
//                }else if(self.viewModel.style == FreeStyle){
//                    HXHomeInformationViewController * home = [[HXHomeInformationViewController alloc] init];
//                    [self.navigationController pushViewController:home animated:YES];
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
//                //                HXJobInformationViewController* job = [[HXJobInformationViewController alloc] init];
//                HXEnrollmentViewController* job = [[HXEnrollmentViewController alloc] init];
//                [self.navigationController pushViewController:job animated:YES];
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
//        [MoxieSDK shared].taskType = @"zhengxin";
//        //打开征信v2版本
//        [MoxieSDK shared].loginVersion = @"v2";
//        [[MoxieSDK shared] start];
//        
////        HXAuthenticationStatusViewController * hxauth = [[HXAuthenticationStatusViewController alloc] init];
////        [self.navigationController pushViewController:hxauth animated:YES];
//        
//    }else {
//        if (!([self.viewModel.model.isAuth isEqualToString:@"1"] ||[self.viewModel.model.isAuth isEqualToString:@"2"])) {
//            
//            [KeyWindow displayMessage:@"请先完成实名认证"];
//            return;
//            
//        }
//        HXAuthenticationStatusViewController * hxauth = [[HXAuthenticationStatusViewController alloc] init];
//        [self.navigationController pushViewController:hxauth animated:YES];
//    }
//}
//
//#pragma mark -- 提交
//-(void)registerAction {
//    if ([self.viewModel.model.isAuth isEqualToString:@"0"]||[self.viewModel.model.isAuth isEqualToString:@"3"]||[self.viewModel.model.isAuth isEqualToString:@"4"]) {
//        [KeyWindow displayMessage:@"请先进行实名认证"];
//        return;
//    }
//    if ([self.viewModel.model.isOperatorAuth isEqualToString:@"0"]||[self.viewModel.model.isOperatorAuth isEqualToString:@"3"]||[self.viewModel.model.isOperatorAuth isEqualToString:@"4"]) {
//        [KeyWindow displayMessage:@"请先进行运营商认证"];
//        return;
//    }
//    if ([self.viewModel.model.isPersonalAuth isEqualToString:@"0"]||[self.viewModel.model.isPersonalAuth isEqualToString:@"3"]||[self.viewModel.model.isPersonalAuth isEqualToString:@"4"]) {
//        [KeyWindow displayMessage:@"请先进行个人信息认证"];
//        return;
//    }
//    
//    
//    if (self.viewModel.style == WorkStyle){
//        if ([self.viewModel.model.isWorkAuth isEqualToString:@"0"]||[self.viewModel.model.isWorkAuth isEqualToString:@"3"]||[self.viewModel.model.isWorkAuth isEqualToString:@"4"]) {
//            [KeyWindow displayMessage:@"请先进行工作信息认证"];
//            return;
//        }
//        
//    }else if (self.viewModel.style == StudentStyle){
//        if ([self.viewModel.model.isSchoolAuth isEqualToString:@"0"]||[self.viewModel.model.isSchoolAuth isEqualToString:@"3"]||[self.viewModel.model.isSchoolAuth isEqualToString:@"4"]) {
//            [KeyWindow displayMessage:@"请先进行学籍信息认证"];
//            return;
//        }
//        
//        
//    }else if (self.viewModel.style == FreeStyle){
//        if ([self.viewModel.model.isHomeAuth isEqualToString:@"0"]||[self.viewModel.model.isHomeAuth isEqualToString:@"3"]||[self.viewModel.model.isHomeAuth isEqualToString:@"4"]) {
//            [KeyWindow displayMessage:@"请先进行家庭信息认证"];
//            return;
//        }
//        
//    }else {
//        [KeyWindow displayMessage:@"请先进行个人信息认证"];
//        return;
//    }
//    
//    if (!self.viewModel.provideBool) {
//        [self.viewModel creditActivationWithReturnBlock:^{
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }];
//    }else {
//    [self.viewModel submitAdjustAmountWithReturnBlock:^{
//        
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
//    }
//
//}
//
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
//    
//    [self request];
//}
//#pragma mark -- setter 
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_Authentication object:nil];
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
