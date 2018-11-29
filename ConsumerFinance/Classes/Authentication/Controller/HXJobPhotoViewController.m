////
////  HXJobPhotoViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/14.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXJobPhotoViewController.h"
//#import "SelectPhotoView.h"
//#import "XMNPhotoPickerController.h"
//#import "ComButton.h"
//#import "HXPhotoSave.h"
//#import "HXPhotoModel.h"
//#import "HXJobPhotoCollectionViewCell.h"
//#import "HXPhotoProgress.h"
//static CGRect oldframe;
//#define deletePhotoTag 500
//#define cellTag 1000
//#define upLoadTag 200
//@interface HXJobPhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,progressDelegate>
//@property (nonatomic,strong)UICollectionView *collectionView;
//@property (nonatomic,strong)NSMutableArray * photoArr;//未上传到安硕的图片
//@property (nonatomic,strong)NSMutableArray * havePhotoArr;//已经上传到安硕的图片
//@property (nonatomic,assign)NSInteger havePhotoIndex;//刷新标记
//
//@property (nonatomic,strong) UIButton * referButton;
//@property (nonatomic,strong)HXPhotoSave * savePhoto;//保存图片工具类
//@property (nonatomic,strong) HXPhotoProgress * progress;//进度框
//
//@property (nonatomic,assign)NSInteger notUploadedNumber;//没有上传到安硕的图片
//
//@property (nonatomic,assign)NSInteger haveSeeAllNumber;//已经上传到安硕的可以观看图片数量
//@end
//
//@implementation HXJobPhotoViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXJobViewModel alloc] initWithController:self];
//        self.haveSeeAllNumber = 0;
//        self.notUploadedNumber = 0;
//        self.havePhotoIndex = 1;
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
//    /**
//     *  获取当前总类对应的id
//     */
//    [self.viewModel archiveKindType];
//    [self archivePhoto];
//}
//
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.viewModel archiveNameAndTitle];
//    self.title = self.viewModel.title;
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//    self.view.backgroundColor = COLOR_BACKGROUND;
//}
//-(void) hiddeKeyBoard{
//    
//    [self.view endEditing:YES];
//    
//}
//-(void)createUI {
//    
//    UIView * titleBackView = [[UIView alloc] init];
//    titleBackView.backgroundColor = kUIColorFromRGB(0xFEFCEC);
//    [self.view addSubview:titleBackView];
//    if (self.viewModel.catory == CertificateIdentify) {
//        [titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view);
//            make.width.mas_equalTo(SCREEN_WIDTH);
//            make.height.mas_equalTo(90);
//            make.top.equalTo(self.view);
//        }];
//    }else {
//        [titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view);
//            make.width.mas_equalTo(SCREEN_WIDTH);
//            make.height.mas_equalTo(45);
//            make.top.equalTo(self.view);
//        }];
//    }
//    
//    UILabel * titleLabel = [[UILabel alloc] init];
//    titleLabel.font = [UIFont systemFontOfSize:13];
//    titleLabel.textColor = kUIColorFromRGB(0xE0A443) ;
//    titleLabel.text = self.viewModel.content;
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    [titleBackView addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(titleBackView).offset(15);
//        make.width.mas_equalTo(SCREEN_WIDTH-30);
//        make.height.mas_equalTo(13);
//        make.top.equalTo(titleBackView).offset(16);
//    }];
//    
//    if (self.viewModel.catory == CertificateIdentify) {
//        titleLabel.text = @"身份证正面反面+手持身份证照片";
//        for (int i =0 ; i<2; i++) {
//            UILabel * nameLabel = [[UILabel alloc] init];
//            nameLabel.font = [UIFont systemFontOfSize:13];
//            nameLabel.textColor = kUIColorFromRGB(0xE0A443) ;
//            if (i==0) {
//                nameLabel.text = @"(或) 户口本首页及本人页+临时身份证+手持身份证";
//            }else {
//                nameLabel.text = @"(或) 驾驶证+临时身份证+手持临时身份证";
//            }
//            nameLabel.textAlignment = NSTextAlignmentLeft;
//            [titleBackView addSubview:nameLabel];
//            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(titleBackView).offset(15);
//                make.width.mas_equalTo(SCREEN_WIDTH-30);
//                make.height.mas_equalTo(13);
//                make.top.equalTo(titleLabel.mas_bottom).offset(10+i*23);
//            }];
//            
//        }
//    }
//    
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT-129, SCREEN_WIDTH-30, 50)];
//    self.referButton = referButton;
//    self.referButton.enabled = NO;
//    [referButton setTitle:@"保存" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0xcccccc) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [self.view addSubview:referButton];
//    
//    
//    [self creatCollectionview];
//}
//-(void)creatCollectionview {
//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    layout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/2, 115);
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.minimumLineSpacing = 5;
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(30, 60, SCREEN_WIDTH-50,SCREEN_HEIGHT-60-64-75) collectionViewLayout:layout];
//    if (self.viewModel.catory == CertificateIdentify) {
//        collectionView.frame = CGRectMake(30, 105, SCREEN_WIDTH-50, SCREEN_HEIGHT-105-64-75);
//    }
//    _collectionView = collectionView;
//    collectionView.backgroundColor = COLOR_BACKGROUND;
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//    collectionView.scrollsToTop = NO;
//    collectionView.showsVerticalScrollIndicator = NO;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    [collectionView registerClass:[HXJobPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
//    [collectionView registerClass:[HXJobPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"identifier1"];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"idenOne"];
//    [self.view addSubview:collectionView];
//    [_collectionView registerClass:[UICollectionViewCell class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader"];
//    [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collettionSectionFoot"];
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 2;
//}
//
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (section==1) {
//        if (self.havePhotoArr.count>self.havePhotoIndex*10) {
//            self.haveSeeAllNumber = self.havePhotoIndex*10;
//            return self.havePhotoIndex*10;
//        }
//        self.haveSeeAllNumber = self.havePhotoArr.count;
//        return self.havePhotoArr.count;
//    }
//    return self.photoArr.count+1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==1) {
//        HXJobPhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier1" forIndexPath:indexPath];
//        HXPhotoModel * photoModel = [self.havePhotoArr objectAtIndex:indexPath.row];
//        [cell.upLoadBtn addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
//        cell.model = photoModel;
//        cell.tag = indexPath.row+cellTag;
//        return cell;
//    }else {
//        if (indexPath.row==0 ) {
//            UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"idenOne" forIndexPath:indexPath];
//            //        cell.contentView.backgroundColor = kUIColorFromRGB(0x55A0FC);
//            UIView * backView = [[UIView alloc] init];
//            backView.backgroundColor = kUIColorFromRGB(0x55A0FC);
//            [cell.contentView addSubview:backView];
//            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.and.bottom.equalTo(cell.contentView);
//                make.top.equalTo(cell.contentView).mas_equalTo(10);
//                make.right.equalTo(cell.contentView.mas_right).offset(-10);
//            }];
//            /**
//             *  icon
//             *
//             */
//            UIImageView * image = [[UIImageView alloc] init];
//            [image setImage:[UIImage imageNamed:@"takephoto"]];
//            image.contentMode = UIViewContentModeScaleAspectFit;
//            [backView addSubview:image];
//            [image mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(backView);
//                make.top.equalTo(backView).offset(15);
//                make.height.mas_equalTo(60);
//                make.width.mas_equalTo(110);
//            }];
//            /**
//             *  标题
//             *
//             */
//            UILabel * titleLabel = [[UILabel alloc] init];
//            titleLabel.text = self.orderPhoto?@"上传影像":@"上传凭证";
//            titleLabel.adjustsFontSizeToFitWidth = YES;
//            titleLabel.textColor= kUIColorFromRGB(0xffffff);
//            titleLabel.font = [UIFont systemFontOfSize:14];
//            [backView addSubview:titleLabel];
//            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(backView);
//                make.top.equalTo(image.mas_bottom).offset(10);
//            }];
//            return cell;
//            
//        }else {
//            HXJobPhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
//            HXPhotoModel * photoModel = [self.photoArr objectAtIndex:(indexPath.row-1)];
//            [cell.upLoadBtn addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
//            cell.nostates = YES;
//            cell.model = photoModel;
//            cell.upLoadBtn.tag = indexPath.row+upLoadTag;
//            [cell.deleteButton addTarget:self action:@selector(delegateAction:) forControlEvents:UIControlEventTouchUpInside];
//            cell.deleteButton.tag = indexPath.row-1 + deletePhotoTag;
//            cell.tag = indexPath.row+cellTag;
//            return cell;
//        }
//    }
//}
////设置sectionHeader | sectionFoot
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        UICollectionReusableView* view = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader" forIndexPath:indexPath];
//        return view;
//    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//        UICollectionReusableView* view = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collettionSectionFoot" forIndexPath:indexPath];
//        UILabel * nameLabel = [[UILabel alloc] init];
//        nameLabel.font = [UIFont systemFontOfSize:14];
//        nameLabel.textColor = ComonCharColor;
//        [view addSubview:nameLabel];
//        nameLabel.text = @"已审核影像";
//        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(view).offset(5);
//            make.centerX.equalTo(view);
//        }];
//        
//        UIView * lineView = [[UIView alloc] init];
//        lineView.backgroundColor = kUIColorFromRGB(0xCCCCCC);
//        [view addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view);
//            make.right.equalTo(nameLabel.mas_left).offset(-15);
//            make.height.mas_equalTo(0.5);
//            make.centerY.equalTo(view).offset(5);
//        }];
//        
//        UIView * rightLineView = [[UIView alloc] init];
//        rightLineView.backgroundColor = kUIColorFromRGB(0xCCCCCC);
//        [view addSubview:rightLineView];
//        [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(nameLabel.mas_right).offset(15);
//            make.right.equalTo(view);
//            make.height.mas_equalTo(0.5);
//            make.centerY.equalTo(view).offset(5);
//        }];
//        return view;
//    }else{
//        return nil;
//    }
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    if (section==1) {
//        return CGSizeZero;
//    }else {
//        if (self.havePhotoArr.count!=0) {
//            
//            CGFloat height = 80;
//            return CGSizeMake(SCREEN_WIDTH, height);
//        }else {
//            return CGSizeZero;
//        }
//    }
//}
//// 返回虚线image的方法
//- (UIImage *)drawLineByImageView:(UIImageView *)imageView{
//    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
//    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//    //设置线条终点形状
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    // 5是每个虚线的长度 1是高度
//    CGFloat lengths[] = {1,1};
//    CGContextRef line = UIGraphicsGetCurrentContext();
//    // 设置颜色
//    CGContextSetStrokeColorWithColor(line, ComonCharColor.CGColor);
//    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
//    CGContextMoveToPoint(line, 0.0, 2.0); //开始画线
//    CGContextAddLineToPoint(line, SCREEN_WIDTH - 10, 2.0);
//    
//    CGContextStrokePath(line);
//    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
//    return UIGraphicsGetImageFromCurrentImageContext();
//}
//
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
//    if (indexPath.section == 1) {
//        
//        NSMutableArray * dataArr = [[NSMutableArray alloc] init] ;
//        for (int i = 0; i<self.haveSeeAllNumber; i++) {
//            HXPhotoModel * model = [self.havePhotoArr objectAtIndex:i];
//            if (model.photoImage) {
//                [dataArr addObject:model.photoImage];
//            }else {
//                [dataArr addObject:model.comPhotoUrl];
//            }
//        }
//        [self openPhotoBrowseWithPhotoArr:dataArr index:indexPath cell:cell];
//    }
//    if (indexPath.section == 0&&indexPath.row!=0) {
//        NSMutableArray * dataArr = [[NSMutableArray alloc] init] ;
//        for (int i = 0; i<self.photoArr.count; i++) {
//            HXPhotoModel * model = [self.photoArr objectAtIndex:i];
//            if (model.photoImage) {
//                [dataArr addObject:model.photoImage];
//            }else {
//                [dataArr addObject:model.comPhotoUrl];
//            }
//        }
//        [self openPhotoBrowseWithPhotoArr:dataArr index:indexPath cell:cell];
//    }
//    
//    if (indexPath.row==0&&indexPath.section==0) {
//        if (self.photoArr.count>=10) {
//            [KeyWindow displayMessage:@"最多上传10张图片"];
//            return;
//        }
//        UIActionSheet* action = [[UIActionSheet alloc]
//                                 initWithTitle:nil
//                                 delegate:self
//                                 cancelButtonTitle:@"取消"
//                                 destructiveButtonTitle:@"我的相册"
//                                 otherButtonTitles:@"拍照",nil];
//        action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//        
//        [action showInView:self.view];
//    }
//}
//#pragma mark -- 打开图片浏览器
//-(void)openPhotoBrowseWithPhotoArr:(NSMutableArray *)dataArr index:(NSIndexPath *)indexPath cell:(UICollectionViewCell *)cell {
//    SelectPhotoView * photo = [[SelectPhotoView alloc] initWithDataArr:dataArr];
//    photo.index = indexPath.section==1?indexPath.row:indexPath.row-1;
//    photo.alpha = 0;
//    oldframe = [cell convertRect:cell.bounds toView:[UIApplication sharedApplication].keyWindow];
//    photo.frame = oldframe;
//    [[UIApplication sharedApplication].keyWindow addSubview:photo];
//    [UIView animateWithDuration:0.3 animations:^{
//        photo.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        photo.alpha = 1;
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    __block typeof(photo) weakSelf = photo;
//    photo.selectDeselect = ^(){
//        [UIView animateWithDuration:0.3 animations:^{
//            weakSelf.frame = oldframe;
//            weakSelf.alpha  = 0;
//        } completion:^(BOOL finished) {
//            [weakSelf removeFromSuperview];
//            weakSelf = nil;
//            
//        }];
//    };
//}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        NSLog(@"进入相册");
//        [self photo];
//        
//    }else if (buttonIndex == 1) {
//        [self camera];
//    }else if(buttonIndex == 2) {
//        NSLog(@"取消");
//    }
//}
//- (void) camera
//{
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==YES) {
//        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
//        imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
//        imagePicker.delegate = self;
//        //        _imagePicker.allowsEditing = YES;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//        
//    }
//    
//}
//- (void)photo
//{
//    
//    //1.初始化一个XMNPhotoPickerController
//    XMNPhotoPickerController * photoPickerC = [[XMNPhotoPickerController alloc] initWithMaxCount:10-self.photoArr.count delegate:nil];
//    
//    //3..设置选择完照片的block 回调
//    __weak typeof(*&self) wSelf = self;
//    [photoPickerC setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
//        __weak typeof(*&self) self = wSelf;
//        //        double kCompressionQuality = 0.3;
//        if (images > 0) {
//            for (UIImage * image in images) {
//                HXPhotoModel * photoModel = [[HXPhotoModel alloc] init];
////                [self.photoArr addObject:photoModel];
//                [self.photoArr insertObject:photoModel atIndex:0];
//                photoModel.photoImage = image;
//                photoModel.photoUrl = @"";
//                photoModel.comPhotoUrl = @"";
//                photoModel.states = PhotoStatesSuccess;
//                //                [self submitPhoto:photoModel];
//            }
//            [self changeModelTag];
//            [_collectionView reloadData];
//            [self changeButtonStates];
//        }
//        [self dismissViewControllerAnimated:YES completion:nil];
//        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
//    }];
//    //5.设置用户取消选择的回调 可选
//    [photoPickerC setDidCancelPickingBlock:^{
//        NSLog(@"photoPickerC did Cancel");
//        //此处不需要自己dismiss
//    }];
//    
//    //6. 显示photoPickerC
//    [self presentViewController:photoPickerC animated:YES completion:nil];
//    
//}
//-(void)changeModelTag {
//    
//    for (int i = 0; i<self.photoArr.count; i++) {
//        HXPhotoModel * photoModel = [self.photoArr objectAtIndex:i];
//        photoModel.photoTag = i+deletePhotoTag+1;
//    }
//}
//// 选中照片
//- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    
//    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    if (image) {
//        HXPhotoModel * photoModel = [[HXPhotoModel alloc] init];
////        [self.photoArr addObject:photoModel];
//        [self.photoArr insertObject:photoModel atIndex:0];
//        photoModel.photoImage = image;
//        photoModel.photoUrl = @"";
//        photoModel.comPhotoUrl = @"";
//        photoModel.states = PhotoStatesSuccess;
//        //        [self submitPhoto:photoModel];
//        [self changeModelTag];
//        [_collectionView reloadData];
//        [self changeButtonStates];
//    }
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}
//#pragma mark --提交图片
//-(void)submitPhoto:(HXPhotoModel *)model {
//    
//    [self.savePhoto savePhotoWithOrderNumber:model photoProgressBlock:^(HXPhotoModel * photoModel){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            HXJobPhotoCollectionViewCell * cell = (HXJobPhotoCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:photoModel.photoTag-deletePhotoTag inSection:0]];
//            cell.model = photoModel;
//            if (self.savePhoto.count==0) {
//                if (self.savePhoto.successNumber!=0) {
//                    
//                    [self submitPhoto];
//                }else {
//                    
//                    [self submitSuccess:NO];
//                    
//                }
//            }else {
//                [self.progress.uploadInformationLabel setText:[NSString stringWithFormat:@"正在上传第%ld张",(self.savePhoto.photoQuneNumber - self.savePhoto.count+1)]];
//                [self.progress.progressInView mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.width.mas_equalTo((SCREEN_WIDTH-120)/self.savePhoto.photoQuneNumber*(self.savePhoto.photoQuneNumber-self.savePhoto.count));
//                }];
//                
//            }
//            
//        });
//    }];
//}
//
//// 取消相册
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    
//}
//
//#pragma mark -- 获取图片
//-(void)archivePhoto {
//    [self.viewModel archivePhotoType:self.viewModel.type ordrNumber:self.viewModel.orderNumber returnBlock:^(NSMutableArray * selectPhoto,NSMutableArray * photoArr){
//        self.notUploadedNumber = selectPhoto.count;
//        [self.photoArr addObjectsFromArray:selectPhoto];
//        [self.havePhotoArr addObjectsFromArray:photoArr];
//        if (self.photoArr.count!=0) {
//            self.savePhoto.submitComplete = YES;
//        }
//        if (self.havePhotoArr.count>10) {
//            _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//        }
//        
//        [_collectionView reloadData];
//        [self changeButtonStates];
//    }];
//    
//    
//}
//
//#pragma mark -- 删除图片
//-(void)delegateAction:(id)sender {
//    UIButton * button = (UIButton *)sender;
//    if (self.photoArr.count>button.tag-deletePhotoTag) {
//        
//        [self.photoArr removeObjectAtIndex:(button.tag-deletePhotoTag)];
//        [self.savePhoto deletePhoto:self.photoArr];
//        [_collectionView reloadData];
//        [self changeButtonStates];
//    }
//    
//}
//#pragma mark -- 重新上传
//-(void)uploadAction:(id)sender {
//    
//    UIButton * button = (UIButton *)sender;
//    HXPhotoModel * model = [self.photoArr objectAtIndex:button.tag-200];
//    HXJobPhotoCollectionViewCell * cell = (HXJobPhotoCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:model.photoTag-500 inSection:1]];
//    model.states = PhotoStatesWait;
//    if (!self.savePhoto.submitComplete) {
//        
//        cell.model = model;
//    }
//    [self submitPhoto:model];
//}
//
//#pragma mark --  提交
//-(void)registerAction {
//    if (![AFNetManager isHaveNet]) {
//        [KeyWindow displayMessage:@"当前网络不可用 请检查网络!"];
//        return;
//    }
//    if (self.photoArr.count==0) {
//        [KeyWindow displayMessage:@"请选择图片"];
//        return;
//    }
//    if (self.viewModel.catory == CertificateIdentify) {
//        if ((self.photoArr.count +self.havePhotoArr.count)<3) {
//            [KeyWindow displayMessage:@"身份证明至少3张图片"];
//            return;
//        }
//    }
//    BOOL haveUploadPhoto = YES;
//    for (HXPhotoModel *model in self.photoArr) {
//        if (model.haveUpload) {
//            
//            continue;
//        }
//        haveUploadPhoto = NO;
//        self.progress.hidden = NO;
//        [self submitPhoto:model];
//    }
//    //如果没有需要上传的图片
//    if (haveUploadPhoto) {
//        if (self.photoArr.count == self.notUploadedNumber) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }else {
//            self.progress.hidden = NO;
//            self.savePhoto.successNumber = 0;
//            [self.progress.uploadInformationLabel setText:[NSString stringWithFormat:@"正在上传未删除图片"]];
//            self.savePhoto.successNumber = self.photoArr.count;
//            [self submitPhoto];
//            
//        }
//    }
//}
//#pragma mark -- 提交图片
//-(void)submitPhoto {
//    
//    [self.viewModel submitOtherPhotoWithPhotoArr:self.photoArr returnBlock:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PhotoInformation object:nil userInfo:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Authentication object:nil userInfo:nil];
//        });
//        [self submitSuccess:YES];
//    } failBlock:^{
//        [self submitSuccess:NO];
//    }];
//    
//}
//-(void)submitSuccess:(BOOL)successBool {
//    [self.progress.inforLabel setText:@"影像上传完成"];
//    [self.progress.cancelBtn setTitle:@"知道了" forState:UIControlStateNormal];
//    self.progress.uploadInformationLabel.hidden = NO;
//    if (successBool) {
//        [self.progress.uploadInformationLabel setText:[NSString stringWithFormat:@"成功上传%ld张",(long)self.savePhoto.successNumber]];
//    }else {
//        [self.progress.uploadInformationLabel setText:@"成功上传0张"];
//    }
//    
//    [self.progress.progressInView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.progress.progressView.width);
//    }];
//    
//}
//#pragma mark -- 判断按钮状态
//-(void)changeButtonStates {
//    if (self.photoArr.count!=0) {
//        _referButton.enabled = YES;
//        [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:_referButton style:UIControlStateNormal];
//    }else {
//        
//        _referButton.enabled = NO;
//        [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:_referButton style:UIControlStateNormal];
//    }
//    
//    
//}
//-(void)onBack {
//    BOOL haveUploadPhoto = YES;
//    for (HXPhotoModel *model in self.photoArr) {
//        if (model.haveUpload) {
//            continue;
//        }
//        haveUploadPhoto = NO;
//    }
//    if (self.photoArr.count==0|| haveUploadPhoto) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else {
//        
//        [[UIAlertTool alloc] showAlertView:self :@"" :@"是否保存影像?" :@"否" :@"是" :^{
//            [self registerAction];
//            
//        } :^{
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        }];
//    }
//}
//#pragma mark -- progressDelegate
//-(void)cancelAction {
//    
//    if ([self.progress.cancelBtn.titleLabel.text isEqualToString:@"知道了"]) {
//        [self.progress removeFromSuperview];
//        self.progress = nil;
//        [self.navigationController popViewControllerAnimated:YES];
//    }else {
//        self.progress.hidden = YES;
//        dispatch_suspend(self.savePhoto.quene);
//        [[UIAlertTool alloc] showAlertView:self :@"" :@"放弃上传?" :@"否" :@"是" :^{
//            dispatch_resume(self.savePhoto.quene);
//            if (!self.savePhoto.submitComplete&& self.photoArr.count !=0) {
//                
//                [[AFNetManager manager] cancelAllRequests];
//                dispatch_semaphore_signal(self.savePhoto.semaphore);
//                _savePhoto.stop = YES;
//            }
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        } :^{
//            dispatch_resume(self.savePhoto.quene);
//            self.progress.hidden = NO;
//        }];
//    }
//}
//#pragma mark -- setter and getter
//-(HXPhotoSave *)savePhoto {
//    if (_savePhoto==nil) {
//        _savePhoto = [[HXPhotoSave alloc] init];
//        _savePhoto.inforPhotoBool = YES;
//    }
//    return _savePhoto;
//}
//-(NSMutableArray *)photoArr {
//    if (_photoArr == nil) {
//        _photoArr = [[NSMutableArray alloc] init];
//    }
//    return _photoArr;
//}
//-(NSMutableArray *)havePhotoArr {
//    if (_havePhotoArr == nil) {
//        _havePhotoArr = [[NSMutableArray alloc] init];
//        
//    }
//    return _havePhotoArr;
//    
//}
//-(HXPhotoProgress *)progress {
//    if (_progress == nil) {
//        _progress  = [[HXPhotoProgress alloc] init];
//        _progress.delegate =self;
//        [self.progress creatUI];
//        self.progress.hidden =YES;
//    }
//    
//    return _progress;
//}
//-(void)loadMoreData {
//    self.havePhotoIndex++;
//    [_collectionView reloadData];
//    [_collectionView.mj_footer endRefreshing];
//    
//}
//-(void)dealloc {
//    [[AFNetManager manager] cancelAllRequests];
//    
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
//    [mgr cancelAll];
//    [mgr.imageCache clearMemory];
//    // Dispose of any resources that can be recreated.
//}
//
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//@end
