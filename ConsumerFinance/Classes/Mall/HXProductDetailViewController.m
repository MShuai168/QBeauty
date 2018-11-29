//
//  HXProductDetailViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/14.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXProductDetailViewController.h"
#import "DockBeautyCell.h"
#import "BeautyClinicModel.h"
#import "ComButton.h"
#import "AcdseeScro.h"
#import "HXCommentCell.h"
#import "AcdseeCollection.h"
#import "HXHoneyMoonViewController.h"
#import "DtoListModel.h"
#import "HXContentWebViewCell.h"
#import "HXConfirmReservationViewController.h"
#import "ZYBannerView.h"
#import "HXYmDetailsViewController.h"
#import "HXAllEvaluationViewController.h"
#import "HXMapViewController.h"
#define ButtonTag 500
@interface HXProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SourceCell,ZYBannerViewDataSource, ZYBannerViewDelegate,hxcommentDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UILabel * titleLable; //标题
@property (nonatomic,strong) UILabel * informationLabel; //预约期
@property (nonatomic,strong) NSString *htmlURlStr;
@property (nonatomic,assign) NSInteger cellRefreshCount; //产品详情防止一直刷新 记录标记
@property (nonatomic,assign) NSInteger cellHeight;//刷新后计算的高度
@property (nonatomic,strong) NSString *secondHtml;
@property (nonatomic,assign) NSInteger secondRefreshCount;//预约须知 记录标记
@property (nonatomic,assign) NSInteger secondCellHeight; //刷新后计算的高度
@property (nonatomic,strong) HXContentWebViewCell *cell;
@property (nonatomic,assign) NSInteger thirdCellHeight; //中间高度 便于保存 secondCellHeight cellHeight
@property (nonatomic,strong) UIView * headView;
@property (nonatomic, strong) ZYBannerView *bannerView;   // bannerView;
@property (nonatomic, strong) UILabel * numberLabel;//翻页
@property (nonatomic,strong)UIView * numberView;

@property (nonatomic,strong)UILabel * moneyLabel;
@property (nonatomic,strong)UILabel * dateLabel;

@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UILabel * locationLabel; //地址
@property (nonatomic,strong)UILabel * qualityLabel;
@end

@implementation HXProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self creatUI];
    [self.viewModel paddingData];
    [self request];
}
-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self hiddenNavgationBarLine:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}
-(void)request{
    
    [self.viewModel archiveDeatilWithReturnBlock:^{
        self.htmlURlStr=self.viewModel.preDtoModel.detail;
        //        if (self.viewModel.bannarArr.count !=0) {
        //            self.numberView.hidden = NO;
        //            self.numberLabel.text = [NSString stringWithFormat:@"1/%ld",self.viewModel.bannarArr.count];
        //        }
        [self.tableView reloadData];
        [self.bannerView reloadData];
    } fail:^{
    }];
    
    
}
/**
 *  隐藏导航栏
 */
