//
//  HXHomeViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXHomeViewController.h"
#import "HXYmDetailsViewController.h"
#import "HXHomeViewModel.h"
#import "HXProductDetailViewController.h"
#import "CurrentLocation.h"
#import "HXCitySelectedViewController.h"
#import "HXActivityViewController.h"
#import "HXSignInViewController.h"
#import "HXFriendViewController.h"
#import "HXPartnerViewController.h"
#import "HXPartnerCenterViewController.h"
#import "HXPartnerResultViewController.h"
#import <ZYBannerView/ZYBannerView.h>
#import <RZDataBinding/RZDataBinding.h>
#import "VoListModel.h"
#import "HXBannerModel.h"
#import "HXWevbViewController.h"
#import "ComButton.h"
#import "HXMallCollectionViewCell.h"
#import "HXRecomendLayout.h"
#import "HXRecomdCollectionViewCell.h"
#import "BeautyClinicViewController.h"
#import "HXScoreProductDetailViewController.h"

#import "StoreListCell.h"  //门店列表
#import "HomeDetailViewController.h" //门店详情界面


@interface HXHomeViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource, ZYBannerViewDataSource, ZYBannerViewDelegate>

@property (nonatomic, strong) ComButton *locationButton; // 城市切换
@property (nonatomic, strong) ZYBannerView *bannerView;
@property (nonatomic, strong) HXHomeViewModel *hmViewModel;
@property (nonatomic, strong) NSMutableArray *projectArr;
@property (nonatomic, strong) HXScorePromptView *promptView;
@property (nonatomic, strong) UIButton *openScoreBtn;
@property (nonatomic, strong) ComButton *firstButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic, strong) UICollectionView *recomondCollection;
@property (nonatomic, strong) UIView * recomondRecomdView;
@property (nonatomic, strong) UIImageView * activeImage;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, copy) NSString *latitude;//纬度
@property (nonatomic, copy) NSString *longitude;//经度

@end

@implementation HXHomeViewController

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (iphone_X?205:185) + 108 + 100 + 45 + 230 + 45)];
//        _headerView.backgroundColor = [UIColor magentaColor];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (iphone_X?83:49) - 16)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreListCell"];
    if (!cell) {
//        cell = [[StoreListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreListCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreListCell" owner:nil options:nil] firstObject];
    }

    StoreListModel *model = self.projectArr[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreListModel *model = self.projectArr[indexPath.row];
    HomeDetailViewController *vc = [[HomeDetailViewController alloc] init];
    vc.id = model.id;
    vc.latitude = [self.latitude floatValue];
    vc.longitude = [self.longitude floatValue];
    NSLog(@"当前经纬度:%@  %@", self.longitude, self.latitude);
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.latitude = @"";
    self.longitude = @"";
    
    [self setNavigationBarBackgroundImage];
    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    self.hmViewModel = [[HXHomeViewModel alloc] initWithController:self];
    HXBannerModel * model = [[HXBannerModel alloc] init];
    
    NSMutableArray * arr = [[NSMutableArray alloc] initWithObjects:model, nil];
    self.hmViewModel.bannarArr = arr;
    
    [self setUpNavigation];
//    self.navigationItem.title = @"蔻蓓丽绮";
    self.navigationItem.title = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openScoreBool:) name:Notification_OpenScore object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signBool:) name:Notification_UserSign object:nil];
  
    [self.tableView addHeadRefreshWithRefreshingTarget:self refreshingAction:@selector(loadNewDataHome)];
    [self.tableView addFooterRefreshWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataHome)];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataHome)];
    [self archiveAd];
    
    if ([[AppManager manager] isOnline]) {
        [self archiveScoreBool];
        [self.hmViewModel changeMemBer];
        [self.hmViewModel whetherSign];
    }
    
    [self setUpBannerView];
    [self setUpCollectionView];
    [self setActiveView];
    [self creatRecommendCollectionview];
    [self setUpProjectView];
    [self creatScoreBtn];
    [self bind];

    NSString *locationCity = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    if (!locationCity) {
        [self request:YES];
        /*
          弹出定位提示界面
         */
        [self presentToSelectViewController];
        return;
    }
    
    [[CurrentLocation sharedManager] gpsCityWithLocationAddress:^(AddressModelInfo *addressModel) {
        if (locationCity) {
            self.hmViewModel.letterModel = [VoListModel inquiryLetterModelWithName:self.hmViewModel.locationCity];
            self.longitude = addressModel.longitude;
            self.latitude = addressModel.latitude;
            [self request:YES];
        }
        if (!addressModel) {
            return ;
        }
        if ([NSString isBlankString:addressModel.city]) {
            [KeyWindow displayMessage:@"你还没有开启定位权限"];
            self.longitude = @"";
            self.latitude = @"";
            return ;
        }
        self.hmViewModel.addressModelInfo = addressModel;
        self.longitude = addressModel.longitude;
        self.latitude = addressModel.latitude;

        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
        if ([city rangeOfString:addressModel.city].location == NSNotFound) {
            LetterListModel *letterModel = [VoListModel inquiryLetterModelWithName:addressModel.city];
            if (!letterModel) {
                return;
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"“%@”定位到您在%@，是否切换",[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]], addressModel.city] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"切换到%@",addressModel.city] style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      self.hmViewModel.locationCity = addressModel.city;
                                                                      NSLog(@"XXXXXXXXX 经度:%@ 纬度:%@",addressModel.longitude, addressModel.latitude);
                                                                      self.longitude = addressModel.longitude;
                                                                      self.latitude = addressModel.latitude;
                                                                      self.page = 1;
                                                                      [self loadStoreListData];
                                                                  }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * action) {
                                                                 }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        return;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hiddenNavgationBarLine:YES];
    self.hmViewModel.locationCity = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    
    //根据城市名称获取经纬度
    [self getLongitudeAndLatitudeWithCityName:self.hmViewModel.locationCity];
    
    if (![[AppManager manager] isOnline]) {
        self.rightButton.selected = NO;
    }
    //隐藏导航栏
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

