//
//  HXMallViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXMallViewController.h"
#import "HXMallCollectionViewCell.h"
#import "DockBeautyCell.h"
#import "BeautyClinicModel.h"
#import "HXCitySelectedViewController.h"
#import "CurrentLocation.h"
#import "HXAlertController.h"
#import "HXSearchViewController.h"
#import "BeautyClinicViewController.h"
#import "HXYmDetailsViewController.h"
#import "HXMallModel.h"
#import "HXCommercialCell.h"
#import "HXHoneyMoonViewController.h"
#import "HXClubHouseViewController.h"
#import "HXMessageViewController.h"

#import <Masonry/Masonry.h>
#import <ZYBannerView/ZYBannerView.h>
#import <MJRefresh/MJRefresh.h>
#import <RZDataBinding/RZDataBinding.h>
#import "HXBannerModel.h"
#import "HXProductDetailViewController.h"
#import "HXWevbViewController.h"
#import "BarButtonView.h"


@interface HXMallViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,ZYBannerViewDataSource, ZYBannerViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *locationButton; // 城市切换
@property (nonatomic, strong) UIButton *pullDownIconButton; // 城市下拉icon
@property (nonatomic, strong) ZYBannerView *bannerView;   // bannerView;
@property (nonatomic, strong) TitileView *titleView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,assign)BOOL firstOnce; //标记第一次出现


@end

@implementation HXMallViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    
    self.viewModel = [[HXMallViewControllerViewModel alloc] init];
    [self.viewModel archiveFunctionData];
    
    HXBannerModel * model = [[HXBannerModel alloc] init];
    
    NSMutableArray * arr = [[NSMutableArray alloc] initWithObjects:model, nil];
    self.viewModel.bannarArr = arr;

    [self archiveKind];


    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).offset(0);
    }];
    
    self.scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self setUpBannerView];
    [self setUpCollectionView];
    [self bind];
    [self setUpTableView];
    [self archiveAd];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpNavigationTitleView];
    [self hiddenNavgationBarLine:YES];
    
    
    [[CurrentLocation sharedManager] gpsCityWithLocationAddress:^(AddressModelInfo *addressModel) {
        if (!addressModel) {
            if (!self.firstOnce) {
                self.viewModel.index = 1;
                [self request];
                self.firstOnce = YES;
                return ;
            }else {
                NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
                if (![self.locationButton.titleLabel.text isEqualToString:city]) {
                    [self.viewModel updatLetterListModel:[[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity]];
                    self.viewModel.index = 1;
                    [self request];
                    [self.viewModel.enjoyArr removeAllObjects];
                    [_tableView reloadData];
                    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(0);
                    }];
                    
                }

                
            }
            [self.locationButton setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity] forState:UIControlStateNormal];
            return;
        }
        self.viewModel.addressModelInfo = addressModel;
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
        if (!self.firstOnce) {
            self.viewModel.index = 1;
            [self request];
            self.firstOnce = YES;
            return ;
        }else {
            if (![self.locationButton.titleLabel.text isEqualToString:city]) {
                [self.viewModel updatLetterListModel:[[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity]];
                self.viewModel.index = 1;
                [self request];
                [self.viewModel.enjoyArr removeAllObjects];
                [_tableView reloadData];
                [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                }];
                
            }
        }
        
        [self.locationButton setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity] forState:UIControlStateNormal];
        return;
    }];
    
    
}

- (BOOL)hidesBottomBarWhenPushed {
    return (self.navigationController.topViewController != self);
}

-(void)request {
    [self.viewModel archiveRecently:^{
        if (self.viewModel.enjoyArr.count==0) {
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }else {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.viewModel.enjoyArr.count *90+44);
        }];
        }
        [self.tableView reloadData];
    }];
    
}
#pragma mark -- 获取种类
-(void)archiveKind {
    [self.viewModel achieveAssortment:^{
        [_collectionView reloadData];
        [self depositKind];
    }];
}
-(void)depositKind {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HXMallModel clearTable];
        NSLog(@"weqeqw%@",self.viewModel.functionData);
        for (HXMallModel * model in self.viewModel.functionData) {
            [model save];
        }
        
    });
}
#pragma mark -- 获取逛逛
-(void)archiveAd {
    [self.viewModel archiveAd:^{
        if (self.viewModel.bannarArr.count!=0) {
            
            [_bannerView reloadData];
        }
    }];
}

#pragma mark Property

