//
//  HXActivityViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXActivityViewController.h"
#import "HXActivityTableViewCell.h"
#import "HXActivityViewModel.h"
#import "HXWKWebViewViewController.h"

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <RZDataBinding/RZDataBinding.h>

@interface HXActivityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HXActivityViewModel *viewModel;

@end

@implementation HXActivityViewController

- (instancetype)init {
    if (self == [super init]) {
        _viewModel = [[HXActivityViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"热门活动";
    
    [self setUpNavigation];
    [self setUpTableView];
    
    [self bind];
}

- (void)bind {
    [self.viewModel rz_addTarget:self action:@selector(reloadData) forKeyPathChange:RZDB_KP(HXActivityViewModel, activities)];
}

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}

- (void)setUpTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 196;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_tableView registerClass:[HXActivityTableViewCell class] forCellReuseIdentifier:@"HXActivityTableViewCell"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.activities.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXActivityTableViewCell"];

    [self configCell:cell tableView:tableView indexPath:indexPath];

    return cell.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXActivityTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[HXActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXActivityTableViewCell"];
    }
    [self configCell:cell tableView:tableView indexPath:indexPath];
    
    return cell;
}

- (HXActivityTableViewCell *)configCell:(HXActivityTableViewCell *)cell tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    HXActivityModel *model = [self.viewModel.activities objectAtIndex:indexPath.row];
    
    if (model) {
        cell.model = model;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXActivityModel *model = [self.viewModel.activities objectAtIndex:indexPath.row];
    
    NSString *url = model.jumpParam;
    if (!([url hasPrefix:@"https://"] || [url hasPrefix:@"http://"])) {
        url = [NSString stringWithFormat:@"https://%@",url];
    }
    
    HXWKWebViewViewController *controller = [[HXWKWebViewViewController alloc] init];
    controller.title = @"活动详情";
    controller.url = url;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Private Methods

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)dealloc {
    NSLog(@"HXActivityViewController dealloc.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
