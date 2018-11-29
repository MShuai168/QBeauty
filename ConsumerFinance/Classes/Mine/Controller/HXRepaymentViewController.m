////
////  HXRepaymentViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/6/13.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXRepaymentViewController.h"
//#import "HXRepaymentCell.h"
//#import "HXRepaymentViewModel.h"
//
//@interface HXRepaymentViewController ()<UITableViewDelegate,UITableViewDataSource>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong)HXRepaymentViewModel * viewModel;
//@end
//
//@implementation HXRepaymentViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXRepaymentViewModel alloc] init];
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
//    self.title = @"还款记录";
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
//}
//-(void)request {
//    
//    [self.viewModel archiveRepaymentReturnValue:^{
//        [_tableView reloadData];
//        if (self.viewModel.repaymentArr.count == 0) {
//            [self creatStateViewWithType:6];
//        }else {
//            [self.viewModel.state removeFromSuperview];
//        }
//    } faile:^{
//        [self creatStateViewWithType:0];
//    }];
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.viewModel.repaymentArr.count;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    HXRepaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[HXRepaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//    }
//    HXRepaymentModel * model = [self.viewModel.repaymentArr objectAtIndex:indexPath.section];
//    cell.model = model;
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 103.5;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.1;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 10;
//}
//-(void)creatStateViewWithType:(NSInteger)type{
//    self.viewModel.state = [[HXStateView alloc] initWithalertShow:type backView:self.view offset:0];
//    self.viewModel.state.submitBlock = ^{
//
//    };
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