//根据地名获取经纬度
-(void)getLongitudeAndLatitudeWithCityName:(NSString *)cityName {
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:cityName completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
//            NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            float longitude = firstPlacemark.location.coordinate.longitude;
            float latitude = firstPlacemark.location.coordinate.latitude;
//            NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
//            NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
            self.longitude = [NSString stringWithFormat:@"%f",longitude];
            self.latitude = [NSString stringWithFormat:@"%f",latitude];
            
            self.page = 1;
 //        //获取门店列表
            [self loadStoreListData];
        } else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
//        NSLog(@"根据城市名称获取 纬度:%@ 经度:%@",self.latitude, self.longitude);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //显示导航栏
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)hidesBottomBarWhenPushed {
    return (self.navigationController.topViewController != self);
}

-(void)archiveAd {
    [self.hmViewModel archiveAd:^{
        if (self.hmViewModel.bannarArr.count!=0) {
            [self.activeImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:self.hmViewModel.adUrlStr width:SCREEN_WIDTH*2 height:200]] placeholderImage:[UIImage imageNamed:@"banner3"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            [self.bannerView reloadData];
        }
//        [_bannerView startTimer];
    }];
}

/**
 获取是否打开积分礼盒
 */
-(void)archiveScoreBool {
    [self.hmViewModel archiveGetPacksBoolWithReturnBlock:^{
        if (self.hmViewModel.scoreBool) {
            self.openScoreBtn.hidden = NO;
        } else {
            self.openScoreBtn.hidden = YES;
        }
    } fail:^{
        self.openScoreBtn.hidden = YES;
    }];
}
-(void)request:(BOOL)refreshAll {
    dispatch_group_t group = dispatch_group_create();
    if (refreshAll) {
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            [self.hmViewModel archivewRecommendProduceWithSuccessBlock:^{
                dispatch_semaphore_signal(semaphore);
            } failBlock:^{
                [self endRefesh];
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        });
    }
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [self.hmViewModel archiveProject:^(id responseObject){
//            self.projectArr = responseObject;
            dispatch_semaphore_signal(semaphore);
        } fail:^{
            [self endRefesh];
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self endRefesh];
            if (refreshAll) {
                [self.recomondCollection reloadData];
            }
            [self.tableView reloadData];
        });
    });
}

