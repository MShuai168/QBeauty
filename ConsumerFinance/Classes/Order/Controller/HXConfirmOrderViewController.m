//
//  HXConfirmOrderViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/20.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXConfirmOrderViewController.h"
#import "HXConfirmOrderTableViewCell.h"
#import "HXConfirmOrderViewControllerViewModel.h"
#import "HXChooseStagingViewController.h"
#import "HXOrderStatusTagView.h"

#import <Masonry/Masonry.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import <RZDataBinding/RZDataBinding.h>

@interface HXConfirmOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *errorButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation HXConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    [self.viewModel paddingData:nil];
    
    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    
    [self setUpNavigation];
    
    [self setUpTableView];
    
    [self setUpTagView];
    
    [self bind];
}

- (void)bind {
    [self.viewModel.orderInfo rz_addTarget:self action:@selector(orderInfoChanged) forKeyPathChange:RZDB_KP(HXConfirmOrderViewControllerViewModel, orderInfo) callImmediately:self];
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.estimatedRowHeight = 44;
        _tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerClass:[HXConfirmOrderTableViewCell class] forCellReuseIdentifier:@"HXConfirmOrderTableViewCell"];
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 153)];
        
        UIView *statusView = [[UIView alloc] init];
        statusView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:statusView];
        [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView).offset(15);
            make.left.equalTo(_headerView).offset(15);
            make.right.equalTo(_headerView).offset(-15);
        }];
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.text = @"待您确认...";
        self.statusLabel.font = [UIFont systemFontOfSize:18];
        self.statusLabel.textColor = ColorWithHex(0x4A90E2);
        [statusView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(statusView).offset(15);
            make.right.equalTo(statusView).offset(-15);
        }];
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.textColor = ColorWithHex(0x999999);
        self.commentLabel.font = [UIFont systemFontOfSize:13];
        self.commentLabel.text = @"请认真核实商户销售人员填写的订单";
        [statusView addSubview:self.commentLabel];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(statusView).offset(15);
            make.right.equalTo(statusView).offset(-15);
            make.top.equalTo(self.statusLabel.mas_bottom).offset(10);
            make.bottom.equalTo(statusView).offset(-15);
        }];
        
        
        UIView *orderView = [[UIView alloc] init];
        orderView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:orderView];
        [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_headerView);
            make.top.equalTo(statusView.mas_bottom).offset(15);
            make.bottom.equalTo(_headerView).offset(-5);
            make.height.mas_equalTo(47);
        }];
        
        UILabel *orderNumLabel = [[UILabel alloc] init];
        [orderView addSubview:orderNumLabel];
        orderNumLabel.text = @"订单编号：";
        orderNumLabel.font = [UIFont systemFontOfSize:11];
        orderNumLabel.textColor = ColorWithHex(0x999999);
        [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderView).offset(15);
            make.top.equalTo(orderView).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(11);
        }];
        
        UILabel *orderNumValueLabel = [[UILabel alloc] init];
        [orderView addSubview:orderNumValueLabel];
        orderNumValueLabel.text = self.viewModel.orderInfo.orderNo;
        orderNumValueLabel.font = [UIFont systemFontOfSize:11];
        orderNumValueLabel.textColor = ColorWithHex(0x151515);
        [orderNumValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderNumLabel.mas_right).offset(0);
            make.top.equalTo(orderNumLabel.mas_top);
            make.right.equalTo(orderView).offset(-15);
            make.height.mas_equalTo(11);
        }];
        
        UILabel *createLabel = [[UILabel alloc] init];
        [orderView addSubview:createLabel];
        createLabel.text = @"创建时间：";
        createLabel.font = [UIFont systemFontOfSize:11];
        createLabel.textColor = ColorWithHex(0x999999);
        [createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderView).offset(15);
            make.top.equalTo(orderNumLabel.mas_bottom).offset(5);
            make.bottom.equalTo(orderView).offset(-10);
            make.width.mas_equalTo(60);
        }];
        
        UILabel *createValueLabel = [[UILabel alloc] init];
        [orderView addSubview:createValueLabel];
        createValueLabel.text = self.viewModel.orderInfo.createdTime;
        createValueLabel.font = [UIFont systemFontOfSize:11];
        createValueLabel.textColor = ColorWithHex(0x151515);
        [createValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(createLabel.mas_right).offset(0);
            make.top.equalTo(createLabel.mas_top);
            make.bottom.equalTo(orderView).offset(-10);
            make.right.equalTo(orderView).offset(-15);
        }];
        
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 104)];
        
        self.errorButton = [[UIButton alloc] init];
        
        [self.errorButton addTarget:self action:@selector(orderError:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.errorButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        self.errorButton.layer.cornerRadius = 2;
        [self.errorButton setTitle:@"订单有误" forState:UIControlStateNormal];
        self.errorButton.backgroundColor = [UIColor whiteColor];
        [_footerView addSubview:self.errorButton];
        [self.errorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_footerView).offset(15);
            make.bottom.equalTo(_footerView).offset(-15);
            make.top.equalTo(_footerView).offset(40);
        }];
        
        self.confirmButton = [[UIButton alloc] init];
        [self.confirmButton addTarget:self action:@selector(confirmOrder:) forControlEvents:UIControlEventTouchUpInside];
        self.confirmButton.layer.cornerRadius = 2;
        [self.confirmButton setTitle:@"确认订单" forState:UIControlStateNormal];
        self.confirmButton.backgroundColor = ColorWithHex(0x4990E2);
        [_footerView addSubview:self.confirmButton];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.errorButton.mas_right).offset(15);
            make.bottom.equalTo(self.errorButton.mas_bottom);
            make.top.equalTo(self.errorButton.mas_top);
            make.right.equalTo(_footerView).offset(-15);
            make.width.equalTo(self.errorButton.mas_width);
        }];
    }
    return _footerView;
}

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
}

