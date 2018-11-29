//
//  HXBookingViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/16.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBookingViewController.h"
#import "HXBookingViewModel.h"
#import "HXBookingTableViewCell.h"
#import "HXBookingOfCancelTableViewCell.h"
#import "HXBookingOfSucessTableViewCell.h"

#import <RZDataBinding/RZDataBinding.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface HXBookingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HXBookingViewModel *viewModel;

@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) UIButton *allButton; // 全部
@property (nonatomic, strong) UIButton *inProgressButton; // 处理中
@property (nonatomic, strong) UIButton *sucessButton; // 完成
@property (nonatomic, strong) UIView *tagLineView;
@property (nonatomic, strong) UIView *noDataView;

@property (nonatomic, strong) UITableView *allTableView;
@property (nonatomic, strong) UITableView *inProgressTableView;
@property (nonatomic, strong) UITableView *sucessTableView;

@end

@implementation HXBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的预约";
    
    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    
    self.viewModel = [[HXBookingViewModel alloc] init];
    self.viewModel.controller = self;
    
    [self bind];
    
    [self setUpNavigation];
    [self setUpTabView];
    [self setUpAllTableView];
    [self setUpInProgressTableView];
    [self setUpSucessTableView];
    [self setUpNoDataView];
    
    self.viewModel.bookingStatus = bookingStatusAll;
    [self.viewModel getOrderList];
}

#pragma mark UI

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
}

- (void)setUpNoDataView {
    [self.view addSubview:self.noDataView];
    
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)setUpTabView {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.tabView addSubview:self.allButton];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.tabView);
        make.width.mas_equalTo(self.view.frame.size.width/3);
    }];
    
    [self.tabView addSubview:self.inProgressButton];
    [self.inProgressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tabView);
        make.width.mas_equalTo(self.view.frame.size.width/3);
    }];
    
    [self.tabView addSubview:self.sucessButton];
    [self.sucessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inProgressButton.mas_right);
        make.right.top.bottom.equalTo(self.tabView);
        make.width.mas_equalTo(self.view.frame.size.width/3);
    }];
    
    [self.tabView addSubview:self.tagLineView];
    [self.tagLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(self.allButton);
        make.bottom.equalTo(self.tabView);
    }];
    
}

- (void)setUpAllTableView {
    [self.view addSubview:self.allTableView];
    [self.allTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tabView.mas_bottom).offset(0);
    }];
    
    [self.allTableView rz_bindKey:RZDB_KP(UITableView, hidden) toKeyPath:RZDB_KP(UIButton, selected) ofObject:self.allButton withTransform:^id(id value) {
        if ([value boolValue]) {
            return [NSNumber numberWithBool:NO];
        }
        return [NSNumber numberWithBool:YES];
    }];
}

- (void)setUpInProgressTableView {
    [self.view addSubview:self.inProgressTableView];
    [self.inProgressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tabView.mas_bottom).offset(0);
    }];
    
    [self.inProgressTableView rz_bindKey:RZDB_KP(UITableView, hidden) toKeyPath:RZDB_KP(UIButton, selected) ofObject:self.inProgressButton withTransform:^id(id value) {
        if ([value boolValue]) {
            return [NSNumber numberWithBool:NO];
        }
        return [NSNumber numberWithBool:YES];
    }];
}

- (void)setUpSucessTableView {
    [self.view addSubview:self.sucessTableView];
    [self.sucessTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tabView.mas_bottom).offset(0);
    }];
    
    [self.sucessTableView rz_bindKey:RZDB_KP(UITableView, hidden) toKeyPath:RZDB_KP(UIButton, selected) ofObject:self.sucessButton withTransform:^id(id value) {
        
        if ([value boolValue]) {
            return [NSNumber numberWithBool:NO];
        }
        return [NSNumber numberWithBool:YES];
    }];
    
}

#pragma mark - 懒加载

- (UIView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[UIView alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodingdan"]];
        [_noDataView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataView);
            make.top.equalTo(_noDataView).offset(140);
            make.size.mas_equalTo([UIImage imageNamed:@"nodingdan"].size);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"亲，您还没有预约哦～";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = ColorWithHex(0x999999);
        [_noDataView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataView);
            make.top.equalTo(imageView.mas_bottom).offset(30);
            make.size.mas_equalTo(label.intrinsicContentSize);
        }];
    }
    return _noDataView;
}

