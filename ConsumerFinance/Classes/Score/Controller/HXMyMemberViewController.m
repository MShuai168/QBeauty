//
//  HXMyMemberViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyMemberViewController.h"
#import "HXMyMemberCollectionViewCell.h"
#import "HXProductLayout.h"
#import "HXProductCollectionViewCell.h"
#import "ComButton.h"
#import "HXInterestsAlert.h"
#import "HXWKWebViewViewController.h"
#import "HXShopCarModel.h"
@interface HXMyMemberViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,productDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionView * productCollectionView;
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIView * secBackView;
@property (nonatomic,strong)NSArray * photoNameArr;//图片数组
@property (nonatomic,strong)NSArray * selectPhotoArr;//图片数组
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray * contentArr;
@property (nonatomic,strong)HXInterestsAlert * alert;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UIView * scheduleView;
@property (nonatomic,strong)UILabel * czScore;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,strong)UIImageView * backImageView;
@end

@implementation HXMyMemberViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXMyMemberViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    [self hiddeKeyBoard];
    self.view.backgroundColor = kUIColorFromRGB(0xffffff);
    [self request];
    [self archiveRecommend];
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"我的会员";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
/**
 *  隐藏键盘
 */
-(void) hiddeKeyBoard{
    
    [self.view endEditing:YES];
    
}
-(void)createUI {
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    self.scrollView  = scrollView;
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = COLOR_BACKGROUND;
    _scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIView * firBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225)];
    firBackView.backgroundColor = kUIColorFromRGB(0xffffff);
    [self.scrollView addSubview:firBackView];
    
    
    UIImageView * backImageView = [[UIImageView alloc] init];
    self.backImageView = backImageView;
    [backImageView setImage:[UIImage imageNamed:@"vip1card"]];
    [firBackView addSubview:backImageView];
    

    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(firBackView);
        make.top.equalTo(firBackView).offset(25);
    }];
    
    UILabel * nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.textColor = kUIColorFromRGB(0xffffff);
    [nameLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:19]];
    [backImageView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImageView.mas_left).offset(80);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(19);
        make.top.equalTo(backImageView).offset(30);
    }];
    
    UIView * progressView = [[UIView alloc] init];
    progressView.backgroundColor = [kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.3];
    progressView.layer.cornerRadius = 2;
//    progressView.layer.masksToBounds = YES;
    [backImageView addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImageView).offset(80);
        make.width.mas_equalTo(190);
        make.top.equalTo(nameLabel.mas_bottom).offset(37);
        make.height.mas_equalTo(4);
    }];

    UIView * scheduleView = [[UIView alloc] init];
    self.scheduleView = scheduleView;
    scheduleView.backgroundColor = kUIColorFromRGB(0xffffff);
    scheduleView.layer.cornerRadius = 2;
    [progressView addSubview:scheduleView];
    [scheduleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressView);
        make.width.mas_equalTo(0);
        make.top.equalTo(progressView);
        make.height.mas_equalTo(4);
    }];
    
