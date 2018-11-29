//
//  HXCitySelectedViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXCitySelectedViewController.h"
#import "HXCityCollectionViewCell.h"
#import "HXCitySelectedViewModel.h"
#import "CurrentLocation.h"
#import "LetterListModel.h"
#import "VoListModel.h"

#import <Masonry/Masonry.h>
#import <RZDataBinding/RZDataBinding.h>

@interface HXCitySelectedViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *tableViewHeaderView;
@property (nonatomic, strong) UILabel *gpsLabel;

@property (nonatomic, strong) UICollectionView *hotCityCollectionView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *searchCityTableView;

@end

@implementation HXCitySelectedViewController

- (instancetype)init {
    if (self == [super init]) {
        _viewModel = [[HXCitySelectedViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.minimumLineSpacing = 10;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 15,20, 0);
    
    self.hotCityCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:collectionViewLayout];
    self.viewModel.hotCityCollectionView = self.hotCityCollectionView;
    self.hotCityCollectionView.backgroundColor = [UIColor whiteColor];
    [self.hotCityCollectionView registerClass:[HXCityCollectionViewCell class] forCellWithReuseIdentifier:@"HXCityCollectionViewCell"];
    self.hotCityCollectionView.dataSource = self;
    self.hotCityCollectionView.delegate = self;
    
    [self setUpSearchBar];
    [self setUpNavigation];
    [self setUpTableView];
    
    [self setUpSearchCityTableView];
    
    [self bind];
    NSMutableArray * selectCity =[VoListModel changeHotList];
    if (selectCity.count==0) {
        __block HXCitySelectedViewController/*主控制器*/ *weakSelf = self;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [weakSelf request];
        });
    } else {
        [self request];
    }
    
    [[CurrentLocation sharedManager] gpsCityWithLocationAddress:^(AddressModelInfo *addressModel) {
        if ([NSString isBlankString:addressModel.city]) {
            [KeyWindow displayMessage:@"你还没有开启定位权限"];
            return ;
        }
        self.viewModel.addressModelInfo = addressModel;
        
        self.viewModel.gpsCity = addressModel.city;
        self.gpsLabel.text = [NSString stringWithFormat:@"%@(GPS)",self.viewModel.gpsCity];
        _gpsLabel.userInteractionEnabled = YES;
    }];
}

#pragma mark 懒加载

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.backgroundImage = [[UIImage alloc] init];
        // 设置SearchBar的颜色主题为白色
        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.placeholder = @"搜索城市";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tag = 1;
        _tableView.sectionIndexColor = ColorWithHex(0xFC4880);
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        self.viewModel.tableView = _tableView;
    }
    return _tableView;
}

- (UITableView *)searchCityTableView {
    if (!_searchCityTableView) {
        _searchCityTableView = [[UITableView alloc] init];
        _searchCityTableView.tag = 2;
        _searchCityTableView.hidden = YES;
        _searchCityTableView.sectionIndexColor = ColorWithHex(0xFC4880);
        _searchCityTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _searchCityTableView.tableFooterView = [[UIView alloc] init];
        _searchCityTableView.dataSource = self;
        _searchCityTableView.delegate = self;
        _searchCityTableView.estimatedRowHeight = 0;
        _searchCityTableView.estimatedSectionHeaderHeight = 0;
        _searchCityTableView.estimatedSectionFooterHeight = 0;
    }
    return _searchCityTableView;
}

- (UILabel *)gpsLabel {
    if (!_gpsLabel) {
        _gpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 43)];
        
        if (self.viewModel.gpsCity) {
            _gpsLabel.text = [NSString stringWithFormat:@"%@(GPS)",self.viewModel.gpsCity];
            _gpsLabel.userInteractionEnabled = YES;
        } else {
            _gpsLabel.text = @"定位失败";
            _gpsLabel.userInteractionEnabled=NO;
        }
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gpsSelect)];
        _gpsLabel.textColor = ColorWithHex(0xFC4880);
        [_gpsLabel addGestureRecognizer:labelTapGestureRecognizer];
        _gpsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    }
    return _gpsLabel;
}

- (UIView *)tableViewHeaderView {
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 45)];
    }
    return _tableViewHeaderView;
}

#pragma mark 设置UI

- (void)setUpNavigation {
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = ColorWithHex(0xffffff);
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_offset(64);
    }];
    UILabel *label = [[UILabel alloc] init];
    NSString *locationCity = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    if (locationCity) {
        label.text = [NSString stringWithFormat:@"当前地区-%@",[[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity]];
    } else {
        label.text = @"选择城市";
    }
    
    label.textColor = ColorWithHex(0x131313);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    [titleView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView);
        make.bottom.equalTo(titleView).offset(-12);
        make.height.mas_offset(18);
        make.left.right.equalTo(titleView);
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [titleView addSubview:button];
    [button setBackgroundImage:[UIImage imageNamed:@"cityClose"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).offset(10);
        make.centerY.equalTo(label);
    }];
    
}

- (void)setUpSearchBar {
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
}

