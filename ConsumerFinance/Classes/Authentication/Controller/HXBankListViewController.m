////
////  HXBankListViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/21.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXBankListViewController.h"
//#import "HXBankListCell.h"
//#import "ComButton.h"
//#import "HXBankAuthenticationViewController.h"
//#import "HXAddBankViewController.h"
//#import "HXBankListViewModel.h"
//#import "CertificationViewController.h"
//#import "HXAutoBankListViewController.h"
//
//@interface HXBankListViewController ()<UITableViewDelegate,UITableViewDataSource,HXBankDelegate,UIActionSheetDelegate>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong)HXBankListViewModel * viewModel;
//@property (nonatomic,strong)NSIndexPath * indexpath;
//@property (nonatomic,strong)UIView * footView;
//@end
//
//@implementation HXBankListViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXBankListViewModel alloc] initWithController:self];
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
////    [self request];
//}
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self.viewModel archiveBankListWithReturnBlock:^{
//        [_tableView reloadData];
//    }];
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"银行卡";
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
//    
//    /**
//     *  headView
//     */
//    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
//    _tableView.tableHeaderView = headView;
//    
//    UIButton * authBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-30, 50)];
//    [authBtn addTarget:self action:@selector(authBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    authBtn.backgroundColor = kUIColorFromRGB(0xffffff);
//    [headView addSubview:authBtn];
//    
//    UIImageView * authCardImage = [[UIImageView alloc] init];
//    [authCardImage setImage:[UIImage imageNamed:@"authCard"]];
//    [authBtn addSubview:authCardImage];
//    [authCardImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(authBtn);
//        make.left.equalTo(authBtn).offset(15);
//    }];
//    
//    UILabel * titleLabel = [[UILabel alloc] init];
//    titleLabel.font = [UIFont systemFontOfSize:14];
//    titleLabel.textColor = ComonTitleColor ;
//    titleLabel.text = @"自动还款卡";
//    [authBtn addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(authBtn);
//        make.left.equalTo(authBtn).offset(45);
//    }];
//    UIImageView * arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NextButton"]];
//    [authBtn addSubview:arrowImage];
//    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(authBtn);
//        make.right.equalTo(authBtn.mas_right).offset(-15);
//    }];
//    
//    /**
//     *  footView
//     */
//    
////    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
////    self.footView = footView;
////    footView.backgroundColor = COLOR_BACKGROUND;
////    [_tableView setTableFooterView:footView];
////
////    ComButton * referButton = [[ComButton alloc] init];
////    referButton.frame = CGRectMake(15, 10, SCREEN_WIDTH-30, 50);
////    [referButton.nameLabel setText:@"添加银行卡"];
////    [referButton.nameLabel setFont:[UIFont systemFontOfSize:16]];
////    [referButton.nameLabel setTextColor:ComonCharColor];
////    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
////    [referButton.layer setMasksToBounds:YES];
////    [referButton.layer setCornerRadius:4];
////    [Helper createImageWithColor:kUIColorFromRGB(0xffffff) button:referButton style:UIControlStateNormal];
////    [referButton.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.equalTo(referButton).offset(5);
////        make.centerY.equalTo(referButton);
////    }];
////    [referButton.photoImage setImage:[UIImage imageNamed:@"bankadd"]];
////    [referButton.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
////        make.right.equalTo(referButton.nameLabel.mas_left).offset(-5);
////        make.centerY.equalTo(referButton);
////    }];
////
////
////    [footView addSubview:referButton];
//}
//
//
//
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return [self.viewModel.bankArr count];
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    HXBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[HXBankListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//        cell.delegate = self;
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.index = indexPath;
//    cell.model = [self.viewModel.bankArr objectAtIndex:indexPath.section];
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 100;
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
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXBankListModel *model = [self.viewModel.bankArr objectAtIndex:indexPath.section];
//    if (model && [model.isdefault isEqualToString:@"1"]) {
//        return NO;
//    }
//    
//    return YES;
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"BtnClick_%zd",indexPath.row);
//    [self delegateCell:indexPath];
//}
//
//#pragma mark -- HXBankDelegate
//-(void)delegateCell:(NSIndexPath *)indexpath {
//    self.indexpath = indexpath;
//    UIActionSheet* action = [[UIActionSheet alloc]
//                             initWithTitle:@"你确定删除此银行卡"
//                             delegate:self
//                             cancelButtonTitle:@"取消"
//                             destructiveButtonTitle:@"删除"
//                             otherButtonTitles:nil];
//    action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//    
//    [action showInView:self.view];
//
//    
//
//}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 0) {
//        HXBankListModel * model = [self.viewModel.bankArr objectAtIndex:self.indexpath.section];
//     [self.viewModel deledateCardWithCardId:model.id returnBlock:^{
//         [self.viewModel.bankArr removeObjectAtIndex:self.indexpath.section];
//         [_tableView reloadData];
//     }];
//        
//        
//    }else {
//       
//    }
//}
//#pragma mark -- 添加银行卡
//
//-(void)authBtnClick {
//    HXAutoBankListViewController *controller = [[HXAutoBankListViewController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//-(void)registerAction {
//    
//    if ([Helper authBool:self.viewModel.authBool]) {
//        [self.viewModel archiveOpenBankBoolWithReturnBlock:^{
//            HXAddBankViewController * bank = [[HXAddBankViewController alloc] init];
//            bank.viewModel.nameStr = self.viewModel.nameStr;
//            bank.viewModel.idCardStr = self.viewModel.idCardNumber;
//            [self.navigationController pushViewController:bank animated:YES];
//        } failureBlock:^{
////            [KeyWindow displayMessage:@"暂时不能添加银行卡"];
//        }];
//        
//    } else {
//    __weak typeof(self) weadSelf = self;
//    [self.viewModel archiveBaseInformationWithReturnBlock:^{
//        __strong __typeof (weadSelf) sself = weadSelf;
//        if (![Helper authBool:sself.viewModel.authBool]) {
//            [[UIAlertTool alloc] showAlertView:sself :@"" :@"请先进行实名认证" :@"取消" :@"去设置" :^{
//                CertificationViewController * certification = [[CertificationViewController alloc] init];
//                [sself.navigationController pushViewController:certification animated:YES];
//                
//            } :^{
//                
//            }];
//            return;
//        }
//        [sself.viewModel archiveOpenBankBoolWithReturnBlock:^{
//            HXAddBankViewController * bank = [[HXAddBankViewController alloc] init];
//            bank.viewModel.nameStr = sself.viewModel.nameStr;
//            bank.viewModel.idCardStr = sself.viewModel.idCardNumber;
//            [sself.navigationController pushViewController:bank animated:YES];
//        } failureBlock:^{
////            [KeyWindow displayMessage:@"暂时不能添加银行卡"];
//        }];
//        
//    }];
//    }
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