//    UIView * proScoreView = [[UIView alloc] init];
//    proScoreView.backgroundColor = [kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.1];
//    proScoreView.layer.borderColor = [kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.3].CGColor;
//    proScoreView.layer.borderWidth = 0.5;
//    proScoreView.layer.cornerRadius = 2;
//    [backImageView addSubview:proScoreView];
//    [proScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(scheduleView.mas_right).offset(0);
//        make.width.mas_equalTo(35);
//        make.bottom.equalTo(progressView.mas_top).offset(-8);
//        make.height.mas_equalTo(17);
//    }];
    
    UIImageView * jtImage = [[UIImageView alloc] init];
    jtImage.image = [UIImage imageNamed:@"scjiantou1"];
    [backImageView addSubview:jtImage];
    [jtImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scheduleView.mas_right).offset(0);
        make.bottom.equalTo(progressView.mas_top).offset(-4);
        make.height.mas_equalTo(18);
    }];
    
    UILabel * czScore = [[UILabel alloc] init];
    self.czScore  = czScore;
    czScore.text = @"0";
    [jtImage addSubview:czScore];
    czScore.textColor = kUIColorFromRGB(0xffffff);
    czScore.font = [UIFont systemFontOfSize:11];
    [jtImage addSubview:czScore];
    [czScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(jtImage).offset(-1.5);
        make.centerX.equalTo(jtImage);
    }];
    
    UILabel * contentLabel = [[UILabel alloc] init];
    self.contentLabel = contentLabel;
    contentLabel.textColor = kUIColorFromRGB(0xffffff);
    contentLabel.font = [UIFont systemFontOfSize:12];
    [backImageView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progressView.mas_bottom).offset(25);
        make.left.equalTo(backImageView).offset(80);
    }];
    
    
    [self creatCollectionview];
    [self creatProductCollection];
    
}
-(void)creatCollectionview {
    UIView * secBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 225, SCREEN_WIDTH, 331)];
    secBackView.backgroundColor = kUIColorFromRGB(0xffffff);
    [self.scrollView addSubview:secBackView];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-48-30)/2, 70);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 20;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(24,0, SCREEN_WIDTH-48,331) collectionViewLayout:layout];
    if (SCREEN_WIDTH<=320) {
        collectionView.frame = CGRectMake(12, 0, SCREEN_WIDTH-24, 331);
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-24-30)/2, 70);
    }
  
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HXMyMemberCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    [secBackView addSubview:collectionView];
    [_collectionView registerClass:[UICollectionViewCell class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader"];
    [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collettionSectionFoot"];
}

-(void)creatProductCollection {
    HXProductLayout *layout = [HXProductLayout new];
//    layout.itemSize = CGSizeMake((SCREEN_WIDTH-34)/2, 245);
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.minimumInteritemSpacing = 10; //设置标题框空间大小
//    layout.minimumLineSpacing = 20;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(12,225+341, SCREEN_WIDTH-24,0) collectionViewLayout:layout];
    
    _productCollectionView = collectionView;
    layout.delegate = self;
    collectionView.backgroundColor = kUIColorFromRGB(0xffffff);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HXProductCollectionViewCell class] forCellWithReuseIdentifier:@"identifier1"];
    [self.scrollView addSubview:collectionView];
    [_productCollectionView registerClass:[UICollectionViewCell class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader"];
    [_productCollectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collettionSectionFoot"];
}


-(void)request {
    
    [self.viewModel archiveMemberWithReturnBlock:^{
        self.viewModel.model.growthValue = self.viewModel.model.growthValue.length!=0?self.viewModel.model.growthValue:@"0";
        self.viewModel.model.endValue = self.viewModel.model.endValue.length!=0?self.viewModel.model.endValue:@"0";
        self.nameLabel.text = self.viewModel.model.gradeName;
        self.czScore.text = self.viewModel.model.growthValue.length!=0?[NSString stringWithFormat:@"%d",[self.viewModel.model.growthValue intValue]]:@"";
        [self.scheduleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([self.viewModel.model.growthValue doubleValue]/[self.viewModel.model.endValue doubleValue]*190);
        }];
        if ([self.viewModel.model.gradeId isEqualToString:@"1"]) {
            [self.backImageView setImage:[UIImage imageNamed:@"vip1card"]];
        }else if ([self.viewModel.model.gradeId isEqualToString:@"2"]) {
            [self.backImageView setImage:[UIImage imageNamed:@"vip2card"]];
        }else if ([self.viewModel.model.gradeId isEqualToString:@"3"]) {
            [self.backImageView setImage:[UIImage imageNamed:@"vip3card"]];
        }else if ([self.viewModel.model.gradeId isEqualToString:@"4"]) {
            [self.backImageView setImage:[UIImage imageNamed:@"vip4card"]];
        }else if ([self.viewModel.model.gradeId isEqualToString:@"5"]) {
            [self.backImageView setImage:[UIImage imageNamed:@"vip5card"]];
        }else {
            
            [self.backImageView setImage:[UIImage imageNamed:@"vip1card"]];
        }
        if ([self.viewModel.model.gradeId isEqualToString:@"5"]) {
            self.contentLabel.text = @"恭喜,能尊享全部特权";
            self.contentLabel.textColor = kUIColorFromRGB(0xEBBC7B);
            self.nameLabel.textColor = kUIColorFromRGB(0xEBBC7B);
            self.scheduleView.backgroundColor = kUIColorFromRGB(0xEBBC7B);
            self.czScore.textColor = kUIColorFromRGB(0xEBBC7B);
        }else {
        if (self.viewModel.model.nextGradeName.length!=0) {
            self.contentLabel.text = [NSString stringWithFormat:@"还差%d成长值晋升为%@",[self.viewModel.model.difference intValue],self.viewModel.model.nextGradeName];
        }
        }
        [_collectionView reloadData];
    } fail:^{
        
    }];
}

-(void)archiveRecommend {
    
    [self.viewModel archivewRecommendProduceWithSuccessBlock:^{
        [self updateHeight:_productCollectionView.frame.size.height];
        if (self.viewModel.recomendArr.count %10!=0) {
            [self.scrollView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.scrollView.mj_footer resetNoMoreData];
        }
        [_productCollectionView reloadData];
        [self.scrollView.mj_footer endRefreshing];
    } failBlock:^{
        
        [self.scrollView.mj_footer endRefreshing];
        
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:_productCollectionView]) {
        return self.viewModel.recomendArr.count;
    }
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:_productCollectionView]) {
        HXProductCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier1" forIndexPath:indexPath];
        cell.contentView.layer.borderWidth = 0.5;
        cell.contentView.layer.borderColor = kUIColorFromRGB(0xE6E6E6).CGColor;
        cell.shoopBool = NO;
        cell.model = [self.viewModel.recomendArr objectAtIndex:indexPath.row];
        return cell;
    }
    HXMyMemberCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.photoImage.image =[UIImage imageNamed:[self.photoNameArr objectAtIndex:indexPath.row]];
    cell.titleLbel.text = [self.titleArr objectAtIndex:indexPath.row];
    cell.contentLbel.text = [self.contentArr objectAtIndex:indexPath.row];
    
    cell.titleLbel.textColor = ComonCharColor;
    cell.contentLbel.textColor = ComonCharColor;
    if ([self.viewModel.model.gradeId isEqualToString:@"1"]) {
        cell.titleLbel.textColor = ComonCharColor;
        cell.contentLbel.textColor = ComonCharColor;
        cell.photoImage.image = [UIImage imageNamed:[self.photoNameArr objectAtIndex:indexPath.row]];
    }else if ([self.viewModel.model.gradeId isEqualToString:@"2"]){
        if (indexPath.row<3) {
            cell.titleLbel.textColor = kUIColorFromRGB(0xEDC690);
            cell.contentLbel.textColor = kUIColorFromRGB(0xEDC690);
            cell.photoImage.image = [UIImage imageNamed:[self.selectPhotoArr objectAtIndex:indexPath.row]];
        }else {
            cell.titleLbel.textColor = ComonCharColor;
            cell.contentLbel.textColor = ComonCharColor;
            cell.photoImage.image = [UIImage imageNamed:[self.photoNameArr objectAtIndex:indexPath.row]];
        }
    }else if ([self.viewModel.model.gradeId isEqualToString:@"3"]){
        if (indexPath.row<4) {
            cell.titleLbel.textColor = kUIColorFromRGB(0xEDC690);
            cell.contentLbel.textColor = kUIColorFromRGB(0xEDC690);
            cell.photoImage.image = [UIImage imageNamed:[self.selectPhotoArr objectAtIndex:indexPath.row]];
        }else {
            cell.photoImage.image = [UIImage imageNamed:[self.photoNameArr objectAtIndex:indexPath.row]];
            cell.titleLbel.textColor = ComonCharColor;
            cell.contentLbel.textColor = ComonCharColor;
        }
    }else if ([self.viewModel.model.gradeId isEqualToString:@"4"]){
        if (indexPath.row<5) {
            cell.titleLbel.textColor = kUIColorFromRGB(0xEDC690);
            cell.contentLbel.textColor = kUIColorFromRGB(0xEDC690);
            cell.photoImage.image = [UIImage imageNamed:[self.selectPhotoArr objectAtIndex:indexPath.row]];
        }else {
            
            cell.titleLbel.textColor = ComonCharColor;
            cell.contentLbel.textColor = ComonCharColor;
            cell.photoImage.image = [UIImage imageNamed:[self.photoNameArr objectAtIndex:indexPath.row]];
        }
    }else if ([self.viewModel.model.gradeId isEqualToString:@"5"]){
        
        cell.titleLbel.textColor = kUIColorFromRGB(0xEDC690);
        cell.contentLbel.textColor = kUIColorFromRGB(0xEDC690);
        cell.photoImage.image = [UIImage imageNamed:[self.selectPhotoArr objectAtIndex:indexPath.row]];
    }else {
        cell.titleLbel.textColor = ComonCharColor;
        cell.contentLbel.textColor = ComonCharColor;
        cell.photoImage.image = [UIImage imageNamed:[self.photoNameArr objectAtIndex:indexPath.row]];
    }
    return cell;
}