-(void)editNavi {
    [self setNavigationBarBackgroundImage];
     self.title = @"产品详情";
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = COLOR_BACKGROUND;
}
-(void)creatUI {
    /**
     *  项目tableview
     */
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView = tableView;
    if (iphone_X) {
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.delegate = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = kUIColorFromRGB(0xf5f7f8);
    [self.view addSubview:tableView];
    [tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    /**
     *  tableHeaderView
     */
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    headView.backgroundColor = COLOR_BACKGROUND;
    tableView.tableHeaderView = headView;
    /**
     *  LOGO
     */
    _bannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    _bannerView.dataSource = self;
    _bannerView.delegate = self;
    _bannerView.shouldLoop = YES;
    _bannerView.autoScroll = YES;
    _bannerView.scrollInterval = 5.0;
    _bannerView.backgroundColor = ColorWithHex(0xFFFFFF);
    [headView addSubview:_bannerView];
    
    UIView * numberView = [[UIView alloc] init];
    numberView.hidden = YES;
    self.numberView = numberView;
    numberView.backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.5];
    [headView addSubview:numberView];
    [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headView.mas_right).offset(-15);
        make.bottom.equalTo(headView.mas_bottom).offset(-10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(30);
    }];
    numberView.layer.masksToBounds = YES;
    numberView.layer.cornerRadius = 7;
    UILabel * numberLabel = [[UILabel alloc] init];
    self.numberLabel = numberLabel;
    numberLabel.font = [UIFont systemFontOfSize:11];
    [numberLabel setTextColor:kUIColorFromRGB(0xffffff)];
    [numberView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(numberView);
        make.centerY.equalTo(numberView);
    }];
    
    /**
     *  底部按钮
     */
    UIView * footView = [[UIView alloc] init];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    for (int i = 0; i<2; i++) {
        ComButton * button = [[ComButton alloc] init];
        button.tag = i+200;
        [button addTarget:self action:@selector(comButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footView);
            make.bottom.equalTo(footView);
            make.left.equalTo(footView.mas_left).offset(SCREEN_WIDTH/4*i);
            make.width.mas_equalTo(i==0?SCREEN_WIDTH/4:SCREEN_WIDTH/4*3);
        }];
        if (i==0) {
            button.photoImage.image = [UIImage imageNamed:@"phone"];
            [button.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.mas_top).offset(9);
            }];
            [button.nameLabel setText:@"电话咨询"];
            [button.nameLabel setTextColor:ComonCharColor];
            [button.nameLabel setFont:[UIFont systemFontOfSize:10]];
            [button.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.photoImage.mas_bottom).offset(5);
            }];
            button.backgroundColor = kUIColorFromRGB(0xffffff) ;
        }else {
            button.backgroundColor = ComonBackColor;
            [button setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [button setTitle:@"免费预约" forState:UIControlStateNormal];
        }
    }
    
    //    /**
    //     *  分享
    //     */
    //    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [shareButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    //    [self.view addSubview:shareButton];
    //    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(self.view).offset(-20);
    //        make.top.equalTo(self.view).offset(30);
    //    }];
    
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdentity = @"IdentityInfoCell";
        BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            [self creatCellContent:cell];
        }
        self.titleLable.text = self.viewModel.preDtoModel.name ? self.viewModel.preDtoModel.name :@"";
        NSString * money = self.viewModel.preDtoModel.stagePrice?[NumAgent roundDown:self.viewModel.preDtoModel.stagePrice ifKeep:NO] : @"0";
        NSString * date = self.viewModel.preDtoModel.stagePeriod ? self.viewModel.preDtoModel.stagePeriod :@"0";
        self.moneyLabel.text = [NSString stringWithFormat:@"%d",[money intValue]];
        self.dateLabel.text = [NSString stringWithFormat:@" x%@期起",date];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==1){
        static NSString *cellIdentity = @"IdentityInfoCellX";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            UIImageView * addressImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
            cell.backgroundColor = CommonBackViewColor;
            [cell.contentView addSubview:addressImage];
            [addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView.mas_left).offset(15);
            }];
            
            UIImageView * arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NextButton"]];
            [cell.contentView addSubview:arrowImage];
            [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-15);
            }];
            
            UILabel * locationLabel = [[UILabel alloc] init];
            self.locationLabel = locationLabel;
            locationLabel.font = [UIFont systemFontOfSize:14];
            locationLabel.numberOfLines = 0;
            locationLabel.textColor = ComonTextColor;
            [cell.contentView addSubview:locationLabel];
            [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView).offset(36);
                make.right.equalTo(cell.contentView).offset(-40);
                make.height.mas_lessThanOrEqualTo(36);
            }];
            
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        cell.selectedBackgroundView.backgroundColor = kUIColorFromRGB(0xf9f9f9);
//        self.locationLabel.text = self.viewModel.tenantModel.companyAddress?self.viewModel.tenantModel.companyAddress:@"";
        self.locationLabel.text = self.viewModel.merDtoModel.detail.length!=0?self.viewModel.merDtoModel.detail:@"";
        return cell;
        
        
    }else if (indexPath.section == 2){
        static NSString *cellIdentity = @"IdentityInfoCell1";
        DockBeautyCell *cell = (DockBeautyCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[DockBeautyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView).offset(24);
                make.height.mas_equalTo(17);
                make.left.equalTo(cell.contentView).offset(90);
                make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-100);
            }];
            [cell.star mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView).offset(50);
                make.left.equalTo(cell.contentView).offset(90);
                make.height.mas_equalTo(13);
                make.width.mas_equalTo(100);
            }];
            cell.orderLabel.hidden = YES;
            
            UILabel * qualityLabel = [[UILabel alloc] init];
            self.qualityLabel = qualityLabel;
            qualityLabel.text = @"总体：0";
            qualityLabel.textColor = ComonCharColor;
            qualityLabel.font = [UIFont systemFontOfSize:13];
            [cell.contentView addSubview:qualityLabel];
            [qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.star.mas_right).offset(40);
                make.top.equalTo(cell.contentView).offset(52);
            }];
            
        }
        DtoListModel * model = [[DtoListModel alloc] init];
        model.title  = self.viewModel.merDtoModel.title;
