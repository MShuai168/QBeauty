//
//  XMNPhotoPickerController.m
//  XMNPhotoPickerKitExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNPhotoPickerController.h"
#import "XMNPhotoCollectionController.h"

#import "XMNPhotoManager.h"

#import "XMNAlbumCell.h"
@interface XMNPhotoPickerController()
@property (nonatomic,strong)XMNAlbumListController *albumListC;
@end
@implementation XMNPhotoPickerController

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

#pragma mark - XMNPhotoPickerController Life Cycle

- (instancetype)initWithMaxCount:(NSUInteger)maxCount delegate:(id<XMNPhotoPickerControllerDelegate>)delegate {
    XMNAlbumListController *albumListC = [[XMNAlbumListController alloc] init];
    self.albumListC = albumListC;
    if (self = [super initWithRootViewController:albumListC]) {
        _photoPickerDelegate = delegate;
        _maxCount = maxCount ? : NSUIntegerMax;
        _autoPushToPhotoCollection = YES;
        _pickingVideoEnable = NO;
        [self optimalPhotoBtnPressed];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self _setupNavigationBarAppearance];
//    [self _setupUnAuthorizedTips];
}
- (void)optimalPhotoBtnPressed
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        // 第一次安装App，还未确定权限，调用这里
        if ([XMNPhotoPickerController isPhotoAlbumNotDetermined])
        {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            {
                // 该API从iOS8.0开始支持
                // 系统弹出授权对话框
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
                        {
//                            // 用户拒绝，跳转到自定义提示页面
//                            DeniedAuthViewController *vc = [[DeniedAuthViewController alloc] init];
//                            [self presentViewController:vc animated:YES completion:nil];
                            [self _setupUnAuthorizedTips];
                        }
                        else if (status == PHAuthorizationStatusAuthorized)
                        {
                            // 用户授权，弹出相册对话框
//                            [self presentToImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
                            [self.albumListC updatePhoto];
                        }
                    });
                }];
            }
            else
            {
//                // 以上requestAuthorization接口只支持8.0以上，如果App支持7.0及以下，就只能调用这里。
//                [self presentToImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
                [self.albumListC updatePhoto];
            }
        }
        else if ([XMNPhotoPickerController isPhotoAlbumDenied])
        {
//            // 如果已经拒绝，则弹出对话框
//            [self showAlertController:@"提示" message:@"拒绝访问相册，可去设置隐私里开启"];
            [self _setupUnAuthorizedTips];
        }
        else
        {
           
//            // 已经授权，跳转到相册页面
//            [self presentToImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
              [self.albumListC updatePhoto];
        }
    }
    else
    {
//        // 当前设备不支持打开相册
//        [self showAlertController:@"提示" message:@"当前设备不支持相册"];
    }
}
+ (BOOL)isPhotoAlbumDenied
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isPhotoAlbumNotDetermined
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusNotDetermined)
    {
        return YES;
    }
    return NO;
}
/**
 *  重写viewWillAppear方法
 *  判断是否需要自动push到第一个相册专辑内
 *  @param animated 是否需要动画
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.autoPushToPhotoCollection) {
    }
}

- (void)dealloc {
    NSLog(@"photo picker dealloc");
}

#pragma mark - XMNPhotoPickerController Methods

/**
 *  call photoPickerDelegate & didFinishPickingPhotosBlock
 *
 *  @param assets 具体回传的资源
 */
- (void)didFinishPickingPhoto:(NSArray<XMNAssetModel *> *)assets {
    NSMutableArray *images = [NSMutableArray array];
    [assets enumerateObjectsUsingBlock:^(XMNAssetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [images addObject:obj.previewImage];
    }];
    if (self.photoPickerDelegate && [self.photoPickerDelegate respondsToSelector:@selector(photoPickerController:didFinishPickingPhotos:sourceAssets:)]) {
        [self.photoPickerDelegate photoPickerController:self didFinishPickingPhotos:images sourceAssets:assets];
    }
    self.didFinishPickingPhotosBlock ? self.didFinishPickingPhotosBlock(images,assets) : nil;
}

- (void)didFinishPickingVideo:(XMNAssetModel *)asset {
    
    if (self.photoPickerDelegate && [self.photoPickerDelegate respondsToSelector:@selector(photoPickerController:didFinishPickingVideo:sourceAssets:)]) {
        [self.photoPickerDelegate photoPickerController:self didFinishPickingVideo:asset.previewImage sourceAssets:asset];
    }
    
    self.didFinishPickingVideoBlock ? self.didFinishPickingVideoBlock(asset.previewImage , asset) : nil;
}

