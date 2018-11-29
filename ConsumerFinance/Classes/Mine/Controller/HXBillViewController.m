//
////
////  HXBillViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/17.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBillViewController.h"
//#import "HXBillCell.h"
//#import "HXBillingdetailsViewController.h"
//#import "HXRepaymentViewController.h"
//#import "HXBillViewModel.h"
//
//@interface HXBillViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
//    UITableView *_tableView;
//}
//@property (nonatomic,strong)HXBillViewModel * viewModel;
//@end
//
//@implementation HXBillViewController
//-(id)init {
//    self =[super init];
//    if (self) {
//        self.viewModel = [[HXBillViewModel alloc] initWithController:self];
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
//}
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self request];
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"账单";
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//    self.view.backgroundColor = HXRGB(255, 255, 255);
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"还款记录" forState:UIControlStateNormal];
//    [button setTitleColor:ComonTitleColor forState:UIControlStateNormal];
//    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    // 设置尺寸
//    CGSize fontSize = [@"还款记录" sizeWithConstrainedSize:CGSizeMake(MAXFLOAT, 44)
//                                                font:[UIFont systemFontOfSize:16]
//                                         lineSpacing:0];
//    button.bounds   = (CGRect){CGPointZero, fontSize};
//    
//    [button addTarget:self action:@selector(repaymentAction)
//     forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = item;
//}
//-(void) hiddeKeyBoard{
//    
//    [self.view endEditing:YES];
//    
//}
//-(void)request {
//    [self.viewModel archiveBillInformationWithReturnBlock:^{
//        [_tableView reloadData];
//        if (self.viewModel.billArr.count == 0) {
//            [self.viewModel showItemView:self.view type:5];
//        }else {
//            [self.viewModel.stateView removeFromSuperview];
//        }
//        
//    } fail:^{
//        [self creatStateView];
//        [self.viewModel showItemView:self.view type:0];
//    }];
//    
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
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.viewModel.billArr.count;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    HXBillCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[HXBillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    cell.model = [self.viewModel.billArr objectAtIndex:indexPath.section];
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 76;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 10;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 0.1;
//}
//
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    HXBillingdetailsViewController * bill = [[HXBillingdetailsViewController alloc] init];
//    HXBillModel * model = [self.viewModel.billArr objectAtIndex:indexPath.section];
//    bill.viewModel.orderNo = model.orderNo;
//    [self.navigationController pushViewController:bill animated:YES];
//}
//-(void)repaymentAction {
//    HXRepaymentViewController * repayment = [[HXRepaymentViewController alloc] init];
//    [self.navigationController pushViewController:repayment animated:YES];
//}
//-(void)creatStateView {
////    HXStateView * state = [[HXStateView alloc] initWithBackView:self.view titleName:@"亲，您无待还账单" imageName:@"nodingdan"];
////    state.submitBlock = ^{
////        
////    };
//}
//
//- (void)onBack {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
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