- (void)setUpTableView {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableViewHeaderView;
    [self.tableViewHeaderView addSubview:self.gpsLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    [self.tableViewHeaderView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tableViewHeaderView);
        make.height.mas_offset(1);
        make.top.equalTo(self.gpsLabel.mas_bottom).offset(1);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

- (void)setUpSearchCityTableView {
    [self.view addSubview:self.searchCityTableView];
    
    [self.searchCityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - Bind

- (void)bind {
    [self.viewModel rz_addTarget:self action:@selector(hiddenTableView) forKeyPathChange:RZDB_KP(HXCitySelectedViewModel, hiddenTableView)];
}

#pragma mark UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(75, 32);
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.hotCitys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HXCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCityCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HXCityCollectionViewCell alloc] init];
    }
    cell.layer.borderColor = ColorWithHex(0xE6E6E6).CGColor;
    cell.layer.borderWidth = 1;
    cell.cityName = self.viewModel.hotCitys[indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *city = self.viewModel.hotCitys[indexPath.row];
    
    if (self.changeCity) {
        self.changeCity(city);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCity" object:nil];
    
    [self dismiss];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 2) {
        return 1;
    }
    return self.viewModel.indexArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 2) {
        return self.viewModel.searchCities.count;
    }
    // 热门城市
    if (section == 0) {
        return 1;
    }
    
    if (section > self.viewModel.cities.count) {
        return 0;
    }
    
    NSDictionary *dic = [self.viewModel.cities objectAtIndex:section - 1];
    if (!dic) {
        return 0;
    }
    NSArray *cityArray = [dic objectForKey:self.viewModel.indexArray[section]];
    if (!cityArray) {
        return 0;
    }
    
    return cityArray.count;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView.tag == 2) {
        return nil;
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self.viewModel.indexArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[obj uppercaseString]];
    }];
    return array;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 2) {
        return 44;
    }
    
    if (indexPath.section == 0) {
        int i = 0;
        int maxNum = 4;
        if (TWOSCREEN) {
            maxNum = 3;
        }
        if (self.viewModel.hotCitys.count % maxNum == 0) {
            i = (int)self.viewModel.hotCitys.count/maxNum;
        } else {
            i = (int)self.viewModel.hotCitys.count/maxNum + 1;
        }
        return 44*i;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    if (tableView.tag == 2) {
        cell.textLabel.text = self.viewModel.searchCities[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.hotCityCollectionView];
        [self.hotCityCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        return cell;
    }
    
    NSString *city = [self getCity:indexPath.section indexPathRow:indexPath.row];
    
    if (!city) {
        return cell;
    }
    
    cell.textLabel.text = city;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 2) {
        return 0;
    }
    if (section == 0) {
        return 44;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = ColorWithHex(0xF5F7F8);
    UILabel *label = [[UILabel alloc] init];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.top.bottom.right.equalTo(headerView);
        
    }];
    
    if (section == 0) {
        label.text = @"热门城市";
        headerView.backgroundColor = [UIColor whiteColor];
    } else {
        label.text = [self.viewModel.indexArray[section] uppercaseString];
        headerView.backgroundColor = ColorWithHex(0xF5F7F8);
    }
    
    label.font = [UIFont systemFontOfSize:14];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    return index;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 2) {
        NSString *city = self.viewModel.searchCities[indexPath.row];
        [self didSelectRowWithCity:city];
        return;
    }
    
    if (indexPath.section == 0) {
        return;
    }
    
    NSString *city = [self getCity:indexPath.section indexPathRow:indexPath.row];
    
    [self didSelectRowWithCity:city];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![NSString isBlankString:searchText]) {
        [self.viewModel fillSearchCities:searchText];
        self.viewModel.hiddenTableView = YES;
        [self.searchCityTableView reloadData];
        return;
    }
    self.viewModel.hiddenTableView = NO;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar becomeFirstResponder];
    [searchBar setShowsCancelButton:YES animated:YES];
    NSArray * subViews=[(UIView *)[searchBar subviews][0] subviews];
    
    for(UIView * view in subViews) {
        if([view isKindOfClass:[UIButton class]]) {
            [(UIButton*)view setTitle:@"取消" forState:UIControlStateNormal];
            [(UIButton*)view setTitleColor:ComonBackColor forState:UIControlStateNormal];
        }
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

//点击取消
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    self.viewModel.hiddenTableView = NO;
    _searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark Private Methods

- (void)closeButton:(UIButton *)button {
    NSString *locationCity = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    if (!locationCity) {
        [KeyWindow displayMessage:@"请先选择所在城市"];
        return;
    }
    [self dismiss];
}

-(void)gpsSelect {
    LetterListModel *letterModel = [VoListModel inquiryLetterModelWithName:self.viewModel.gpsCity];
    if (!letterModel) {
        [KeyWindow displayMessage:@"当前定位城市不支持 请选择其他城市"];
        return;
    }
    
    if (self.viewModel.gpsCity) {
        self.changeCity(self.viewModel.gpsCity);
    }
    
    [self dismiss];
}

- (void)request {
    [_viewModel updateCityListReturnBlock:^{
        [self.hotCityCollectionView reloadData];
        [_tableView  reloadData];
    } fail:^{
        [self.hotCityCollectionView reloadData];
        [_tableView  reloadData];
    }];
}

- (void)didSelectRowWithCity:(NSString *)city {
    
    if (self.changeCity && city) {
        self.changeCity(city);
    }
    
    [self dismiss];
}

- (void)hiddenTableView {
    self.tableView.hidden = self.viewModel.hiddenTableView;
    self.searchCityTableView.hidden = !self.viewModel.hiddenTableView;
}

- (NSString *)getCity:(NSInteger)section indexPathRow:(NSInteger)indexPathRow {
    NSDictionary *dic = [self.viewModel.cities objectAtIndex:section - 1];
    if (!dic) {
        return nil;
    }
    NSArray *cityArray = [dic objectForKey:self.viewModel.indexArray[section]];
    if (!cityArray) {
        return nil;
    }
    return [cityArray objectAtIndex:indexPathRow];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
