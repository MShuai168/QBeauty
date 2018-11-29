////
////  HXOrderViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/13.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXOrderViewController.h"
//#import "HXOrderViewModel.h"
//#import "HXOrderTableViewCell.h"
//#import "HXConfirmOrderViewController.h"
//#import "HXConfirmOrderViewControllerViewModel.h"
//#import "HXOrderInfo.h"
//#import "HXChooseStagingViewController.h"
//#import "HXAuthenticationStatusViewController.h"
//#import "HXSignConractViewController.h"
//#import "HXPayViewController.h"
//#import "HXUploadCertificateViewController.h"
//#import "HXOrderSucessViewController.h"
//#import "HXDataAuthenticationViewModel.h"
//
//#import <RZDataBinding/RZDataBinding.h>
//#import <MJRefresh/MJRefresh.h>
//
//@interface HXOrderViewController ()<UITableViewDataSource, UITableViewDelegate>
//
//@property (nonatomic, strong) HXOrderViewModel *viewModel;
//
//@property (nonatomic, strong) UIView *tabView;
//@property (nonatomic, strong) UIView *tagLineView;
//@property (nonatomic, strong) UIView *noDataView;
//
//@property (nonatomic, strong) UITableView *allTableView;
//@property (nonatomic, strong) UITableView *inProgressTableView;
//@property (nonatomic, strong) UITableView *sucessTableView;
//
//@end
//
//@implementation HXOrderViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.title = @"订单";
//    
//    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
//    
//    self.viewModel = [[HXOrderViewModel alloc] initWithController:self];
//    
//    [self bind];
//    
//    [self setUpNavigation];
//    [self setUpAllTableView];
//    [self setUpNoDataView];
//    
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    self.viewModel.paseSize = 1;
//    [self.viewModel getOrderList];
//}
//
//#pragma mark UI
//
//- (void)setUpNavigation {
//    [self setNavigationBarBackgroundImage];
//    
//    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
//    
//}
//
//- (void)setUpNoDataView {
//    [self.view addSubview:self.noDataView];
//    
//    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top);
//        make.left.right.bottom.equalTo(self.view);
//    }];
//}
//
//- (void)setUpAllTableView {
//    self.allTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    self.allTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMore)];
//    [self.view addSubview:self.allTableView];
//    [self.allTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.bottom.equalTo(self.view);
//    }];
//    
//}
//
//#pragma mark - 懒加载
//
//- (UITableView *)allTableView {
//    if (!_allTableView) {
//        _allTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
//        _allTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _allTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
//        _allTableView.tag = 0;
//        _allTableView.estimatedRowHeight = 0;
//        _allTableView.estimatedSectionHeaderHeight = 0;
//        _allTableView.estimatedSectionFooterHeight = 0;
//        _allTableView.dataSource = self;
//        _allTableView.delegate = self;
//        [_allTableView registerClass:[HXOrderTableViewCell class] forCellReuseIdentifier:@"allTableViewCell"];
//    }
//    return _allTableView;
//}
//
//- (UITableView *)inProgressTableView {
//    if (!_inProgressTableView) {
//        _inProgressTableView = [[UITableView alloc] init];
//        _inProgressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _inProgressTableView.tag = 1;
//        _inProgressTableView.dataSource = self;
//        _inProgressTableView.delegate = self;
//        _inProgressTableView.estimatedRowHeight = 0;
//        _inProgressTableView.estimatedSectionHeaderHeight = 0;
//        _inProgressTableView.estimatedSectionFooterHeight = 0;
//        [_inProgressTableView registerClass:[HXOrderTableViewCell class] forCellReuseIdentifier:@"inProgressTableViewCell"];
//    }
//    return _inProgressTableView;
//}
//
//- (UITableView *)sucessTableView {
//    if (!_sucessTableView) {
//        _sucessTableView = [[UITableView alloc] init];
//        _sucessTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _sucessTableView.tag = 2;
//        _sucessTableView.estimatedRowHeight = 0;
//        _sucessTableView.estimatedSectionHeaderHeight = 0;
//        _sucessTableView.estimatedSectionFooterHeight = 0;
//        _sucessTableView.dataSource = self;
//        _sucessTableView.delegate = self;
//        [_sucessTableView registerClass:[HXOrderTableViewCell class] forCellReuseIdentifier:@"sucessTableViewCell"];
//    }
//    return _sucessTableView;
//}
//
//- (UIView *)tagLineView {
//    if (!_tagLineView) {
//        _tagLineView = [[UIView alloc] init];
//        _tagLineView.backgroundColor = ComonBackColor;
//    }
//    return _tagLineView;
//}
//
//- (UIView *)noDataView {
//    if (!_noDataView) {
//        _noDataView = [[UIView alloc] init];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodingdan"]];
//        [_noDataView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(_noDataView);
//            make.top.equalTo(_noDataView).offset(140);
//            make.size.mas_equalTo([UIImage imageNamed:@"nodingdan"].size);
//        }];
//        
//        UILabel *label = [[UILabel alloc] init];
//        label.text = @"亲，您还没有订单哦～";
//        label.font = [UIFont systemFontOfSize:14];
//        label.textColor = ColorWithHex(0x999999);
//        [_noDataView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(_noDataView);
//            make.top.equalTo(imageView.mas_bottom).offset(30);
//            make.size.mas_equalTo(label.intrinsicContentSize);
//        }];
//    }
//    return _noDataView;
//}
//
//- (UIView *)tabView {
//    if (!_tabView) {
//        _tabView = [[UIView alloc] init];
//        _tabView.backgroundColor = [UIColor whiteColor];
//    }
//    return _tabView;
//}
//
//- (void)bind {
//    [self.viewModel rz_addTarget:self action:@selector(orderStatusChange) forKeyPathChange:RZDB_KP(HXOrderViewModel, refreshTable)];
//}
//
//#pragma mark UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSInteger numberOfSections = 0;
//    numberOfSections = self.viewModel.allStatusorderList.count;
//    return numberOfSections;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 5;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
////    if (section == self.viewModel.allStatusorderList.count - 1) {
////        return 100;
////    }
//    return 0.5;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 137;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXOrderTableViewCell *cell = nil;
//    
//    cell = [tableView dequeueReusableCellWithIdentifier:@"allTableViewCell"];
//    if (!cell) {
//        cell = [[HXOrderTableViewCell alloc] init];
//    }
//    
//    cell.viewModel = self.viewModel.allStatusorderList[indexPath.section];
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    return cell;
//}
//
////- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
////    UIView *footerView = [[UIView alloc] init];
////    if (section == self.viewModel.allStatusorderList.count - 1) {
////        footerView.backgroundColor = ColorWithHex(0xF5F7F8);
////        UILabel *label = [[UILabel alloc] init];
////        label.font = [UIFont systemFontOfSize:12];
////        label.textColor = ColorWithHex(0x999999);
////        label.text = @"亲，只有这么多了";
////        [footerView addSubview:label];
////        [label mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.center.equalTo(footerView);
////            make.size.mas_equalTo(label.intrinsicContentSize);
////        }];
////    }
////    return footerView;
////}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXOrderTableViewCellViewModel *cellViewModel = [[HXOrderTableViewCellViewModel alloc] init];
//    cellViewModel = self.viewModel.allStatusorderList[indexPath.section];
//    [self.viewModel getOrderDetailWithHXOrderTableViewCellViewModel:cellViewModel withReturnOrderInfoBlock:^(HXOrderInfo *orderInfo) {
//        [orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//            [self.navigationController pushViewController:controller animated:YES];
//        } with:cellViewModel.orderType];
//        
//    } withFailureBlock:^{
//        
//    }];
//    
//}
//
//#pragma mark - Private
//
//- (void)loadMoreData {
//    self.allTableView.mj_footer.state = MJRefreshStateIdle;
//    self.viewModel.paseSize = 1;
//    [self.viewModel getOrderList];
//    [self.allTableView.mj_header endRefreshing];
//}
//-(void)refreshMore {
//    self.viewModel.paseSize ++;
//    [self.viewModel getOrderList];
//    [self.allTableView.mj_footer endRefreshing];
//    
//}
//
//- (void)orderStatusChange {
//    self.noDataView.hidden = self.viewModel.allStatusorderList.count>0;
//    if (self.viewModel.allStatusorderList.count%10!=0) {
//        
//        self.allTableView.mj_footer.state = MJRefreshStateNoMoreData;
//    }else {
//      self.allTableView.mj_footer.state = MJRefreshStateIdle;
//    }
//    [self.allTableView reloadData];
//}
//
//- (void)backButtonClick:(UIButton *)button {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void)dealloc {
//    NSLog(@"HXOrderViewController dealloc");
//}
//
//@end
