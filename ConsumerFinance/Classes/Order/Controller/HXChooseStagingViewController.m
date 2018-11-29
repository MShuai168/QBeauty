////
////  HXChooseStagingViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/25.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXChooseStagingViewController.h"
//#import "HXChooseStagingTableViewCell.h"
//#import "HXAuthenticationStatusViewController.h"
//#import "HXSignConractViewController.h"
//#import "HXOrderStatusTagView.h"
//
//#import <Masonry/Masonry.h>
//#import <RZDataBinding/RZDataBinding.h>
//#import <UITableView+FDTemplateLayoutCell.h>
//#import <RZDataBinding/RZDataBinding.h>
//
//@interface HXChooseStagingViewController ()<UITableViewDataSource, UITableViewDelegate>
//
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UIView *headerView;
//@property (nonatomic, strong) UIView *footerView;
//@property (nonatomic, strong) UIButton *nextButton;
//@property (nonatomic, strong) UILabel *statusLabel;
//@property (nonatomic, strong) UILabel *commentLabel;
//@property (nonatomic, strong) UILabel *quotaLabel;
//
//@property (nonatomic, strong) UILabel *feeLabel;
//
//@end
//
//@implementation HXChooseStagingViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.title = @"选择分期";
//    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
//
//    [self setUpNavigation];
//    [self setUpTagView];
//    [self setUpNextButton];
//
//    [self bind];
//
//    __weak typeof(self) weadSelf = self;
//    [self.viewModel getOrderStage:^{
//        __strong __typeof (weadSelf) sself = weadSelf;
//        [sself setUpTableView];
//    } withFailureBlock:^{
//
//    }];
//
//}
//
//- (void)bind {
//    [self.viewModel rz_addTarget:self action:@selector(creditTypeChanged) forKeyPathChange:RZDB_KP(HXChooseStagingViewControllerViewModel, creditType)];
//}
//
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
//        _tableView.estimatedRowHeight = 44;
//        _tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        [_tableView registerClass:[HXChooseStagingTableViewCell class] forCellReuseIdentifier:@"HXChooseStagingTableViewCell"];
//    }
//    return _tableView;
//}
//
//- (UILabel *)statusLabel {
//    if (!_statusLabel) {
//        _statusLabel = [[UILabel alloc] init];
//        _statusLabel.text = @"申请专项分期";
//        _statusLabel.font = [UIFont systemFontOfSize:18];
//        _statusLabel.textColor = ColorWithHex(0x4A90E2);
//    }
//    return _statusLabel;
//}
//
//- (UILabel *)commentLabel {
//    if (!_commentLabel) {
//        _commentLabel = [[UILabel alloc] init];
//        _commentLabel.textColor = ColorWithHex(0x999999);
//        _commentLabel.font = [UIFont systemFontOfSize:13];
//        _commentLabel.text = @"专为商户大额消费，审批高效，专款专用";
//    }
//    return _commentLabel;
//}
//
//- (UILabel *)quotaLabel {
//    if (!_quotaLabel) {
//        _quotaLabel = [[UILabel alloc] init];
//        _quotaLabel.font = [UIFont systemFontOfSize:18];
//        _quotaLabel.textColor = ColorWithHex(0xE6BF73);
//        _quotaLabel.text = @"专项额度";
//    }
//    return _quotaLabel;
//}
//
//- (UIView *)headerView {
//    if (!_headerView) {
//        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 209)];
//
//        UIView *statusView = [[UIView alloc] init];
//        statusView.backgroundColor = [UIColor whiteColor];
//        [_headerView addSubview:statusView];
//        [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_headerView).offset(15);
//            make.left.equalTo(_headerView).offset(15);
//            make.right.equalTo(_headerView).offset(-15);
//        }];
//
//        [statusView addSubview:self.statusLabel];
//        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.equalTo(statusView).offset(15);
//            make.right.equalTo(statusView).offset(-15);
//        }];
//
//        [statusView addSubview:self.commentLabel];
//        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(statusView).offset(15);
//            make.right.equalTo(statusView).offset(-15);
//            make.top.equalTo(self.statusLabel.mas_bottom).offset(10);
//            make.bottom.equalTo(statusView).offset(-15);
//        }];
//
//        UIView *orderView = [[UIView alloc] init];
//        orderView.backgroundColor = [UIColor whiteColor];
//        [_headerView addSubview:orderView];
//        [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(_headerView);
//            make.top.equalTo(statusView.mas_bottom).offset(15);
//            make.bottom.equalTo(_headerView).offset(-5);
//        }];
//
//        UILabel *orderNumLabel = [[UILabel alloc] init];
//        [orderView addSubview:orderNumLabel];
//        orderNumLabel.text = @"分期金额(元)";
//        orderNumLabel.font = [UIFont systemFontOfSize:13];
//        orderNumLabel.textColor = ColorWithHex(0x999999);
//        [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(orderView).offset(15);
//            make.top.equalTo(orderView).offset(20);
//            make.size.mas_equalTo(orderNumLabel.intrinsicContentSize);
//        }];
//
//        [orderView addSubview:self.quotaLabel];
//        [self.quotaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(orderView).offset(-15);
//            make.top.equalTo(orderView).offset(15);
//            make.size.mas_equalTo(self.quotaLabel.intrinsicContentSize);
//        }];
//
//        UILabel *createLabel = [[UILabel alloc] init];
//        [orderView addSubview:createLabel];
//        createLabel.text = [NSString stringWithFormat:@"¥%@",[NSString stringFormatterWithCurrency:self.viewModel.stageAmount]];
//        createLabel.font = [UIFont systemFontOfSize:35];
//        createLabel.textColor = ColorWithHex(0xE6BF73);
//        [createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(orderView).offset(15);
//            make.top.equalTo(orderNumLabel.mas_bottom).offset(15);
//            make.bottom.equalTo(orderView).offset(-10);
//            make.right.equalTo(orderView).offset(-15);
//        }];
//
//
//    }
//    return _headerView;
//}
//
//- (void)setUpNextButton {
//    self.nextButton = [[UIButton alloc] init];
//    [self.nextButton addTarget:self action:@selector(nextOrder:) forControlEvents:UIControlEventTouchUpInside];
//    self.nextButton.layer.cornerRadius = 2;
//    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
//    self.nextButton.backgroundColor = ColorWithHex(0x4A90E2);
//    [self.view addSubview:self.nextButton];
//    if (iphone_X) {
//        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view).offset(15);
//            make.bottom.equalTo(self.view).offset(-30);
//            make.height.mas_equalTo(50);
//            make.right.equalTo(self.view).offset(-15);
//        }];
//    } else {
//        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view).offset(15);
//            make.bottom.equalTo(self.view).offset(-15);
//            make.height.mas_equalTo(50);
//            make.right.equalTo(self.view).offset(-15);
//        }];
//    }
//
//}
//
////- (UIView *)footerView {
////    if (!_footerView) {
////        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
////
////
////        self.nextButton = [[UIButton alloc] init];
////        [self.nextButton addTarget:self action:@selector(nextOrder:) forControlEvents:UIControlEventTouchUpInside];
////        self.nextButton.layer.cornerRadius = 2;
////        [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
////        self.nextButton.backgroundColor = ColorWithHex(0x4A90E2);
////        [_footerView addSubview:self.nextButton];
////        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.left.equalTo(_footerView).offset(15);
////            make.bottom.equalTo(_footerView).offset(-15);
////            make.height.mas_equalTo(50);
////            make.right.equalTo(_footerView).offset(-15);
////        }];
////    }
////    return _footerView;
////}
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
//- (void)setUpTableView {
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(35);
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.nextButton.mas_top).offset(-15);
//    }];
//
//    self.tableView.tableHeaderView = self.headerView;
//
//    if (self.viewModel.stagePeriods.count > 0) {
//        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
//        self.viewModel.selectedStagingModel = [HXStagingDetailModel mj_objectWithKeyValues:self.viewModel.stagePeriods[0]];
//    }
//}
//
//- (void)setUpTagView {
//    HXOrderStatusTagView *statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"选择分期",@"认证资料",@"开户绑卡",@"签署合同"] selectedIndex:0 isFirst:NO];
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.viewModel.stagePeriods.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 70;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 54;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 20;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor whiteColor];
//
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.textColor = ColorWithHex(0x333333);
//    titleLabel.font = [UIFont systemFontOfSize:14];
//    titleLabel.text = @"选择期数";
//    [headerView addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headerView);
//        make.bottom.equalTo(headerView.mas_bottom).offset(-1);
//        make.left.equalTo(headerView).offset(15);
//        make.right.equalTo(headerView).offset(-15);
//    }];
//
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = ColorWithHex(0xE6E6E6);
//    [headerView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(headerView).offset(15);
//        make.right.equalTo(headerView);
//        make.bottom.equalTo(headerView).offset(-10);
//        make.height.mas_equalTo(0.5);
//    }];
//
//    return headerView;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footerView = [[UIView alloc] init];
//    footerView.backgroundColor = [UIColor whiteColor];
//
//    return footerView;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXChooseStagingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXChooseStagingTableViewCell"];
//    if (!cell) {
//        cell = [[HXChooseStagingTableViewCell alloc] init];
//    }
//
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    HXStagingDetailModel *model = [HXStagingDetailModel mj_objectWithKeyValues:self.viewModel.stagePeriods[indexPath.row]];
//    if (model) {
//        cell.model = model;
//    }
//
//    return cell;
//
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXChooseStagingTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selected = YES;
//
//    HXStagingDetailModel *model = [HXStagingDetailModel mj_objectWithKeyValues:self.viewModel.stagePeriods[indexPath.row]];
//
//    self.viewModel.selectedStagingModel = model;
//}
//
//#pragma mark - Private Methods
//
//- (void)creditTypeChanged {
//    if ([self.viewModel.creditType isEqualToString:@"20"]) {
//        self.statusLabel.text = @"使用信用额度";
//        self.commentLabel.text = [NSString stringWithFormat:@"可用信用额度：¥%@",[NSString stringFormatterWithCurrency:[self.viewModel.credits floatValue]]];
//        self.quotaLabel.text = @"信用额度";
//        return;
//    }
//
//    self.quotaLabel.text = @"专项额度";
//    self.statusLabel.text = @"申请专项分期";
//    self.commentLabel.text = @"专为商户大额消费，审批高效，专款专用";
//}
//
//- (void)nextOrder:(UIButton *)button {
//    __weak typeof(self) weadSelf = self;
//    [self.viewModel nextOrder:^{
//        __strong __typeof (weadSelf) sself = weadSelf;
//        [sself.viewModel.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//            [sself.navigationController pushViewController:controller animated:YES];
//        } with:sself.viewModel.orderType];
//    } withFailureBlock:^{
//
//    }];
//
//}
//
//- (void)backButtonClick:(UIButton *)button {
//    if ([self.navigationController.viewControllers objectAtIndex:1]) {
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//        return;
//    }
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end
