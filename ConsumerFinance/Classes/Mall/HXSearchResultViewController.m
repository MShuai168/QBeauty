//
//  HXSearchResultViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/27.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXSearchResultViewController.h"
#import "HXCommercialCell.h"
#import "BeautyClinicModel.h"
#import "BeautyClinicCell.h"
#import "HXYmDetailsViewController.h"
#import "BeautyClinicModel.h"
#import "DtoListModel.h"
#import "HXProductDetailViewController.h"
#import "BarButtonView.h"


@interface HXSearchResultViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) UIButton *companyButton;
@property (nonatomic, strong) UIButton *projectButton;
@property (nonatomic, strong) UIView *tagLineView;

@property (nonatomic, strong) UITableView *companyTableView;
@property (nonatomic, strong) UITableView *projectTableView;


@end

@implementation HXSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    
    [self setUpNavigation];
    [self setUpTabView];
    [self setUpTableView];
    self.viewModel.controller = self;
    self.viewModel.index = 1;
    self.viewModel.proindex = 1;
    [self request];
    [self projectRequest];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyboard)];
//    [self.view addGestureRecognizer:tap];
//    self.view.userInteractionEnabled = YES;
}
-(void)request {
    [self.viewModel archiveMerchantdetails:^(id responesObject){
        [self.companyTableView reloadData];
        if (self.viewModel.dataArr.count==0) {
            [self creatStateViewWithType:2 view:self.companyTableView];
        }else {
            [self.viewModel.stateView removeFromSuperview];
        }
    } fail:^{
        [self creatStateViewWithType:0 view:self.companyTableView];
    }];
    
}
-(void)projectRequest {
    [self.viewModel archiveItemdetails:^(id responesObject){
        [self.projectTableView reloadData];
        if (self.viewModel.itemArr.count==0) {
            [self creatItemStateViewWithType:2 view:self.projectTableView];
        }else {
            [self.viewModel.itmStateView removeFromSuperview];
        }
    } fail:^{
        [self creatItemStateViewWithType:0 view:self.projectTableView];

    }];
    
}
-(void)hidKeyboard {
    [self.searchBar resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchBar.hidden = NO;
    [self hiddenNavgationBarLine:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.searchBar.hidden = YES;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"搜索商户，项目";
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        UITextField *searchField = [_searchBar valueForKey:@"searchField"];
        if (searchField) {
            [searchField setBackgroundColor:[UIColor whiteColor]];
            searchField.layer.cornerRadius = 14.0f;
            searchField.layer.masksToBounds = YES;
        }
    }
    return _searchBar;
}

- (UIView *)tabView {
    if (!_tabView) {
        _tabView = [[UIView alloc] init];
        _tabView.backgroundColor = [UIColor whiteColor];
    }
    return _tabView;
}

- (UIButton *)companyButton {
    if (!_companyButton) {
        _companyButton = [[UIButton alloc] init];
        [_companyButton setTitle:@"商户" forState:UIControlStateNormal];
        [_companyButton setTitleColor:ColorWithHex(0xFF6098) forState:UIControlStateNormal];
        [_companyButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_companyButton addTarget:self action:@selector(changeCompanyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _companyButton;
}

- (UIButton *)projectButton {
    if (!_projectButton) {
        _projectButton = [[UIButton alloc] init];
        [_projectButton setTitle:@"项目" forState:UIControlStateNormal];
        [_projectButton setTitleColor:ColorWithHex(0xFF6098) forState:UIControlStateNormal];
        [_projectButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_projectButton addTarget:self action:@selector(changeProjectButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _projectButton;
}

- (UITableView *)companyTableView {
    if (!_companyTableView) {
        _companyTableView = [[UITableView alloc] init];
        _companyTableView.tag = 1;
        [_companyTableView registerClass:[HXCommercialCell class] forCellReuseIdentifier:@"DockBeautyCell"];
        _companyTableView.dataSource = self;
        _companyTableView.delegate = self;
        _companyTableView.estimatedRowHeight = 0;
        _companyTableView.estimatedSectionHeaderHeight = 0;
        _companyTableView.estimatedSectionFooterHeight = 0;
        _companyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
        //上拉刷新
        _companyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
    }
    return _companyTableView;
}

- (UITableView *)projectTableView {
    if (!_projectTableView) {
        _projectTableView = [[UITableView alloc] init];
        [_projectTableView registerClass:[BeautyClinicCell class] forCellReuseIdentifier:@"BeautyClinicCell"];
        _projectTableView.hidden = YES;
        _projectTableView.tag = 2;
        _projectTableView.dataSource = self;
        _projectTableView.delegate = self;
        _projectTableView.estimatedRowHeight = 0;
        _projectTableView.estimatedSectionHeaderHeight = 0;
        _projectTableView.estimatedSectionFooterHeight = 0;
        _projectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
        //上拉刷新
        _projectTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
    }
    return _projectTableView;
}

- (UIView *)tagLineView {
    if (!_tagLineView) {
        _tagLineView = [[UIView alloc] init];
        _tagLineView.backgroundColor = ComonBackColor;
    }
    return _tagLineView;
}

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self resetSearchBar];
    self.searchBar.text = self.viewModel.searchContent;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPageCurl target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}
- (void)resetSearchBar
{
    CGFloat leftButtonWidth = 35, rightButtonWidth = 75;  // left padding right padding
    EVNUILayoutView * container = [[EVNUILayoutView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - leftButtonWidth - rightButtonWidth, 44)];
    
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:self.searchBar];
    
    CGFloat offset = (rightButtonWidth - leftButtonWidth) / 2;
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(container);
        make.left.equalTo(container);
        make.right.equalTo(container);
    }];
    
    // 给searchBar添加约束
//    [NSLayoutConstraint activateConstraints:@[
//                                              [self.searchBar.topAnchor constraintEqualToAnchor:container.topAnchor], // 顶部约束
//                                              [self.searchBar.leftAnchor constraintEqualToAnchor:container.leftAnchor constant:0], // 左边距约束
//                                              [self.searchBar.rightAnchor constraintEqualToAnchor:container.rightAnchor constant:0], // 右边距约束
//                                              [self.searchBar.bottomAnchor constraintEqualToAnchor:container.bottomAnchor], // 底部约束
//                                              [self.searchBar.centerXAnchor constraintEqualToAnchor:container.centerXAnchor constant:-offset], // 横向中心约束
//                                              ]];
    self.navigationItem.titleView = container;  // 顶部导航搜索
}
- (void)setUpTabView {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.tabView addSubview:self.companyButton];
    [self.companyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.tabView);
        make.width.mas_equalTo(self.view.frame.size.width/2);
    }];
    
    [self.tabView addSubview:self.projectButton];
    [self.projectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.tabView);
        make.width.mas_equalTo(self.view.frame.size.width/2);
    }];
    
    [self.tabView addSubview:self.tagLineView];
    [self.tagLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(self.companyButton);
        make.bottom.equalTo(self.tabView);
    }];
}