- (void)didCancelPickingPhoto {
    if (self.photoPickerDelegate && [self.photoPickerDelegate respondsToSelector:@selector(photoPickerControllerDidCancel:)]) {
        [self.photoPickerDelegate photoPickerControllerDidCancel:self];
    }
    self.didCancelPickingBlock ? self.didCancelPickingBlock() : nil;
}

/**
 *  设置当用户未授权访问照片时提示
 */
- (void)_setupUnAuthorizedTips {
    if (![[XMNPhotoManager sharedManager] hasAuthorized]) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.frame = CGRectMake(8, 64, self.view.frame.size.width - 16, 300);
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.numberOfLines = 0;
        tipsLabel.font = [UIFont systemFontOfSize:16];
        tipsLabel.textColor = [UIColor blackColor];
        tipsLabel.userInteractionEnabled = YES;
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        tipsLabel.text = [NSString stringWithFormat:@"请在%@的\"设置-隐私-照片\"选项中，\r允许%@访问你的手机相册。",[UIDevice currentDevice].model,appName];
        [self.view addSubview:tipsLabel];
        
        //!!! bug 用户前往设置后,修改授权会导致app崩溃
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTipsTap)];
        [tipsLabel addGestureRecognizer:tap];
    }
}

/**
 *  处理当用户未授权访问相册时 tipsLabel的点击手势,暂时有bug
 */
- (void)_handleTipsTap {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

/**
 *  设置navigationBar的样式
 */
- (void)_setupNavigationBarAppearance {
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    if (iOS7Later) {
        self.navigationBar.barTintColor = kUIColorFromRGB(0xE93030);
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UINavigationBar *navigationBar;
    UIBarButtonItem *barItem;
    if (iOS9Later) {
        barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[XMNPhotoPickerController class]]];
        navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[XMNPhotoPickerController class]]];
    } else {
        barItem = [UIBarButtonItem appearanceWhenContainedIn:[XMNPhotoPickerController class], nil];
        navigationBar = [UINavigationBar appearanceWhenContainedIn:[XMNPhotoPickerController class], nil];
    }
    [barItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0f]}];
    [navigationBar setBarStyle:UIBarStyleBlackTranslucent];
}


@end

@implementation XMNAlbumListController

#pragma mark - XMNAlbumListController Life Cycle 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"照片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(_handleCancelAction)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 70.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"XMNAlbumCell" bundle:nil ] forCellReuseIdentifier:@"XMNAlbumCell"];
    
    
}
-(void)updatePhoto {
    
    XMNPhotoPickerController *imagePickerVC = (XMNPhotoPickerController *)self.navigationController;
    __weak typeof(*&self) wSelf = self;
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:imagePickerVC.pickingVideoEnable completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
        __weak typeof(*&self) self = wSelf;
        self.albums = [NSArray arrayWithArray:albums];
        [self.tableView reloadData];
    }];

    XMNPhotoCollectionController *photoCollectionC = [[XMNPhotoCollectionController alloc] initWithCollectionViewLayout:[XMNPhotoCollectionController photoCollectionViewLayoutWithWidth:self.view.frame.size.width]];
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:imagePickerVC.pickingVideoEnable completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
        photoCollectionC.album = [albums firstObject];
        [imagePickerVC pushViewController:photoCollectionC animated:NO];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self setNeedsStatusBarAppearanceUpdate];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - XMNAlbumListController Methods
- (void)_handleCancelAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    XMNPhotoPickerController *photoPickerVC = (XMNPhotoPickerController *)self.navigationController;
    [photoPickerVC didCancelPickingPhoto];
    
}


#pragma mark - XMNAlbumListController UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMNAlbumCell *albumCell = [tableView dequeueReusableCellWithIdentifier:@"XMNAlbumCell"];
    [albumCell configCellWithItem:self.albums[indexPath.row]];
    return albumCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XMNPhotoCollectionController *photoCollectionC = [[XMNPhotoCollectionController alloc] initWithCollectionViewLayout:[XMNPhotoCollectionController photoCollectionViewLayoutWithWidth:self.view.frame.size.width]];
    photoCollectionC.album = self.albums[indexPath.row];
    [self.navigationController pushViewController:photoCollectionC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


#pragma clang diagnostic pop

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