//设置sectionHeader | sectionFoot
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:_productCollectionView]) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView* view = [_productCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader" forIndexPath:indexPath];
            UILabel * nameLabel = [[UILabel alloc] init];
            nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            nameLabel.textColor = kUIColorFromRGB(0x555555);
            [view addSubview:nameLabel];
            nameLabel.text = @"推荐产品";
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(view);
                make.left.equalTo(view).offset(12);
                make.height.mas_equalTo(48);
            }];
            
            
            return view;
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            UICollectionReusableView* view = [_productCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collettionSectionFoot" forIndexPath:indexPath];
            
            return view;
        }else{
            return nil;
        }
        
        
    }
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView* view = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader" forIndexPath:indexPath];
        UILabel * nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        nameLabel.textColor = kUIColorFromRGB(0xEFC995);
        [view addSubview:nameLabel];
        nameLabel.text = @"会员权益";
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view);
            make.centerX.equalTo(view);
        }];
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = kUIColorFromRGB(0xEFC995);
        [view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(nameLabel);
            make.top.equalTo(nameLabel.mas_bottom).offset(8);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(2);
        }];
        
        ComButton * btn = [[ComButton alloc] init];
        [btn addTarget:self action:@selector(qyAction) forControlEvents:UIControlEventTouchUpInside];
        [btn.photoImage setImage:[UIImage imageNamed:@"scinfo"]];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view);
            make.left.equalTo(nameLabel.mas_right).offset(0);
            make.width.and.height.mas_equalTo(30);
        }];
        [btn.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn).offset(5);
        }];
        
        
        return view;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView* view = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collettionSectionFoot" forIndexPath:indexPath];

        return view;
    }else{
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([collectionView isEqual:_productCollectionView]) {
        CGFloat height = 48;
        return CGSizeMake(SCREEN_WIDTH, height);
    }
    CGFloat height = 46;
    return CGSizeMake(SCREEN_WIDTH, height);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:_productCollectionView]) {
        
        HXShopCarModel * model = [self.viewModel.recomendArr objectAtIndex:indexPath.row];
        HXWKWebViewViewController *controller = [[HXWKWebViewViewController alloc] init];
        controller.title = @"商品详情";
        NSString * url  = [NSString stringWithFormat:@"%@goods/%@/%@",kScoreUrl,model.id,K_CURRENT_TIMESTAMP];
        controller.url = url;
        controller.isTransparente = NO;
        [self.navigationController pushViewController:controller animated:YES];
    }

}
-(void)updateHeight:(NSInteger)height {
   [_productCollectionView setFrame:CGRectMake(0,225+341, SCREEN_WIDTH,height)];
    [self.scrollView setContentSize:CGSizeMake(0,225+341+ _productCollectionView.frame.size.height)];
    
}