- (TitileView *)titleView {
    if (!_titleView) {
        _titleView = [[TitileView alloc] initWithFrame:self.navigationController.navigationBar.frame];
    }
    return _titleView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"搜索商户，项目";
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        UITextField *searchField = [_searchBar valueForKey:@"searchField"];
        if (searchField) {
            [searchField setBackgroundColor:[UIColor whiteColor]];
            searchField.layer.cornerRadius = 14.0f;
            searchField.layer.masksToBounds = YES;
        }
    }
    return _searchBar;
}

- (UIButton *)locationButton {
    if (!_locationButton) {
        _locationButton = [[UIButton alloc] init];
        [_locationButton setTitle:self.viewModel.locationCity forState:UIControlStateNormal];
        [_locationButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.locationButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        _locationButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
        
        
    }
    return _locationButton;
}

- (UIButton *)pullDownIconButton {
    if (!_pullDownIconButton) {
        _pullDownIconButton = [[UIButton alloc] init];
        [_pullDownIconButton setBackgroundImage:[UIImage imageNamed:@"xialajiantou1"] forState:UIControlStateNormal];
        [_pullDownIconButton setBackgroundImage:[UIImage imageNamed:@"xialajiantou2"] forState:UIControlStateSelected];
        [_pullDownIconButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pullDownIconButton;
}

- (ZYBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[ZYBannerView alloc] init];
        _bannerView.dataSource = self;
        _bannerView.delegate = self;
        _bannerView.autoScroll = YES;
        _bannerView.scrollInterval = 5.0;
        _bannerView.shouldLoop = YES;
        _bannerView.backgroundColor = ColorWithHex(0xFFFFFF);
    }
    return _bannerView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HXMallCollectionViewCell class] forCellWithReuseIdentifier:@"HXMallCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewFlowLayout.minimumInteritemSpacing = 10;
        _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(30, 22,30, 22);
    }
    return _collectionViewFlowLayout;
}

#pragma mark 设置

- (void)setUpNavigationTitleView {
    
    [self.titleView addSubview:self.locationButton];
    
    [self.locationButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView).offset(5);
        make.centerY.equalTo(self.titleView);
        make.size.mas_equalTo(self.locationButton.titleLabel.intrinsicContentSize);
    }];
    [self.locationButton.titleLabel rz_removeTarget:self action:@selector(locationButtonTitleChanged) forKeyPathChange:RZDB_KP(UILabel, text)];
    [self.locationButton.titleLabel rz_addTarget:self action:@selector(locationButtonTitleChanged) forKeyPathChange:RZDB_KP(UILabel, text)];
    
    [self.titleView addSubview:self.pullDownIconButton];
    [self.pullDownIconButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationButton.mas_right);
        make.centerY.equalTo(self.titleView);
    }];
    
    [self.titleView addSubview:self.searchBar];
    [self.searchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleView).offset(0);
        make.height.mas_equalTo(28);
        make.centerY.equalTo(self.titleView);
        make.left.equalTo(self.pullDownIconButton.mas_right).offset(10);
    }];
    self.titleView.intrinsicContentSize = CGSizeMake(self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView = self.titleView;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"NavigationBarButton1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(messageClick)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HXCommercialCell class] forCellReuseIdentifier:@"DockBeautyCell"];
    [self.scrollView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        make.height.mas_offset(0);
        make.bottom.equalTo(self.scrollView);
    }];
}

- (void)setUpBannerView {
    [self.scrollView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.scrollView).offset(0);
        make.height.mas_equalTo(190);
    }];
}

- (void)setUpCollectionView {
    [self.scrollView addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.bannerView.mas_bottom).offset(10);
        make.height.mas_offset(135);
    }];
}

#pragma mark Bind

- (void)bind{
    [self.viewModel rz_addTarget:self action:@selector(locationCityChanged) forKeyPathChange:RZDB_KP(HXMallViewControllerViewModel, locationCity)];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.bounds.size.width-80)/self.viewModel.functionData.count, 75);
}