- (void)bind {
    [self.hmViewModel rz_addTarget:self action:@selector(locationCityChanged) forKeyPathChange:RZDB_KP(HXHomeViewModel, locationCity) callImmediately:NO];
    [self.hmViewModel rz_addTarget:self action:@selector(isCheckIn) forKeyPathChange:RZDB_KP(HXHomeViewModel, isCheckIn)];
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setImage:[UIImage imageNamed:@"qiandao_score"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"qiandao_score_disable"] forState:UIControlStateSelected];
    }
    return _rightButton;
}

- (void)setUpNavigation {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;

    [self.locationButton.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationButton);
        make.centerY.equalTo(self.locationButton);
        make.size.mas_equalTo(self.locationButton.nameLabel.intrinsicContentSize);
    }];
    [self.locationButton.nameLabel rz_removeTarget:self action:@selector(locationButtonTitleChanged) forKeyPathChange:RZDB_KP(UILabel, text)];
    [self.locationButton.nameLabel rz_addTarget:self action:@selector(locationButtonTitleChanged) forKeyPathChange:RZDB_KP(UILabel, text)];
    [self.locationButton.photoImage setImage:[UIImage imageNamed:@"xialajiantou1"]];
    [self.locationButton.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationButton.nameLabel.mas_right);
        make.centerY.equalTo(self.locationButton);
        make.size.mas_equalTo([UIImage imageNamed:@"xialajiantou1"].size);
    }];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.locationButton];
    
 if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)){
        [self.locationButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBarButtonItem.customView);
            make.top.equalTo(leftBarButtonItem.customView);
            make.height.mas_equalTo(32);
            make.width.mas_equalTo(100);
        }];
    }
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)setUpBannerView {
    self.bannerView = [[ZYBannerView alloc] init];
    self.bannerView.dataSource = self;
    self.bannerView.delegate = self;
    self.bannerView.autoScroll = YES;
    self.bannerView.scrollInterval = 5.0;
    self.bannerView.shouldLoop = YES;
    self.bannerView.backgroundColor = ColorWithHex(0xFFFFFF);
    [self.headerView addSubview:self.bannerView];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headerView);
        make.height.mas_equalTo(iphone_X?205:185);
    }];
}
- (void)setUpCollectionView {
    [self.headerView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView).offset(0);
        make.top.equalTo(self.bannerView.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_offset(108);
    }];
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
        _collectionViewFlowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-44)/3, 108); //设置标题框大小
        _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10); //内边距
    }
    return _collectionViewFlowLayout;
}

- (void)setActiveView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openAdAction)];
    UIImageView * activeImage = [[UIImageView alloc] init];
    [activeImage addGestureRecognizer:tap];
    activeImage.userInteractionEnabled = YES;
    activeImage.image = [UIImage imageNamed:@"banner3"];
    self.activeImage = activeImage;
    [self.headerView addSubview:activeImage];
    [activeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(0);
        make.left.equalTo(self.headerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(100);
    }];
}

- (void)creatRecommendCollectionview {
    UIView * recomdView = [[UIView alloc] initWithFrame:CGRectMake(0, iphone_X?413:393, SCREEN_WIDTH, 45)];
    recomdView.backgroundColor = COLOR_BACKGROUND;
    self.recomondRecomdView = recomdView;
    [self.headerView addSubview:recomdView];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"推荐产品";
    titleLabel.textColor = kUIColorFromRGB(0x444444);
//    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [recomdView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recomdView).offset(15);
        make.centerY.equalTo(recomdView);
    }];
    
    UILabel * hotLabel  = [[UILabel alloc] init];
    hotLabel.textColor = kUIColorFromRGB(0xFF6098);
    hotLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    hotLabel.text = @"HOT";
    [recomdView addSubview:hotLabel];
    [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.left.equalTo(recomdView).offset(80);
    }];
    
    ComButton * arrowBtn = [[ComButton alloc] init];
    arrowBtn.photoImage.image = [UIImage imageNamed:@"homelistarrow"];
    arrowBtn.nameLabel.text = @"更多";
