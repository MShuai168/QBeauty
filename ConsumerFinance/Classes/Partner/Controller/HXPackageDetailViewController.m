//
//  HXPackageDetailViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPackageDetailViewController.h"
#import "HXPackageDetailTableViewCell.h"
#import "HXPackageDetailModel.h"
#import "HXPackageDetailViewModel.h"

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <RZDataBinding/RZDataBinding.h>

@interface HXPackageDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *errorView;
@property (nonatomic, strong) NSMutableDictionary *cacheHeight;

@end

@implementation HXPackageDetailViewController

- (instancetype)init {
    if (self == [super init]) {
        _viewModel = [[HXPackageDetailViewModel alloc] init];
        _cacheHeight = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorWithHex(0xF9F9F9);
    
    [self setUpNavigation];
    [self setUpTableView];
    [self setUpErrorView];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    __weak typeof(self) weadSelf = self;
    [weadSelf.viewModel requestWithSucess:^{
        [MBProgressHUD hideHUDForView:self.view];
        __strong __typeof (weadSelf) sself = weadSelf;
        if (sself.viewModel.packageDetails.count > 0) {
            [sself.tableView reloadData];
        }
        sself.title = [sself.viewModel valueForKey:@"name"];
        sself.errorView.hidden = sself.viewModel.packageDetails.count > 0;
        
    } failureBlock:^{
        [MBProgressHUD hideHUDForView:self.view];
    }];
    // Do any additional setup after loading the view.
}

- (void)setUpTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}

- (void)setUpErrorView {
    [self.view addSubview:self.errorView];
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIView *)errorView {
    if (!_errorView) {
        _errorView = [[UIView alloc] init];
        _errorView.hidden = YES;
        UIImageView *imageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"nonePackage"];
        imageView.image = image;
        [_errorView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_errorView).offset(80);
            make.centerX.equalTo(_errorView);
            make.size.mas_equalTo(image.size);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"暂未发布内容";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = ColorWithHex(0x999999);
        [_errorView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(16);
            make.centerX.equalTo(_errorView);
            make.size.mas_equalTo(label.intrinsicContentSize);
        }];
    }
    return _errorView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 200;
        [_tableView registerClass:[HXPackageDetailTableViewCell class] forCellReuseIdentifier:@"HXPackageDetailTableViewCell"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.packageDetails.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = [[self.cacheHeight objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]] floatValue];
    
    if (height == 0) {
        HXPackageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXPackageDetailTableViewCell"];
        [self configCell:cell with:indexPath];
        
        height = cell.height;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 47;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXPackageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXPackageDetailTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[HXPackageDetailTableViewCell alloc] init];
    }
    
    [self configCell:cell with:indexPath];
    
    return cell;
}

- (void)configCell:(HXPackageDetailTableViewCell *)cell with:(NSIndexPath *)indexPath {
    
    HXPackageDetailModel *model = [self.viewModel.packageDetails objectAtIndex:indexPath.section];
    if (model) {
        cell.model = model;
    }
    
    [self.cacheHeight setObject:@(cell.height) forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = ColorWithHex(0xFFFFFF);
    UILabel *label = [[UILabel alloc] init];
    
    HXPackageDetailModel *model = [self.viewModel.packageDetails objectAtIndex:section];
    if (model) {
        label.text = model.headerTitle;
    }
    if ([UIFont fontWithName:@"PingFangSC-Semibold" size:15]) {
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    } else {
        label.font = [UIFont systemFontOfSize:15];
    }
    label.textColor = ColorWithHex(0xFF6098);
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.centerY.equalTo(headerView);
        make.size.mas_equalTo(label.intrinsicContentSize);
    }];
    
    UIView *blockView = [[UIView alloc] init];
    blockView.backgroundColor = ColorWithHex(0xFF6098);
    [headerView addSubview:blockView];
    [blockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView);
        make.centerY.equalTo(headerView);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(2);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = ColorWithHex(0xe6e6e6);
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(headerView).offset(0);
        make.left.equalTo(headerView).offset(15);
        make.height.mas_equalTo(0.5);
    }];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    return footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