#pragma mark UICollectionViewDatasoure

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.viewModel.functionData.count>=5) {
        return 5;
    }
    return self.viewModel.functionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXMallCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HXMallCollectionViewCell alloc] init];
    }
    
    HXMallCollectionViewCellViewModel *mallCollectionViewCellViewModel = [[HXMallCollectionViewCellViewModel alloc] init];
    HXMallModel * model = self.viewModel.functionData[indexPath.row];
    if (model) {
    
        mallCollectionViewCellViewModel.imageName = [Helper photoUrl:model.imgUrl width:100 height:100];
        //
        mallCollectionViewCellViewModel.title = model.typeName?model.typeName:@"";
        
        
        cell.viewModel = mallCollectionViewCellViewModel;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMallModel * model =self.viewModel.functionData[indexPath.row];
    if ([model.id isEqualToString:@"A001"]) {
        BeautyClinicViewController * beauty = [[BeautyClinicViewController alloc] init];
        beauty.viewModel.hxmallModel = self.viewModel.functionData[indexPath.row];
        beauty.viewModel.letterModel = self.viewModel.letterModel;
        beauty.viewModel.addressModel = self.viewModel.addressModelInfo;
        beauty.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:beauty animated:YES];
    }else if([model.id isEqualToString:@"A002"]) {
        
        HXHoneyMoonViewController * honeyMoon = [[HXHoneyMoonViewController alloc] init];
        honeyMoon.viewModel.style = WeddingStyle;
        honeyMoon.viewModel.letterModel = self.viewModel.letterModel;;
        honeyMoon.viewModel.hxmallModel = self.viewModel.functionData[indexPath.row];
        honeyMoon.viewModel.addressModel = self.viewModel.addressModelInfo;
        [self.navigationController pushViewController:honeyMoon animated:YES];
        
    }else if([model.id isEqualToString:@"A003"]) {
        
        HXClubHouseViewController * hxmall = [[HXClubHouseViewController alloc] init];
        hxmall.viewModel.style = WeddingStyle;
        hxmall.viewModel.hxmallModel = self.viewModel.functionData[indexPath.row];
        hxmall.viewModel.letterModel = self.viewModel.letterModel;
        hxmall.viewModel.addressModel = self.viewModel.addressModelInfo;
        hxmall.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hxmall animated:YES];
        
    }else if([model.id isEqualToString:@"A004"]) {
        
        HXClubHouseViewController * hxmall = [[HXClubHouseViewController alloc] init];
        hxmall.viewModel.style = ConfinementStyle;
        hxmall.viewModel.hxmallModel = self.viewModel.functionData[indexPath.row];
        hxmall.viewModel.letterModel = self.viewModel.letterModel;
        hxmall.hidesBottomBarWhenPushed = YES;
        hxmall.viewModel.addressModel = self.viewModel.addressModelInfo;
        [self.navigationController pushViewController:hxmall animated:YES];
        
    }else if([model.id isEqualToString:@"A005"]){
        
        HXHoneyMoonViewController * honeyMoon = [[HXHoneyMoonViewController alloc] init];
        honeyMoon.viewModel.style = HoneymoonStyle;
        honeyMoon.viewModel.letterModel = self.viewModel.letterModel;
        honeyMoon.viewModel.hxmallModel = self.viewModel.functionData[indexPath.row];
        honeyMoon.viewModel.addressModel = self.viewModel.addressModelInfo;
        [self.navigationController pushViewController:honeyMoon animated:YES];
        
    }else {
        
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.enjoyArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXCommercialCell *dockBeautyCell = [tableView dequeueReusableCellWithIdentifier:@"DockBeautyCell"];
    if (!dockBeautyCell) {
        dockBeautyCell = [[HXCommercialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DockBeautyCell"];
    }
    dockBeautyCell.nameLabel.numberOfLines = 1;
    
    [dockBeautyCell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dockBeautyCell.contentView).offset(90);
        make.height.mas_equalTo(16);
    }];
    [dockBeautyCell.paymontLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dockBeautyCell.contentView).offset(90);
    }];
    DtoListModel *model = [self.viewModel.enjoyArr objectAtIndex:indexPath.row];
    dockBeautyCell.model = model;
    
    return dockBeautyCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.viewModel.enjoyArr.count==0) {
        return nil;
    }
    UIView *view = [[UIView alloc] init];
    
    UIView *leftSeperateLineView = [[UIView alloc] init];
    [view addSubview:leftSeperateLineView];
    leftSeperateLineView.backgroundColor = ColorWithHex(0xEEEEEE);
    [leftSeperateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(82);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [view addSubview:titleLabel];
    titleLabel.text = @"猜你喜欢";
    titleLabel.textColor = ColorWithHex(0x333333);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftSeperateLineView.mas_right).offset(15);
        make.centerY.equalTo(view);
        make.centerX.equalTo(view);
        make.width.mas_equalTo(titleLabel.intrinsicContentSize.width);
    }];
    
    UIView *rightSeperateLineView = [[UIView alloc] init];
    [view addSubview:rightSeperateLineView];
    rightSeperateLineView.backgroundColor = ColorWithHex(0xEEEEEE);
    [rightSeperateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(15);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(1);
        make.right.equalTo(view).offset(-82);
    }];
    
    UIView *bottomSeperateLineView = [[UIView alloc] init];
    [view addSubview:bottomSeperateLineView];
    bottomSeperateLineView.backgroundColor = ColorWithHex(0xEEEEEE);
    [bottomSeperateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(0);
        make.right.equalTo(view).offset(0);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(view);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.viewModel.enjoyArr.count!=0?44:0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 0;
    }
    return 5;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HXYmDetailsViewController * details = [[HXYmDetailsViewController alloc ] init];
    DtoListModel *model = [self.viewModel.enjoyArr objectAtIndex:indexPath.row];
    details.viewModel.merId = model.id;
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark ZYBannerViewDataSource

// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {
    return self.viewModel.bannarArr.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的v iew, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    // 取出数据
    HXBannerModel * model = self.viewModel.bannarArr[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:SCREEN_WIDTH height:380]] placeholderImage:[UIImage imageNamed:@"banner3"]];
    
    return imageView;
}

#pragma mark ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
    HXBannerModel * model;
    if (self.viewModel.bannarArr.count>=index+1) {
        
        model = [self.viewModel.bannarArr objectAtIndex:index];
    }
    if (!model.jumpParam) {
        return;
    }
    if ([model.jumpType isEqualToString:@"10"]) {
        HXWevbViewController * webView = [[HXWevbViewController alloc] init];
        webView.hidesBottomBarWhenPushed = YES;
        webView.htmlStr =model.jumpParam;
        [self.navigationController pushViewController:webView animated:YES];
        
    }
    if ([model.jumpType isEqualToString:@"20"]) {
        HXYmDetailsViewController * details = [[HXYmDetailsViewController alloc ] init];
        details.viewModel.merId = model.jumpParam?model.jumpParam:nil;
        [self.navigationController pushViewController:details animated:YES];
        
    }
    if ([model.jumpType isEqualToString:@"21"]) {
        HXProductDetailViewController * details = [[HXProductDetailViewController alloc ] init];
        details.viewModel.proId = model.jumpParam?model.jumpParam:nil;;
        [self.navigationController pushViewController:details animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    HXSearchViewController *controller = [[HXSearchViewController alloc] init];
    controller.letterModel = self.viewModel.letterModel;
    controller.viewModel.addressModel = self.viewModel.addressModelInfo;
    [self.navigationController pushViewController:controller animated:YES];
    return NO;
}

#pragma mark Private Methods

- (void)updateGps {
    [[CurrentLocation sharedManager] gpsCityWithLocationAddress:^(AddressModelInfo *addressModel) {
        if ([NSString isBlankString:addressModel.city]) {
            [KeyWindow displayMessage:@"你还没有开启定位权限"];
            return ;
        }
        self.viewModel.addressModelInfo = addressModel;
        
        self.viewModel.locationCity = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
        
        return;
    }];
}

- (void)messageClick {
    NSLog(@"消息中心");
    if (![AppManager manager].isOnline) {
        [Helper pushLogin:self];
        return;
    }
    HXMessageViewController * message = [[HXMessageViewController alloc] init];
    message.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:message animated:YES];
}

- (void)locationButtonTitleChanged {
    [self setUpNavigationTitleView];
}

- (void)locationCityChanged {
    if (![self.locationButton.titleLabel.text isEqualToString:self.viewModel.locationCity]) {
        [[NSUserDefaults standardUserDefaults] setObject:self.viewModel.locationCity forKey:kLocationCity];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.locationButton setTitle:self.viewModel.locationCity forState:UIControlStateNormal];
        [self.viewModel updatLetterListModel:[[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity]];
        self.viewModel.index = 1;
        [self request];
        [self.viewModel.enjoyArr removeAllObjects];
        [_tableView reloadData];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

- (void)loadMoreData {
    self.viewModel.index++;
    [self request];
    [self.scrollView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)selectCity:(UIButton *)button {
    HXCitySelectedViewController *cityController = [[HXCitySelectedViewController alloc] init];
    cityController.viewModel.gpsCity = self.viewModel.addressModelInfo.city;
    
    cityController.changeCity = ^(NSString *city) {
        self.viewModel.locationCity = city;
    };
    [self presentViewController:cityController animated:YES completion:nil];
    
}

@end