- (void)setUpTableView {
    [self.view addSubview:self.companyTableView];
    
    [self.companyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tabView.mas_bottom).offset(10);
    }];
    
    [self.view addSubview:self.projectTableView];
    [self.projectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.companyTableView);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_companyTableView]) {
        
        return self.viewModel.dataArr.count;
    }
    return self.viewModel.itemArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        DtoListModel *model = [self.viewModel.dataArr objectAtIndex:indexPath.row];
        return model.cellHeight;
    }
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag ==1) {
        HXCommercialCell *dockBeautyCell = [tableView dequeueReusableCellWithIdentifier:@"dockBeautyCell"];
        if (!dockBeautyCell) {
            dockBeautyCell = [[HXCommercialCell alloc] init];
            dockBeautyCell.nameLabel.numberOfLines = 1;
            
            [dockBeautyCell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dockBeautyCell.contentView).offset(90);
                make.height.mas_equalTo(16);
            }];
            [dockBeautyCell.paymontLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dockBeautyCell.contentView).offset(90);
            }];
        }
        
        DtoListModel *model = [self.viewModel.dataArr objectAtIndex:indexPath.row];
        dockBeautyCell.model = model;
        
        return dockBeautyCell;
    }
    
    BeautyClinicCell *beautyClinicCell = [tableView dequeueReusableCellWithIdentifier:@"beautyClinicCell"];
    
    if (!beautyClinicCell) {
        beautyClinicCell = [[BeautyClinicCell alloc] init];
    }
    beautyClinicCell.model = [self.viewModel.itemArr objectAtIndex:indexPath.row];
    
    return beautyClinicCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.companyTableView.hidden) {
        
        HXYmDetailsViewController * details = [[HXYmDetailsViewController alloc ] init];
        DtoListModel *model = [self.viewModel.dataArr objectAtIndex:indexPath.row];
        details.viewModel.merId = model.id;
        [self.navigationController pushViewController:details animated:YES];
    }else {
        HXProductDetailViewController * details = [[HXProductDetailViewController alloc] init];
        DtoListModel * model = [self.viewModel.itemArr objectAtIndex:indexPath.row];
        details.viewModel.proId = model.id;
        [self.navigationController pushViewController:details animated:YES];
    }
}