-(void)qyAction {
    __block typeof(HXMyMemberViewController *) weakSelf = self;
  self.alert =   [[HXInterestsAlert alloc] initWithSureBlock:^{
      [weakSelf.alert removeFromSuperview];
      weakSelf.alert = nil;
   }];
    
    
}

#pragma mark -- setter and getter
-(NSArray *)photoNameArr {
    if (_photoNameArr==nil) {
        _photoNameArr = @[@"jifen1",@"zhuanjia1",@"weizheng1",@"sizhi1",@"quanshen1",@"mianbu1"];
    }
    
    return _photoNameArr;
}
-(NSArray *)selectPhotoArr {
    if (_selectPhotoArr == nil) {
        _selectPhotoArr =@[@"jifen2",@"zhuanjia2",@"weizheng2",@"sizhi2",@"quanshen2",@"mianbu2"];
    }
    return _selectPhotoArr;
    
}
-(NSArray *)titleArr {
    if (_titleArr == nil) {
        _titleArr = @[@"趣贝奖励",@"专家面诊",@"美颜微针",@"四肢护理",@"全身护理",@"变美券"];
    }
    
    return _titleArr;
}
-(NSArray *)contentArr {
    if (_contentArr == nil) {
        _contentArr = @[@"不同等级会员获得对应趣贝奖励",@"免费专家面诊每月1次",@"免费针剂整形每月1次",@"免费四肢养护每月1次",@"免费全身养护每月1次",@"免费变美券每月3张"];
    }
    return _contentArr;
    
}

#pragma mark -- loadMoreData
-(void)loadMoreData {
    self.viewModel.page++;
    [self archiveRecommend];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
