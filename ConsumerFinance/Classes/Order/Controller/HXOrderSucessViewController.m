////
////  HXOrderSucessViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/4/26.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXOrderSucessViewController.h"
//#import "HXOrderStatusTagView.h"
//#import "HXConfirmOrderTableViewCell.h"
//#import "HXBillViewController.h"
//#import "HXBillingdetailsViewController.h"
//
//#import <UITableView+FDTemplateLayoutCell.h>
//
//@interface HXOrderSucessViewController ()<UITableViewDataSource, UITableViewDelegate>
//
//@property (nonatomic, strong) UIView *approveAmountView;// 审批金额
//@property (nonatomic, strong) UILabel *amountLabel;
//@property (nonatomic, strong) UIView *successView;
//@property (nonatomic, strong) UIButton *billButton; // 查看账单
//@property (nonatomic, strong) UIView *footerView;
//@property (nonatomic, strong) UIView *headerView;
//@property (nonatomic, strong) UILabel *sucessValueLabel;
//
//@property (nonatomic, strong) UITableView *tableView;
//
//@end
//
//@implementation HXOrderSucessViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.title = @"订单完成";
//    
//    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
//    
//    [self setUpNavigation];
//    [self setUpTagView];
//    [self setUpTableView];
//    
//    [self request];
//    [self archiveCompleteTime];
//}
//
//- (void)request {
//    
//    NSDictionary *head = @{@"tradeCode" : @"0136",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{
//                           @"userUuid":userUuid,
//                           @"orderNo":self.viewModel.orderInfo.orderNo.length!=0?self.viewModel.orderInfo.orderNo:@""
//                           };
//    
//    [MBProgressHUD showMessage:nil toView:nil];
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         self.billButton.hidden = NO;
//                                                     } else {
//                                                         self.billButton.hidden = YES;
//                                                     }
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     self.billButton.hidden = YES;
//                                                 }];
//    
//}
//-(void)archiveCompleteTime {
//    NSDictionary *head = @{};
//    
//    switch (self.viewModel.orderType) {
//        case orderTypeCommon:
//            // 通用订单
//            head = @{@"tradeCode" : @"0125",
//                     @"tradeType" : @"appService"};
//            break;
//        case orderTypeTenancy:
//            // 租房
//            head = @{@"tradeCode" : @"0126",
//                     @"tradeType" : @"appService"};
//            
//            break;
//        case orderTypeHoneymoon:
//            // 蜜月
//            head = @{@"tradeCode" : @"0128",
//                     @"tradeType" : @"appService"};
//            
//            break;
//        case orderTypeCarBuy: case orderTypeCarRent:
//            // 汽车
//            head = @{@"tradeCode" : @"0127",
//                     @"tradeType" : @"appService"};
//            
//            break;
//            
//        default:
//            break;
//    }
//    
//    NSDictionary *body = @{@"id" : self.viewModel.orderInfo.id.length!=0?self.viewModel.orderInfo.id:@"",
//                           @"userId" :[AppManager manager].userInfo.userId
//                           };
//    
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     NSDictionary *dic = [[NSDictionary alloc] init];
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         
//                                                         dic = [object.body objectForKey:@"frontOrder"];
//                                                         HXOrderInfo *orderInfo = [HXOrderInfo mj_objectWithKeyValues:dic];
//                                                         self.sucessValueLabel.text = orderInfo.upTime.length!=0?orderInfo.upTime:@"";
//                                                         // TODO: 如果没有取到订单详情，交互行为
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     
//                                                 }];
//}
//
//- (UIView *)headerView {
//    if (!_headerView) {
//        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 237)];
//        [self setUpAmountView];
//        [self setUpSucessView];
//        [self setUpOrderView];
//    }
//    return _headerView;
//}
//
//- (UIView *)approveAmountView {
//    if (!_approveAmountView) {
//        _approveAmountView = [[UIView alloc] init];
//        _approveAmountView.backgroundColor = ColorWithHex(0xE6BF73);
//        
//        UILabel *label = [[UILabel alloc] init];
//        [_approveAmountView addSubview:label];
//        label.textColor = [UIColor whiteColor];
//        label.text = @"审批金额(元)";
//        label.font = [UIFont systemFontOfSize:13];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_approveAmountView).offset(15);
//            make.top.equalTo(_approveAmountView).offset(20);
//            make.size.mas_equalTo(label.intrinsicContentSize);
//        }];
//    }
//    return _approveAmountView;
//}
//
//- (UILabel *)amountLabel {
//    if (!_amountLabel) {
//        _amountLabel = [[UILabel alloc] init];
//        _amountLabel.font = [UIFont systemFontOfSize:35];
//        _amountLabel.textColor = [UIColor whiteColor];
//        _amountLabel.text = [NSString stringWithFormat:@"¥ %@", self.viewModel.orderInfo.approvalAmount];
//    }
//    return _amountLabel;
//}
//
//- (UIView *)successView {
//    if (!_successView) {
//        _successView = [[UIView alloc] init];
//        _successView.backgroundColor = [UIColor whiteColor];
//        
//        UIImage *image = [UIImage imageNamed:@"orderSuccess"];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [_successView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_successView).offset(15);
//            make.centerY.equalTo(_successView);
//            make.size.mas_equalTo(image.size);
//        }];
//        
//        UILabel *label = [[UILabel alloc] init];
//        label.text = @"分期成功";
//        label.textColor = ColorWithHex(0x4990E2);
//        label.font = [UIFont systemFontOfSize:13];
//        [_successView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(imageView.mas_right).offset(5);
//            make.centerY.equalTo(_successView);
//            make.size.mas_equalTo(label.intrinsicContentSize);
//        }];
//    }
//    return _successView;
//}
//
//- (UIView *)footerView {
//    if (!_footerView) {
//        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 104)];
//        
//        [self.billButton addTarget:self action:@selector(billButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.billButton setTitle:@"查看账单" forState:UIControlStateNormal];
//        self.billButton.backgroundColor = [UIColor whiteColor];
//        [self.billButton setTitleColor:ColorWithHex(0x4A90E2) forState:UIControlStateNormal];
//        self.billButton.layer.cornerRadius = 2;
//        [_footerView addSubview:self.billButton];
//        [self.billButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_footerView).offset(15);
//            make.right.bottom.equalTo(_footerView).offset(-15);
//            make.height.mas_equalTo(50);
//        }];
//    }
//    return _footerView;
//}
//
//- (UIButton *)billButton {
//    if (!_billButton) {
//        _billButton = [[UIButton alloc] init];
//        _billButton.hidden = YES;
//    }
//    return _billButton;
//}
//
//- (void)setUpOrderView {
//    UIView *orderView = [[UIView alloc] init];
//    orderView.backgroundColor = [UIColor whiteColor];
//    [self.headerView addSubview:orderView];
//    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.headerView);
//        make.top.equalTo(self.successView.mas_bottom).offset(10);
//        make.height.mas_equalTo(79);
//    }];
//    
//    UILabel *orderNumLabel = [[UILabel alloc] init];
//    [orderView addSubview:orderNumLabel];
//    orderNumLabel.text = @"订单编号：";
//    orderNumLabel.font = [UIFont systemFontOfSize:11];
//    orderNumLabel.textColor = ColorWithHex(0x999999);
//    [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(orderView).offset(15);
//        make.top.equalTo(orderView).offset(10);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(11);
//    }];
//    
//    UILabel *orderNumValueLabel = [[UILabel alloc] init];
//    [orderView addSubview:orderNumValueLabel];
//    orderNumValueLabel.text = self.viewModel.orderInfo.orderNo;
//    orderNumValueLabel.font = [UIFont systemFontOfSize:11];
//    orderNumValueLabel.textColor = ColorWithHex(0x151515);
//    [orderNumValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(orderNumLabel.mas_right).offset(0);
//        make.top.equalTo(orderNumLabel.mas_top);
//        make.right.equalTo(orderView).offset(-15);
//        make.height.mas_equalTo(11);
//    }];
//    
//    UILabel *createLabel = [[UILabel alloc] init];
//    [orderView addSubview:createLabel];
//    createLabel.text = @"创建时间：";
//    createLabel.font = [UIFont systemFontOfSize:11];
//    createLabel.textColor = ColorWithHex(0x999999);
//    [createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(orderView).offset(15);
//        make.top.equalTo(orderNumLabel.mas_bottom).offset(5);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(11);
//    }];
//    
//    UILabel *createValueLabel = [[UILabel alloc] init];
//    [orderView addSubview:createValueLabel];
//    createValueLabel.text = self.viewModel.orderInfo.createdTime;
//    createValueLabel.font = [UIFont systemFontOfSize:11];
//    createValueLabel.textColor = ColorWithHex(0x151515);
//    [createValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(createLabel.mas_right).offset(0);
//        make.top.equalTo(createLabel.mas_top);
//        make.right.equalTo(orderView).offset(-15);
//        make.height.mas_equalTo(11);
//    }];
//    
//    
//    UILabel *passLabel = [[UILabel alloc] init];
//    [orderView addSubview:passLabel];
//    passLabel.text = @"审核通过：";
//    passLabel.font = [UIFont systemFontOfSize:11];
//    passLabel.textColor = ColorWithHex(0x999999);
//    [passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(orderView).offset(15);
//        make.top.equalTo(createLabel.mas_bottom).offset(5);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(11);
//    }];
//    
//    UILabel *passLabelValueLabel = [[UILabel alloc] init];
//    [orderView addSubview:passLabelValueLabel];
//    passLabelValueLabel.text = self.viewModel.orderInfo.approveTime;
//    passLabelValueLabel.font = [UIFont systemFontOfSize:11];
//    passLabelValueLabel.textColor = ColorWithHex(0x151515);
//    [passLabelValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(passLabel.mas_right).offset(0);
//        make.top.equalTo(passLabel.mas_top);
//        make.right.equalTo(orderView).offset(-15);
//        make.height.mas_equalTo(11);
//    }];
//    
//    
//    UILabel *sucessLabel = [[UILabel alloc] init];
//    [orderView addSubview:sucessLabel];
//    sucessLabel.text = @"订单完成：";
//    sucessLabel.font = [UIFont systemFontOfSize:11];
//    sucessLabel.textColor = ColorWithHex(0x999999);
//    [sucessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(orderView).offset(15);
//        make.bottom.equalTo(orderView).offset(-10);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(11);
//    }];
//
//    UILabel *sucessValueLabel = [[UILabel alloc] init];
//    self.sucessValueLabel = sucessValueLabel;
//    [orderView addSubview:sucessValueLabel];
//    sucessValueLabel.text = self.viewModel.orderInfo.upTime;
//    sucessValueLabel.font = [UIFont systemFontOfSize:11];
//    sucessValueLabel.textColor = ColorWithHex(0x151515);
//    [sucessValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(sucessLabel.mas_right).offset(0);
//        make.top.equalTo(sucessLabel.mas_top);
//        make.bottom.equalTo(orderView).offset(-10);
//        make.right.equalTo(orderView).offset(-15);
//        make.height.mas_equalTo(11);
//    }];
//}
//
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] init];
//        _tableView.estimatedRowHeight = 44;
//        _tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        [_tableView registerClass:[HXConfirmOrderTableViewCell class] forCellReuseIdentifier:@"HXConfirmOrderTableViewCell"];
//    }
//    return _tableView;
//}
//
//- (void)setUpTableView {
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(35);
//        make.left.right.bottom.equalTo(self.view);
//    }];
//    
//    self.tableView.tableHeaderView = self.headerView;
//    self.tableView.tableFooterView = self.footerView;
//}
//
//- (void)setUpSucessView {
//    [self.headerView addSubview:self.successView];
//    [self.successView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.equalTo(self.headerView);
//        make.top.equalTo(self.approveAmountView.mas_bottom);
//        make.height.mas_equalTo(40);
//    }];
//}
//
//- (void)setUpAmountView {
//    [self.headerView addSubview:self.approveAmountView];
//    [self.approveAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.headerView).offset(0);
//        make.left.right.equalTo(self.headerView);
//        make.height.mas_equalTo(103);
//    }];
//    
//    [self.approveAmountView addSubview:self.amountLabel];
//    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.approveAmountView).offset(15);
//        make.bottom.equalTo(self.approveAmountView).offset(-20);
//        make.right.equalTo(self.approveAmountView).offset(-15);
//        make.top.equalTo(self.approveAmountView).offset(48);
//    }];
//}
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
//- (void)setUpTagView {
//    HXOrderStatusTagView *statusTagView;
//    if ([self.viewModel.orderInfo.isYimei boolValue]) {
//         statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"签署合同",@"商户确认",@"服务费",@"订单完成"] selectedIndex:3 isFirst:NO];
//    }else {
//        if ([self.viewModel.orderInfo.distinguish isEqualToString:@"20"]) {
//            statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"认证资料",@"开户绑卡",@"签署合同",@"订单完成"] selectedIndex:3 isFirst:NO];
//        }else {
//         statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"开户绑卡",@"签署合同",@"服务费",@"订单完成"] selectedIndex:3 isFirst:NO];
//        }
//    }
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//}
//
//#pragma mark - UITableViewDataSource UITableViewDelegate
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 3;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    if (section == 0) {
//        return self.viewModel.projects.count;
//    } else if (section == 1) {
//        return self.viewModel.hireInfos.count;
//    } else {
//        return self.viewModel.eachPays.count;
//    }
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"HXConfirmOrderTableViewCell" cacheByIndexPath:indexPath configuration:^(HXConfirmOrderTableViewCell *cell) {
//        [self configCell:cell indexPath:indexPath tableView:tableView];
//    }];
//    
//    return height;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0;
//    }
//    return 1;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor whiteColor];
//    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = ColorWithHex(0xE6E6E6);
//    [headerView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(headerView).offset(15);
//        make.right.equalTo(headerView);
//        make.bottom.equalTo(headerView);
//        make.height.mas_equalTo(0.5);
//    }];
//    
//    return headerView;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXConfirmOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXConfirmOrderTableViewCell"];
//    if (!cell) {
//        cell = [[HXConfirmOrderTableViewCell alloc] init];
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    [self configCell:cell indexPath:indexPath tableView:tableView];
//    
//    return cell;
//    
//}
//
//- (void)configCell:(HXConfirmOrderTableViewCell *)cell indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
//    
//    HXConfirmOrderTableViewCellViewModel *viewModel = [[HXConfirmOrderTableViewCellViewModel alloc] init];
//    switch (indexPath.section) {
//        case 0:{
//            NSDictionary *dic = self.viewModel.projects[indexPath.row];
//            viewModel.title = dic.allKeys.firstObject;
//            viewModel.rightValue = dic.allValues.firstObject;
//            
//        }
//            break;
//        case 1: {
//            NSDictionary *dic = self.viewModel.hireInfos[indexPath.row];
//            viewModel.title = dic.allKeys.firstObject;
//            viewModel.rightValue = dic.allValues.firstObject;
//            
//        }
//            break;
//        case 2: {
//            NSDictionary *dic = self.viewModel.eachPays[indexPath.row];
//            viewModel.title = dic.allKeys.firstObject;
//            viewModel.rightValue = dic.allValues.firstObject;
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//    cell.viewModel = viewModel;
//}
//
//#pragma mark - Private
//
//- (void)billButtonClick:(UIButton *)button {
//    // 查看账单
//    HXBillingdetailsViewController * bill = [[HXBillingdetailsViewController alloc] init];
//    bill.viewModel.orderNo = self.viewModel.orderInfo.orderNo;
//    [self.navigationController pushViewController:bill animated:YES];
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
//}
//
//@end