//    arrowBtn.tag = BtnTag;
    [arrowBtn addTarget:self action:@selector(arrowBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [recomdView addSubview:arrowBtn];
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(recomdView);
        make.top.and.bottom.equalTo(recomdView);
        make.width.mas_equalTo(100);
    }];
    arrowBtn.nameLabel.font = [UIFont systemFontOfSize:13];
    arrowBtn.nameLabel.textColor = ComonCharColor;
    [arrowBtn.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowBtn.mas_right).offset(-15);
        make.centerY.equalTo(arrowBtn);
    }];
    [arrowBtn.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowBtn.photoImage.mas_left).offset(0);
        make.centerY.equalTo(arrowBtn);
    }];
    
    HXRecomendLayout *layout = [HXRecomendLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.recomondRecomdView.frame), SCREEN_WIDTH,226) collectionViewLayout:layout];
    self.recomondCollection = collectionView;
    [self.headerView addSubview:collectionView];
    collectionView.backgroundColor = CommonBackViewColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HXRecomdCollectionViewCell class] forCellWithReuseIdentifier:@"identifier1"];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recomdView.mas_bottom).offset(0);
        make.left.equalTo(self.headerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(226);
    }];
}

/**
 推荐项目
 */
- (void)setUpProjectView {
    UIView * recomdView = [[UIView alloc] initWithFrame:CGRectMake(0, iphone_X?(413+45+230):(393+45+230), SCREEN_WIDTH, 45)];
//    self.linkRecomdView= recomdView;
    recomdView.backgroundColor = COLOR_BACKGROUND;
    [self.headerView addSubview:recomdView];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"蔻蓓丽绮 ";
    titleLabel.textColor = kUIColorFromRGB(0x444444);
//    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [recomdView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recomdView).offset(15);
        make.centerY.equalTo(recomdView);
    }];
    UILabel * hotLabel  = [[UILabel alloc] init];
    hotLabel.textColor = kUIColorFromRGB(0xd3b576);
    hotLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    hotLabel.text = @"QBeauty";
    [recomdView addSubview:hotLabel];
    [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.left.equalTo(recomdView).offset(80);
    }];
}

-(void)creatScoreBtn {
    UIButton * openScoreBtn = [[UIButton alloc] init];
    self.openScoreBtn = openScoreBtn;
    openScoreBtn.hidden = [AppManager manager].isOnline?YES:NO;
    [openScoreBtn setBackgroundImage:[UIImage imageNamed:@"gouwuBtn"] forState:UIControlStateNormal];
    [openScoreBtn addTarget:self action:@selector(openScoreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openScoreBtn];
    [openScoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-135);
        make.right.equalTo(self.view);
    }];
}
#pragma mark UICollectionViewDatasoure
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.collectionView]) {
        return 3;
    }else if ([collectionView isEqual:self.recomondCollection]){
        return self.hmViewModel.recomendArr.count;
    }else {
//        return self.projectArr.count;
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.collectionView]) {
        HXMallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXMallCollectionViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[HXMallCollectionViewCell alloc] init];
        }
