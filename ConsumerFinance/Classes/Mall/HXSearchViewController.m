//
//  HXSearchViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/24.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXSearchViewController.h"
#import "HXSearchHotTableViewCell.h"
#import "HXSearchResultViewController.h"
#import "HXCommand.h"
#import <Masonry/Masonry.h>
#import "DistListModel.h"
#import "HXKeywordModel.h"
#import "BarButtonView.h"

@interface HXSearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat cellHeight; // 热门搜索cell高度
@property (nonatomic, strong) NSMutableArray * hotNameArr;
@property (nonatomic, strong) NSMutableArray * keyWordArr;
@end

@implementation HXSearchViewController
-(id)init {
    self = [super init];
    if (self) {
       self.viewModel = [[HXSearchViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    [self setNavigationBarBackgroundImage];
    [self setUpNavigation];
    [self setUpTableView];
    // 此方法会阻碍子view的传递
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyboard)];
//    [self.view addGestureRecognizer:tap];
//    self.view.userInteractionEnabled = YES;
    
//    [self.searchBar becomeFirstResponder];
    __weak typeof(self) weadSelf = self;
    [self.viewModel archiveHotType:^(id responseObject){
        __strong __typeof (weadSelf) sself = weadSelf;
        sself.hotNameArr = responseObject;
        [sself.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hiddenNavgationBarLine:NO];
    self.searchBar.hidden = NO;
    self.keyWordArr = [self.viewModel archiveKeyWord];
    if (self.keyWordArr.count !=0) {
        [self.tableView reloadData];
    }
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)setUpNavigation {
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self resetSearchBar];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 38)];
    [rightButton addTarget:self action:@selector(cancellSearch:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [rightButton setTitleColor:ColorWithHex(0xFF6098) forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
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
        make.left.equalTo(container).offset(-20);
        make.right.equalTo(container);
    }];
    
    // 给searchBar添加约束
//    [NSLayoutConstraint activateConstraints:@[
//                                              [self.searchBar.topAnchor constraintEqualToAnchor:container.topAnchor], // 顶部约束
//                                              [self.searchBar.leftAnchor constraintEqualToAnchor:container.leftAnchor constant:-25], // 左边距约束
//                                              [self.searchBar.rightAnchor constraintEqualToAnchor:container.rightAnchor constant:0], // 右边距约束
//                                              [self.searchBar.bottomAnchor constraintEqualToAnchor:container.bottomAnchor], // 底部约束
//                                              [self.searchBar.centerXAnchor constraintEqualToAnchor:container.centerXAnchor constant:-offset], // 横向中心约束
//
//                                              ]];
    self.navigationItem.titleView = container;  // 顶部导航搜索
}
- (void)setUpTableView {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
    }];
}
-(void)hidKeyboard {
    [self.searchBar resignFirstResponder];
}
#pragma mark - UISearchBarDelegate


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.keyWordArr.count == 0? 1: 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = ColorWithHex(0x999999);
    if (section == 0) {
        label.text = @"热门搜索";
    } else {
        label.text = @"历史搜索";
    }
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(12);
        make.top.bottom.right.equalTo(headerView);
    }];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ColorWithHex(0xE6E6E6);
        [footerView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footerView).offset(0);
            make.height.mas_equalTo(1);
            make.right.equalTo(footerView);
            make.top.equalTo(footerView).offset(1);
        }];
        
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(cleanButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"清空历史记录" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:ColorWithHex(0x999999) forState:UIControlStateNormal];
        [footerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(footerView);
            make.top.equalTo(footerView).offset(1);
        }];
    }
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (self.keyWordArr.count>=10) {
        return 10;
    }
    return self.keyWordArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.cellHeight;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HXSearchHotTableViewCell *hotCell = [[HXSearchHotTableViewCell alloc] initWithHotName:self.hotNameArr];
        hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
        hotCell.backgroundColor = [UIColor clearColor];
        self.cellHeight = hotCell.viewModel.cellHeight;
        
        __weak typeof(self) weadSelf = self;
        hotCell.hx_command = [[HXCommand alloc] initWithBlock:^(id input) {
            __strong __typeof (weadSelf) sself = weadSelf;
            NSString *searchContent = @"";
            if ([input isKindOfClass:[UIButton class]]) {
                searchContent = ((UIButton *)input).titleLabel.text;
                
        }
            [sself pushToResultControllerWithSearchContent:searchContent];
        }];
        return hotCell;
    }
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] init];
        
    }
    cell.bankImage.image = [UIImage imageNamed:@"searchIcon"];
    [cell.bankImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(15);
    }];
    [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).offset(33);
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HXKeywordModel * model = [self.keyWordArr objectAtIndex:indexPath.row];
    cell.nameLabel.text =  model.name ? model.name :@"";
    cell.nameLabel.textColor = ComonTitleColor;
    cell.nameLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row != self.keyWordArr.count-1) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ColorWithHex(0xE6E6E6);
        [cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(12);
            make.height.mas_equalTo(1);
            make.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView).offset(0);
        }];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXKeywordModel * model = [self.keyWordArr objectAtIndex:indexPath.row];
    [self pushToResultControllerWithSearchContent:model.name];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self pushToResultControllerWithSearchContent:searchBar.text];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - Private Methods

- (void)pushToResultControllerWithSearchContent:(NSString *)searchContent {
    if (![NSString isBlankString:searchContent]) {
        [self.searchBar resignFirstResponder];
        [self.viewModel conserveKeyWord:searchContent];
        HXSearchResultViewModel *resultViewModel = [[HXSearchResultViewModel alloc] init];
        resultViewModel.searchContent = searchContent;
        resultViewModel.letterModel = self.letterModel;
        HXSearchResultViewController *controller = [[HXSearchResultViewController alloc] init];
        resultViewModel.addressModel = self.viewModel.addressModel;
        controller.viewModel = resultViewModel;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)cancellSearch:(UIButton *)button {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 清除历史记录
-(void)cleanButtonAction {
    [HXKeywordModel clearTable];
    self.keyWordArr = [NSMutableArray array];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