- (void)setUpTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(35);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
}

- (void)setUpTagView {
    HXOrderStatusTagView *statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"确认订单",@"选择分期",@"认证资料",@"开户绑卡"] selectedIndex:0 isFirst:YES];
    [self.view addSubview:statusTagView];
    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(35);
    }];
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.viewModel.customers.count;
    } else if (section == 1) {
        return self.viewModel.projects.count;
    } else {
        return self.viewModel.hireInfos.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"HXConfirmOrderTableViewCell" cacheByIndexPath:indexPath configuration:^(HXConfirmOrderTableViewCell *cell) {
        [self configCell:cell indexPath:indexPath tableView:tableView];
    }];
    NSLog(@"ddddds%f",height);
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = ColorWithHex(0x4A90E2);
    [headerView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.top.equalTo(headerView).offset(15);
        make.bottom.equalTo(headerView).offset(-10);
        make.width.mas_equalTo(3);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = ColorWithHex(0x999999);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    switch (section) {
        case 0:
            titleLabel.text = @"客户信息";
            break;
        case 1:
            titleLabel.text = @"项目信息";
            break;
        case 2:
            titleLabel.text = @"分期信息";
            break;
            
        default:
            break;
    }
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.mas_top);
        make.bottom.equalTo(leftView.mas_bottom);
        make.left.equalTo(leftView.mas_right).offset(5);
        make.right.equalTo(headerView).offset(-15);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.right.equalTo(headerView);
        make.bottom.equalTo(headerView);
        make.height.mas_equalTo(0.5);
    }];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXConfirmOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXConfirmOrderTableViewCell"];
    if (!cell) {
        cell = [[HXConfirmOrderTableViewCell alloc] init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self configCell:cell indexPath:indexPath tableView:tableView];
    
    return cell;
    
}

- (void)configCell:(HXConfirmOrderTableViewCell *)cell indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    HXConfirmOrderTableViewCellViewModel *viewModel = [[HXConfirmOrderTableViewCellViewModel alloc] init];
    switch (indexPath.section) {
        case 0:{
            NSDictionary *dic = self.viewModel.customers[indexPath.row];
            viewModel.title = dic.allKeys.firstObject;
            viewModel.rightValue = dic.allValues.firstObject;
        
        }
            break;
        case 1: {
            NSDictionary *dic = self.viewModel.projects[indexPath.row];
            viewModel.title = dic.allKeys.firstObject;
            viewModel.rightValue = dic.allValues.firstObject;
            
        }
            break;
        case 2: {
            NSDictionary *dic = self.viewModel.hireInfos[indexPath.row];
            viewModel.title = dic.allKeys.firstObject;
            viewModel.rightValue = dic.allValues.firstObject;
            viewModel.rightValue = [NSString stringWithFormat:@"¥%@",viewModel.rightValue.length!=0?viewModel.rightValue:@"0.00"];
        }
            break;
            
        default:
            break;
    }
    cell.viewModel = viewModel;
}

#pragma mark - Private Methods

// 订单有误，页面需要更改的属性
- (void)orderErrorTemp {
    [self.confirmButton setEnabled:NO];
    
    self.errorButton.backgroundColor = ColorWithHex(0xE6E6E6);
    [self.errorButton setTitleColor:ColorWithHex(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.backgroundColor = ColorWithHex(0xE6E6E6);
    
    self.statusLabel.textColor = ColorWithHex(0x999999);
    self.statusLabel.text = @"订单修改中...";
    
    self.commentLabel.text = @"商户销售人员正在修改您的订单，请耐心等候";
}
// 确认订单，页面需要更改的属性
- (void)orderConfirmTemp {
    self.confirmButton.enabled = YES;
    
    self.statusLabel.text = @"待您确认...";
    self.statusLabel.textColor = ColorWithHex(0x4A90E2);
    
    [self.errorButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
    self.errorButton.backgroundColor = [UIColor whiteColor];
    
    self.commentLabel.text = @"请认真核实商户销售人员填写的订单";
}

- (void)orderInfoChanged {
    // yfqStatus = 15 代表订单有误
    if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"15"]) {
        [self orderErrorTemp];
        return;
    }
    
    [self orderConfirmTemp];
    
}

- (void)orderError:(UIButton *)button {
    if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"15"]) {
        return;
    }
    [self orderErrorTemp];
    
    NSDictionary *head = @{@"tradeCode" : @"0117",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"id" : self.viewModel.orderInfo.id,
                           @"userId" :[AppManager manager].userInfo.userId
                           };
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.view];
                                                     self.errorButton.enabled = NO;
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.view];
                                                 }];
}

- (void)confirmOrder:(UIButton *)button {
    NSDictionary *head = @{@"tradeCode" : @"0116",
             @"tradeType" : @"appService"};
    NSDictionary *body = @{@"id" : self.viewModel.orderInfo.id,
                           @"userId" :[AppManager manager].userInfo.userId
                           };
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.view];
                                                     NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
                                                     self.viewModel.orderInfo.yfqStatus = yfqStatus;
                                                     
                                                     [self.viewModel.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
                                                         [self.navigationController pushViewController:controller animated:YES];
                                                     } with:self.viewModel.orderType];
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.view];
                                                 }];
    
}

- (void)backButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