//        NSArray * nameArr = @[@"医美护肤",@"趣淘商城",@"礼品兑换",@"合伙人"];
//        NSArray * photoNameArr = @[@"icon2",@"homeQuTao",@"icon4",@"hehuorenIndex"];
        NSArray * nameArr = @[@"邀请好友",@"礼品兑换",@"合伙人"];
        NSArray * photoNameArr = @[@"invited",@"icon4",@"hehuorenIndex"];
        HXMallCollectionViewCellViewModel * viewModel = [[HXMallCollectionViewCellViewModel alloc] init];
        viewModel.title = [nameArr objectAtIndex:indexPath.row];
        viewModel.imageName = [photoNameArr objectAtIndex:indexPath.row];
        cell.viewModel = viewModel;
        return cell;
    } else if([collectionView isEqual:self.recomondCollection]) {
        HXRecomdCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier1" forIndexPath:indexPath];
        cell.model = [self.hmViewModel.recomendArr objectAtIndex:indexPath.row];
        return cell;
    }
    else {
        return nil;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:_collectionView]) {
        if (indexPath.row==0) {
//             邀请好友
            HXFriendViewController *controller = [[HXFriendViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
//            //趣淘
//            self.tabBarController.selectedIndex = 1;
        } else if (indexPath.row == 1) {
//            //礼品兑换
            NSString *url = kExchangeUrl;
            HXWKWebViewViewController *controller = [[HXWKWebViewViewController alloc] init];
            controller.title = @"礼品兑换";
            controller.url = url;
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            if (![[AppManager manager] isOnline]) {
                [Helper pushLogin:self];
                return;
            }
            //合伙人
            [self archivePartnerStates];
        }
    }
    if ([collectionView isEqual:_recomondCollection]) {
        HXShopCarModel * model = [self.hmViewModel.recomendArr objectAtIndex:indexPath.row];
        
        HXScoreProductDetailViewController *controller = [[HXScoreProductDetailViewController alloc] init];
        controller.title = @"商品详情";
        NSString * url  = [NSString stringWithFormat:@"%@goods/%@/%@",kScoreUrl,model.id, K_CURRENT_TIMESTAMP];
        controller.url = url;
        controller.isTransparente = NO;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark ZYBannerViewDataSource

// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {
    return self.hmViewModel.bannarArr.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的v iew, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    // 取出数据
    HXBannerModel * model = self.hmViewModel.bannarArr[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:SCREEN_WIDTH*2 height:185*2]] placeholderImage:[UIImage imageNamed:@"banner3"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

#pragma mark ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
    HXBannerModel * model;
    if (self.hmViewModel.bannarArr.count >= index+1) {
        model = [self.hmViewModel.bannarArr objectAtIndex:index];
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

#pragma mark - Private
- (void)archivePartnerStates {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary * dic =@{
                          };
    [[HXNetManager shareManager] get:PartnerRouter parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            //0:千城招募   1:个人中心   2:订单结果页
            if ([[responseNewModel.body objectForKey:@"isPartner"] intValue]==0) {
                NSString *inviterCode = [responseNewModel.body objectForKey:@"inviterCode"];
                HXPartnerViewController *controller = [[HXPartnerViewController alloc] init];
                controller.inviterCode = inviterCode?inviterCode:@"";
                [self.navigationController pushViewController:controller animated:YES];
            }else if ([[responseNewModel.body objectForKey:@"isPartner"] intValue]==1) {
                HXPartnerCenterViewController * controller = [[HXPartnerCenterViewController alloc] init];
                [self.navigationController pushViewController:controller animated:YES];
            }else if ([[responseNewModel.body objectForKey:@"isPartner"] intValue]==2) {
                HXPartnerResultViewController * result = [[HXPartnerResultViewController alloc] init];
                if ([responseNewModel.body objectForKey:@"orderId"]) {
                    result.viewModel.id = [NSString stringWithFormat:@"%@",[responseNewModel.body objectForKey:@"orderId"]];
                }
                [self.navigationController pushViewController:result animated:YES];
            }
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (BOOL)isSign {
    if (![[AppManager manager] isOnline]) {
        [Helper pushLogin:self];
        return NO;
    }
    return YES;
}

- (void)isCheckIn {
    self.rightButton.hidden = NO;
    self.rightButton.selected = self.hmViewModel.isCheckIn;
}

- (void)locationCityChanged {
    self.hmViewModel.letterModel = [VoListModel inquiryLetterModelWithName:self.hmViewModel.locationCity];
    if (![self.locationButton.nameLabel.text isEqualToString:self.hmViewModel.locationCity]) {
        [[NSUserDefaults standardUserDefaults] setObject:self.hmViewModel.locationCity forKey:kLocationCity];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.locationButton.nameLabel setText:self.hmViewModel.locationCity];
        if (self.hmViewModel.locationCity) {
//            [self.projectArr removeAllObjects];
            [self request:NO];
        }
    }
}

- (void)locationButtonTitleChanged {
    [self setUpNavigation];
}

- (void)selectCity:(UIButton *)button {
    [self presentToSelectViewController];
}

- (void)presentToSelectViewController {
    HXCitySelectedViewController *cityController = [[HXCitySelectedViewController alloc] init];
    cityController.viewModel.gpsCity = self.hmViewModel.addressModelInfo.city;
    cityController.viewModel.addressModelInfo = self.hmViewModel.addressModelInfo;
    
    cityController.changeCity = ^(NSString *city) {
        self.hmViewModel.locationCity = city;
        [self getLongitudeAndLatitudeWithCityName:city];
    };
    [self presentViewController:cityController animated:YES completion:nil];
}

#pragma mark - refresh
- (void)loadNewDataHome {
    [self request:YES];
    [self archiveAd];
    
    self.page = 1;
    [self loadStoreListData];
}
- (void)loadMoreDataHome {
    self.page += 1;
    [self loadStoreListData];
}

- (void)openScoreBool:(NSNotification *)noti {
    if ([AppManager manager].isOnline) {
        [self archiveScoreBool];
    } else {
        self.openScoreBtn.hidden = NO;
    }
}
-(void)signBool:(NSNotification *)noti {
    if ([AppManager manager].isOnline) {
        [self.hmViewModel whetherSign];
    }else {
        self.rightButton.selected = NO;
    }
}
#pragma mark -- openScoreBtnAction
-(void)openScoreBtnAction {
    if (![AppManager manager].isOnline) {
        [Helper pushLogin:self];
        return;
    }
    __weak typeof(*&self) wSelf = self;
    self.promptView = [[HXScorePromptView alloc] initWithScore:^(NSString * openStr){
        __weak typeof(*&self) self = wSelf;
        if (![openStr boolValue]) {
            self.promptView.freeView.hidden = YES;
            [self.hmViewModel openScoreWithWithReturnBlock:^{
                self.promptView.freeView.hidden = NO;
                [self.promptView changeScore:self.hmViewModel.score.length!=0?self.hmViewModel.score:@"0"];
            } fail:^{
                [self.promptView removeFromSuperview];
                self.promptView = nil;
            }];
        }else {
            self.openScoreBtn.hidden = YES;
        }
    }];
}
#pragma mark -- 结束刷新
- (void)endRefesh {
    [self.tableView.mj_header endRefreshing];
}

- (void)rightButtonClick:(UIButton *)button {
//    NSLog(@"签到");
    if (![self isSign]) {
        return;
    }
    for (UIViewController *childViewController in self.childViewControllers) {
        if ([childViewController isMemberOfClass:[HXSignInViewController class]]) {
            [(HXSignInViewController *)childViewController dismiss];
            return;
        }
    }
    HXSignInViewController *controller = [[HXSignInViewController alloc] init];
    controller.block = ^{
        self.rightButton.selected = YES;
    };
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    [self.view addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(void)arrowBtnAction:(ComButton *)button {
    HXWKWebViewViewController *controller = [[HXWKWebViewViewController alloc] init];
    controller.title = @"趣贝兑换";
    NSString * url  = [NSString stringWithFormat:@"%@scorelist/0/%@",kScoreUrl, K_CURRENT_TIMESTAMP];
    controller.url = url;
    controller.isTransparente = NO;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)openAdAction {
    HXActivityViewController * activeController = [[HXActivityViewController alloc] init];
    [self.navigationController pushViewController:activeController animated:YES];
}

#pragma mark -- setter
- (ComButton *)locationButton {
    if (!_locationButton) {
        _locationButton = [[ComButton alloc] init];
        _locationButton.frame = CGRectMake(0, 0, 100, 32);
        [_locationButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
        [_locationButton.nameLabel setText:self.hmViewModel.locationCity];
        [_locationButton.nameLabel setTextColor:ColorWithHex(0x666666)];
//        _locationButton.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
        _locationButton.nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _locationButton;
}

- (NSMutableArray *)projectArr {
    if (_projectArr == nil) {
        _projectArr = [NSMutableArray array];
    }
    return _projectArr;
}

- (void)loadStoreListData {
    NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%d",self.page], @"rows":@10, @"selfLo":self.longitude, @"selfLa":self.latitude};
//    NSLog(@"XXXXX%@  %@", self.latitude, self.longitude);
    [[HXNetManager shareManager] get:@"tenant/queryTenantList" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if (self.page == 1) {
            [self.projectArr removeAllObjects];
        }
        if ([responseNewModel.status isEqualToString:@"0000"]) {
//            NSLog(@"%@",responseNewModel);
            NSArray *tenantList = [responseNewModel.body valueForKey:@"tenantList"];
            for (NSDictionary *dict in tenantList) {
                StoreListModel *model = [StoreListModel initWithDictionary:dict];
                [self.projectArr addObject:model];
            }
            [self.tableView reloadData];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
        //停止刷新
        [self.tableView endRefreshHeaderAndFooter];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