- (UITableView *)allTableView {
    if (!_allTableView) {
        _allTableView = [[UITableView alloc] init];
        _allTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];;
        _allTableView.estimatedRowHeight = 300;
        _allTableView.rowHeight = UITableViewAutomaticDimension;
        _allTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _allTableView.estimatedRowHeight = 0;
        _allTableView.estimatedSectionHeaderHeight = 0;
        _allTableView.estimatedSectionFooterHeight = 0;
        _allTableView.tag = 0;
        _allTableView.dataSource = self;
        _allTableView.delegate = self;
        [_allTableView registerClass:[HXBookingTableViewCell class] forCellReuseIdentifier:@"HXBookingTableViewCell"];
        [_allTableView registerClass:[HXBookingOfCancelTableViewCell class] forCellReuseIdentifier:@"HXBookingOfCancelTableViewCell"];
        [_allTableView registerClass:[HXBookingOfSucessTableViewCell class] forCellReuseIdentifier:@"HXBookingOfSucessTableViewCell"];
    }
    return _allTableView;
}

- (UITableView *)inProgressTableView {
    if (!_inProgressTableView) {
        _inProgressTableView = [[UITableView alloc] init];
        _inProgressTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _inProgressTableView.estimatedRowHeight = 250;
        _inProgressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _inProgressTableView.tag = 1;
        _inProgressTableView.estimatedRowHeight = 0;
        _inProgressTableView.estimatedSectionHeaderHeight = 0;
        _inProgressTableView.estimatedSectionFooterHeight = 0;
        _inProgressTableView.dataSource = self;
        _inProgressTableView.delegate = self;
        [_inProgressTableView registerClass:[HXBookingTableViewCell class] forCellReuseIdentifier:@"inProgressTableViewCell"];
    }
    return _inProgressTableView;
}

- (UITableView *)sucessTableView {
    if (!_sucessTableView) {
        _sucessTableView = [[UITableView alloc] init];
        _sucessTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _sucessTableView.estimatedRowHeight = 250;
        _sucessTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _sucessTableView.tag = 2;
        _sucessTableView.estimatedRowHeight = 0;
        _sucessTableView.estimatedSectionHeaderHeight = 0;
        _sucessTableView.estimatedSectionFooterHeight = 0;
        _sucessTableView.dataSource = self;
        _sucessTableView.delegate = self;
        [_sucessTableView registerClass:[HXBookingOfSucessTableViewCell class] forCellReuseIdentifier:@"sucessTableViewCell"];
    }
    return _sucessTableView;
}

- (UIView *)tagLineView {
    if (!_tagLineView) {
        _tagLineView = [[UIView alloc] init];
        _tagLineView.backgroundColor = ComonBackColor;
    }
    return _tagLineView;
}

- (UIView *)tabView {
    if (!_tabView) {
        _tabView = [[UIView alloc] init];
        _tabView.backgroundColor = [UIColor whiteColor];
    }
    return _tabView;
}