//        model.address = self.viewModel.merDtoModel.detail;
        
        model.star = self.viewModel.merDtoModel.star;
        self.qualityLabel.text = [NSString stringWithFormat:@"总体：%@",self.viewModel.merDtoModel.star.length!=0?self.viewModel.merDtoModel.star:@"0"];
        [cell.star layoutSubviews];
        model.imgUrl = [Helper photoUrl:self.viewModel.merDtoModel.imgUrl width:120 height:120];
        cell.model = model;
        return cell;
        
    }else if (indexPath.section == 3) {
        static NSString *cellIdentity = @"IdentityInfoCell2";
        HXContentWebViewCell *cell = (HXContentWebViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXContentWebViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.delegate = self;
        }
        self.cell = cell;
        cell.cellRefreshCount = self.cellRefreshCount;
        cell.secondRefreshCount = self.secondRefreshCount;
        cell.tableView = tableView;
        cell.htmlStr = self.htmlURlStr;
        return cell;
    }else {
       
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.viewModel.preDtoModel.titleHeight ;
    }else if(indexPath.section==1) {
        return 50;
    }else if(indexPath.section == 2) {
        return 90;
    }else if(indexPath.section == 3){
        return self.thirdCellHeight?self.thirdCellHeight:0;
    }else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }else if(section==3){
        return 54;
    }else {
        return 10;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }else if(section==2){
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        headView.backgroundColor = COLOR_BACKGROUND;
        return headView;
    }else if(section==3){
        if (self.headView == nil) {
            
            UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
            self.headView = headView;
            headView.backgroundColor = COLOR_BACKGROUND;
            UIButton * deaulBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
            deaulBtn.backgroundColor = kUIColorFromRGB(0xffffff);
            [deaulBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [deaulBtn setTitle:@"产品详情" forState:UIControlStateNormal];
            [deaulBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
            [headView addSubview:deaulBtn];
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 53.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = CellLineColor;
            [headView addSubview:line];
        }
        return self.headView;
    }else {
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==1) {
        HXMapViewController * mapView = [[HXMapViewController alloc] init];
        CLLocationCoordinate2D coordinate =[self GCJ02FromBD09:CLLocationCoordinate2DMake([self.viewModel.merDtoModel.latitude doubleValue],[self.viewModel.merDtoModel.longitude doubleValue])];
        mapView.companyAddress = self.viewModel.merDtoModel.detail;
        mapView.coordinate = coordinate;
        mapView.titleName = self.viewModel.merDtoModel.title;
        [self.navigationController pushViewController:mapView animated:YES];
    }
    if (indexPath.section==2) {
        HXYmDetailsViewController * details = [[HXYmDetailsViewController alloc] init];
        details.viewModel.merId =self.viewModel.merDtoModel.id;
        [self.navigationController pushViewController:details animated:YES];
        
    }
}
#pragma mark -- cell内容布局
-(void)creatCellContent:(UITableViewCell *)cell {
    /**
     *  标题
     */
    UILabel * titleLable = [[UILabel alloc] init];
    self.titleLable = titleLable;
    titleLable.numberOfLines = 0;
    titleLable.font = [UIFont systemFontOfSize:16];
    titleLable.textColor = kUIColorFromRGB(0x333333);
    [cell.contentView addSubview:titleLable];
    [titleLable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView.mas_top).offset(10);
        make.left.equalTo(cell.contentView).offset(15);
        make.right.equalTo(cell.contentView).offset(-30);
        make.height.mas_lessThanOrEqualTo(48);
    }];
    
    UILabel * informationLabel = [[UILabel alloc] init];
    self.informationLabel = informationLabel;
    informationLabel.font = [UIFont systemFontOfSize:17];
    informationLabel.textColor = kUIColorFromRGB(0xFF6098);
    informationLabel.text = @"¥ ";
    [cell.contentView addSubview:informationLabel];
    [informationLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView.mas_bottom).offset(-10);
        make.left.equalTo(cell.contentView).offset(15);
        make.height.mas_lessThanOrEqualTo(24);
    }];
    UILabel * moneyLabel = [[UILabel alloc] init];
    self.moneyLabel = moneyLabel;
    moneyLabel.font = [UIFont systemFontOfSize:30];
    moneyLabel.textColor = kUIColorFromRGB(0xFF6098);
    moneyLabel.text = @"0";
    [cell.contentView addSubview:moneyLabel];
    [moneyLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView.mas_bottom).offset(-10);
        make.left.equalTo(informationLabel.mas_right).offset(0);
        make.height.mas_lessThanOrEqualTo(24);
    }];
    UILabel * dateLabel = [[UILabel alloc] init];
    self.dateLabel = dateLabel;
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = kUIColorFromRGB(0xFF6098);
    dateLabel.text = @" x0期起";
    [cell.contentView addSubview:dateLabel];
    [dateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView.mas_bottom).offset(-10);
        make.left.equalTo(moneyLabel.mas_right).offset(0);
        make.height.mas_lessThanOrEqualTo(24);
    }];
    
    
}
/// 百度坐标转高德坐标
-(CLLocationCoordinate2D)GCJ02FromBD09:(CLLocationCoordinate2D)coor
{
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude - 0.0065, y = coor.latitude - 0.006;
    CLLocationDegrees z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    CLLocationDegrees gg_lon = z * cos(theta);
    CLLocationDegrees gg_lat = z * sin(theta);
    return CLLocationCoordinate2DMake(gg_lat, gg_lon);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([webView isEqual:self.cell.webView]) {
        _cellRefreshCount++;
        
        //防止一直刷新
        if (_cellRefreshCount == 1) {
            self.cellHeight = webView.frame.size.height;
            self.thirdCellHeight = self.cellHeight;
            //刷新第5个section，第1行
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:2];
            NSArray *paths = [NSArray arrayWithObjects:path,nil];
            [self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
        }
        else
        {
            
            return;
        }
        
    }else {
        _secondRefreshCount++;
        
        //防止一直刷新
        if (_secondRefreshCount == 1) {
            self.secondCellHeight = webView.frame.size.height;
            //        //刷新第5个section，第1行
            //        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:2];
            //        NSArray *paths = [NSArray arrayWithObjects:path,nil];
            //        [self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
        }
        else
        {
            return;
        }
    }
    
}
#pragma  mark -- 预约 电话
-(void)comButtonAction:(id)sender {
    ComButton * button = (ComButton *)sender;
    if (button.tag == 200) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",DefineText_Hotline];
        //            NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        return;
    }
    if ([[AppManager manager] isOnline]) {
        HXConfirmReservationViewController * confirm = [[HXConfirmReservationViewController alloc] init];
        confirm.viewModel.preModel = self.viewModel.preDtoModel;
        confirm.viewModel.name = self.viewModel.merDtoModel.title;
        confirm.viewModel.address = self.viewModel.merDtoModel.detail;
        confirm.viewModel.imageUrl = self.viewModel.merDtoModel.imgUrl;
        [self.navigationController pushViewController:confirm animated:YES];
        
    }else {
        [Helper pushLogin:self];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    if (scrollView.contentOffset.y<=0) {
    //        scrollView.contentOffset = CGPointMake(0, -20) ;
    //    }
}
#pragma mark ZYBannerViewDataSource

// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {
    return self.viewModel.bannarArr.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的v iew, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.viewModel.bannarArr.count];
    // 取出数据
    NSString *imageName = [Helper photoUrl:self.viewModel.bannarArr[index] width:SCREEN_WIDTH*2 height:460];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"banner3"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

#pragma mark ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld个项目", index);
}
-(void)bringtoFront {
    
    [self.view bringSubviewToFront:self.backButton];
    
}
#pragma mark -- 评论列表
-(void)commentBtnAction {
    
    HXAllEvaluationViewController * evaluation = [[HXAllEvaluationViewController alloc] init];
    evaluation.viewModel.commentArr = self.viewModel.commentArr;
    evaluation.viewModel.commentNumber = self.viewModel.commentNumber;
    evaluation.viewModel.merId = self.viewModel.preDtoModel.merId;
    [self.navigationController pushViewController:evaluation animated:YES];
    
    
}
#pragma mark -- hxcomdelegate
-(void)updateTableViewHeight {
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [CATransaction commit];
    
}
#pragma mark -- 返回
-(void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- setter
-(HXProductDetailViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[HXProductDetailViewModel alloc] initWithController:self];
        [self.viewModel.bannarArr addObject:@""];
    }
    return _viewModel;
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