- (void)backButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeCompanyButton:(UIButton *)button {
    [self.tagLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(self.companyButton);
        make.bottom.equalTo(self.tabView);
    }];
    self.companyTableView.hidden = NO;
    self.projectTableView.hidden = YES;
    [self.companyTableView reloadData];
}

- (void)changeProjectButton:(UIButton *)button {
    [self.tagLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(self.projectButton);
        make.bottom.equalTo(self.tabView);
    }];
    
    self.companyTableView.hidden = YES;
    self.projectTableView.hidden = NO;
    
    [self.projectTableView reloadData];
}
#pragma mark --  下拉刷新
-(void)loadNewTopic:(UITableView *)tableView {
    if ([tableView isEqual:_companyTableView.mj_header]) {
        self.viewModel.index=1;
        [self request];
        [_companyTableView.mj_header endRefreshing];
    }else {
        self.viewModel.proindex=1;
        [self projectRequest];
        [_projectTableView.mj_header endRefreshing];
    }
}
-(void)loadMoreTopic:(UITableView *)tableView {
    if ([tableView isEqual:_companyTableView.mj_footer]) {
        self.viewModel.index++;
        [self request];
        [_companyTableView.mj_footer endRefreshing];
    }else {
        self.viewModel.proindex++;
        [self projectRequest];
        [_projectTableView.mj_footer endRefreshing];
        
    }
}
#pragma mark -- UISearchBarDelegate 
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    self.viewModel.searchContent = searchBar.text;
    [self.viewModel conserveKeyWord:searchBar.text];
    self.viewModel.index = 1;
    self.viewModel.proindex = 1;
    [self request];
    [self projectRequest];
    
}
-(void)creatStateViewWithType:(NSInteger)type view:(UIView *)view{
    if (self.viewModel.stateView) {
        [self.viewModel.stateView removeFromSuperview];
    }
    self.viewModel.stateView = [[HXStateView alloc] initWithalertShow:type backView:view offset:0];
    self.viewModel.stateView.submitBlock = ^{
        
    };
}
-(void)creatItemStateViewWithType:(NSInteger)type view:(UIView *)view{
    if (self.viewModel.itmStateView) {
        [self.viewModel.itmStateView removeFromSuperview];
    }
    self.viewModel.itmStateView = [[HXStateView alloc] initWithalertShow:type backView:view offset:0];
    self.viewModel.itmStateView.submitBlock = ^{
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