-(UIButton *)allButton {
    if (!_allButton) {
        _allButton = [[UIButton alloc] init];
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        [_allButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [_allButton setTitleColor:ComonBackColor forState:UIControlStateSelected];
        [_allButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_allButton addTarget:self action:@selector(changeAllButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}

- (UIButton *)inProgressButton {
    if (!_inProgressButton) {
        _inProgressButton = [[UIButton alloc] init];
        [_inProgressButton setTitle:@"处理中" forState:UIControlStateNormal];
        [_inProgressButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [_inProgressButton setTitleColor:ComonBackColor forState:UIControlStateSelected];
        [_inProgressButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_inProgressButton addTarget:self action:@selector(changeProgressButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inProgressButton;
}

- (UIButton *)sucessButton {
    if (!_sucessButton) {
        _sucessButton = [[UIButton alloc] init];
        [_sucessButton setTitle:@"完成" forState:UIControlStateNormal];
        [_sucessButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [_sucessButton setTitleColor:ComonBackColor forState:UIControlStateSelected];
        [_sucessButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_sucessButton addTarget:self action:@selector(changeSucessButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sucessButton;
}

- (void)bind {
    [self.viewModel rz_addTarget:self action:@selector(orderStatusChange) forKeyPathChange:RZDB_KP(HXBookingViewModel, bookingStatus)];
    [self.viewModel rz_addTarget:self action:@selector(orderStatusChange) forKeyPathChange:RZDB_KP(HXBookingViewModel, refreshTable)];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = 0;
    switch (tableView.tag) {
        case 0:
            numberOfSections = self.viewModel.allBookings.count;
            break;
        case 1:
            numberOfSections = self.viewModel.inProgressBookings.count;
            break;
        case 2:
            numberOfSections = self.viewModel.sucessBookings.count;
            break;
        default:
            break;
    }
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    HXBookingTableViewCellViewModel *viewModel = nil;
    switch (tableView.tag) {
        case 0:
            viewModel = self.viewModel.allBookings[indexPath.section];
            switch (viewModel.status) {
                case bookingDetailCancel:
                    identifier = @"HXBookingOfCancelTableViewCell";
                    break;
                case bookingDetailInProgress:
                    identifier = @"HXBookingTableViewCell";
                    break;
                case bookingDetailSucess:
                    identifier = @"HXBookingOfSucessTableViewCell";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            identifier = @"inProgressTableViewCell";
            viewModel = self.viewModel.inProgressBookings[indexPath.section];
            break;
        case 2:
            identifier = @"sucessTableViewCell";
            viewModel = self.viewModel.sucessBookings[indexPath.section];
            break;
            
        default:
            break;
    }
//    CGFloat height = [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(HXBookingTableViewCell *cell) {
//        [self configCell:cell tableView:tableView indexPath:indexPath];
//    }];
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:identifier cacheByKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section] configuration:^(HXBookingTableViewCell *cell) {
        
    }];
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBookingTableViewCell *cell = nil;
    switch (tableView.tag) {
        case 0: {
            HXBookingTableViewCellViewModel *cellViewModel = [self.viewModel.allBookings objectAtIndex:indexPath.section];
            
            switch (cellViewModel.status) {
                case bookingDetailCancel:
                    cell = [tableView dequeueReusableCellWithIdentifier:@"HXBookingOfCancelTableViewCell"];
                    break;
                case bookingDetailInProgress:
                    cell = [tableView dequeueReusableCellWithIdentifier:@"HXBookingTableViewCell"];
                    break;
                case bookingDetailSucess:
                    cell = [tableView dequeueReusableCellWithIdentifier:@"HXBookingOfSucessTableViewCell"];
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"inProgressTableViewCell"];
            if (!cell) {
                cell = [[HXBookingTableViewCell alloc] init];
            }
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"sucessTableViewCell"];
            if (!cell) {
                cell = [[HXBookingTableViewCell alloc] init];
            }
            break;
            
        default:
            break;
    }
    
    cell = [self configCell:cell tableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (HXBookingTableViewCell *)configCell:(HXBookingTableViewCell *)cell tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    switch (tableView.tag) {
        case 0:
            cell.viewModel = [self.viewModel.allBookings objectAtIndex:indexPath.section];
            break;
        case 1:
            cell.viewModel = [self.viewModel.inProgressBookings objectAtIndex:indexPath.section];
            break;
        case 2:
            [self.viewModel.sucessBookings objectAtIndex:0];
            cell.viewModel = [self.viewModel.sucessBookings objectAtIndex:indexPath.section];
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark - Private

- (void)orderStatusChange {
    self.allButton.selected = NO;
    self.inProgressButton.selected = NO;
    self.sucessButton.selected = NO;
    
    switch (self.viewModel.bookingStatus) {
        case bookingStatusAll:
            self.noDataView.hidden = self.viewModel.allBookings.count > 0;
            self.allButton.selected = YES;
            [self.allTableView reloadData];
            break;
        case bookingStatusInProgress:
            self.noDataView.hidden = self.viewModel.inProgressBookings.count > 0;
            self.inProgressButton.selected = YES;
            [self.inProgressTableView reloadData];
            break;
        case bookingStatusSucess:
            self.noDataView.hidden = self.viewModel.sucessBookings.count > 0;
            self.sucessButton.selected = YES;
            [self.sucessTableView reloadData];
            break;
            
        default:
            break;
    }
}

- (void)backButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeAllButton:(UIButton *)button {
    [self.tagLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(self.allButton);
        make.bottom.equalTo(self.tabView);
    }];
    
    self.viewModel.bookingStatus = bookingStatusAll;
    [_allTableView.fd_keyedHeightCache invalidateAllHeightCache];
    [self.viewModel getOrderList];
}

- (void)changeProgressButton:(UIButton *)button {
    [self.tagLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(self.inProgressButton);
        make.bottom.equalTo(self.tabView);
    }];
    [_inProgressTableView.fd_keyedHeightCache invalidateAllHeightCache];
    self.viewModel.bookingStatus = bookingStatusInProgress;
    [self.viewModel getOrderList];
}

- (void)changeSucessButton:(UIButton *)button {
    [self.tagLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(self.sucessButton);
        make.bottom.equalTo(self.tabView);
    }];
    [_sucessTableView.fd_keyedHeightCache invalidateAllHeightCache];
    self.viewModel.bookingStatus = bookingStatusSucess;
    [self.viewModel getOrderList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
