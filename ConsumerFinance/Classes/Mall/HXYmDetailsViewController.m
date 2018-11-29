//
//  HXYmDetailsViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/13.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXYmDetailsViewController.h"
#import "StarView.h"
#import "AcdseeScro.h"
#import "BeautyClinicCell.h"
#import "HXProductDetailViewController.h"
#import "ComButton.h"
#import "AcdseeCollection.h"
#import "HXMapViewController.h"
#import "HXStarView.h"
#import "HXConfirmReservationViewController.h"
#import "ZYBannerView.h"
#import "HXCommentCell.h"
#import "HXAllEvaluationViewController.h"
#define FootBtnTag 500
@interface HXYmDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ZYBannerViewDataSource, ZYBannerViewDelegate,hxcommentDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UILabel * titleLable;//标题
@property (nonatomic,strong)UILabel * casesLabel;//案例数
@property (nonatomic,strong)UILabel * orderLabel;//订单数
@property (nonatomic,strong)HXStarView * star;//星星
@property (nonatomic,strong)UILabel * locationLabel; //地址
@property (nonatomic,strong)AcdseeCollection * acd; //图片浏览器
@property (nonatomic,strong)UILabel * titleLabel; //简介
@property (nonatomic,strong)UIView * headView;

@property (nonatomic,strong)UIButton * seeAllbutton;
@property (nonatomic, strong) ZYBannerView *bannerView;   // bannerView;
@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UIView * yuyueBackView;
@property (nonatomic,strong)UILabel * commentLabel;
@property (nonatomic,strong)UIImageView * headImage;
@end

@implementation HXYmDetailsViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXDetailsViewModel alloc] initWithController:self];
        [self.viewModel.imgListArr addObject:@""];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self creatUI];
    [self getDetaile];
}
-(void)viewWillAppear:(BOOL)animated {
   [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self hiddenNavgationBarLine:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}
/**
 *  隐藏导航栏
 */
-(void)editNavi {
    [self setNavigationBarBackgroundImage];
    self.title = @"商户详情";
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
    tableView.backgroundColor = COLOR_BACKGROUND;
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
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 195)];
    self.headView = headView;
    headView.backgroundColor = kUIColorFromRGB(0xffffff);
    tableView.tableHeaderView = headView;
    
    UIImageView * headImage = [[UIImageView alloc] init];
    self.headImage = headImage;
    headImage.layer.cornerRadius = 30;
    headImage.layer.masksToBounds = YES;
    headImage.layer.borderColor = kUIColorFromRGB(0xE7E7E7).CGColor;
    headImage.layer.borderWidth = 0.5;
//    photoImage.contentMode = UIViewContentModeScaleAspectFit;
    [headView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(20);
        make.centerX.equalTo(headView);
        make.height.and.width.mas_equalTo(60);
    }];
   

    /**
     *  标题
     */
    UILabel * titleLable = [[UILabel alloc] init];
    self.titleLable =titleLable;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.textColor = ComonTextColor;
    [headView addSubview:titleLable];
    [titleLable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).offset(100);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.left.equalTo(headView).offset(15);
        make.height.mas_equalTo(17);
    }];
    /**
     *  星星
     */
    HXStarView * star = [[HXStarView alloc] init];
    self.star = star;
    [headView addSubview:star];
    [star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.top.equalTo(titleLable.mas_bottom).offset(15);
        make.width.mas_offset(115);
        make.height.mas_equalTo(15);
    }];
    /**
     *  案例
     */
    UILabel * casesLabel = [[UILabel alloc] init];
    self.casesLabel = casesLabel;
    casesLabel.font = [UIFont systemFontOfSize:13];
    casesLabel.textColor = kUIColorFromRGB(0x999999);
    [headView addSubview:casesLabel];
    [casesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(star.mas_bottom).offset(15);
        make.centerX.equalTo(headView);
    }];
    
    UIView * yuyueBackView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 20, 80, 22)];
    self.yuyueBackView = yuyueBackView;
    yuyueBackView.backgroundColor = kUIColorFromRGB(0xFFF1F6);

    [self creatCorenadius];

    /**
     *  预约
     */
    UILabel * orderLabel = [[UILabel alloc] init];
    self.orderLabel = orderLabel;
    orderLabel.text = @"预约：0";
    orderLabel.font = [UIFont systemFontOfSize:13];
    orderLabel.textColor = kUIColorFromRGB(0xFF99BD);
    [yuyueBackView addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(yuyueBackView);
        make.left.equalTo(yuyueBackView).offset(10);
        make.right.equalTo(yuyueBackView).offset(-5);
    }];
//
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

- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (_headImage.size.width / _headImage.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * _headImage.size.height / _headImage.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * _headImage.size.width / _headImage.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

-(void)creatCorenadius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.yuyueBackView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft  cornerRadii:CGSizeMake(11,11)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.yuyueBackView.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.yuyueBackView.layer.mask = maskLayer;
    
    
    [self.headView addSubview:self.yuyueBackView];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.viewModel.commentArr.count>0?self.viewModel.dtoListArr.count>0?4:3:self.viewModel.dtoListArr.count>0?3:2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==1) {
        return 1;
    }
    if (self.viewModel.commentArr.count>0 && section==2) {
        return 1;
    }
    
    if ((section == 3 && self.viewModel.dtoListArr.count>0) ||(self.viewModel.commentArr.count==0&&section==2&&self.viewModel.dtoListArr.count>0) ) {
        if (self.viewModel.dtoListArr.count>3&&!self.viewModel.shopAllBool) {
            return 3;
        }
        return self.viewModel.dtoListArr.count;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdentity = @"IdentityInfoCell1";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            UIImageView * addressImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
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
            
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = HXRGB(221, 221, 221);
            [cell.contentView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.contentView);
                make.height.mas_equalTo(0.5);
                make.left.equalTo(cell.contentView).mas_offset(0);
                make.width.mas_equalTo(SCREEN_WIDTH);
            }];
            
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        cell.selectedBackgroundView.backgroundColor = kUIColorFromRGB(0xf9f9f9);
        self.locationLabel.text = self.viewModel.tenantModel.companyAddress?self.viewModel.tenantModel.companyAddress:@"";
        return cell;
        
    }else if (indexPath.section == 1) {
        static NSString *cellIdentity = @"IdentityInfoCell2";
        BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            /**
             *  图片浏览器
             */
            AcdseeCollection * acd = [[AcdseeCollection alloc] init];
            acd.collectionView.frame = CGRectMake(0, 15, SCREEN_WIDTH,0);
            self.acd = acd;
            [cell.contentView addSubview:acd];
            [acd mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView);
                make.top.equalTo(cell.contentView);
                make.height.mas_equalTo(0);
            }];
            
            UILabel * titleLabel = [[UILabel alloc] init];
            self.titleLabel = titleLabel;
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.textColor = kUIColorFromRGB(0x666666);
            titleLabel.numberOfLines = 0;
            [cell.contentView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(15);
                make.right.equalTo(cell.contentView).offset(-15);
                make.top.equalTo(acd.mas_bottom).offset(8);
                make.height.mas_equalTo(0);
            }];
            
        }
        if (self.viewModel.imgDocArr.count>0) {
            [self.acd mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(93);
            }];
            self.acd.collectionView.frame =CGRectMake(0, 15, SCREEN_WIDTH,70);
        }
        self.titleLabel.text = self.viewModel.tenantModel.introduction ?self.viewModel.tenantModel.introduction:@"";
        float height = self.viewModel.tenantModel.introduceHeight;
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        self.acd.imageArr = self.viewModel.imgDocArr;
        [self.acd.collectionView reloadData];
        return cell ;
    }else if((self.viewModel.dtoListArr.count>0 && indexPath.section == 3) || (self.viewModel.commentArr.count==0 && indexPath.section==2)){
        static NSString *cellIdentity = @"IdentityInfoCell3";
        BeautyClinicCell *cell = (BeautyClinicCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BeautyClinicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            [cell creatLine:0 hidden:NO];
        }
        cell.model = [self.viewModel.dtoListArr objectAtIndex:indexPath.row];
        return cell;
    }else {
        
        static NSString *cellIdentity = @"IdentityInfoCell4";
        BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            /**
             *  网友点评
             */
            UILabel * commentLabel = [[UILabel alloc] init];
            self.commentLabel = commentLabel;
            commentLabel.font = [UIFont systemFontOfSize:14];
            commentLabel.textColor = kUIColorFromRGB(0x333333);
            [cell.contentView addSubview:commentLabel];
            [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView.mas_left).offset(15);
            }];
            /**
             *  箭头图标
             */
            UIImageView * arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NextButton"]];
            [cell.contentView addSubview:arrowImage];
            [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-15);
            }];
        }
       self.commentLabel.text = [NSString stringWithFormat:@"网友点评 (%ld)",(long)self.viewModel.commentNumber];
        return cell;
        
        
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    }else if(indexPath.section == 1) {
        if (self.viewModel.imgDocArr.count==0) {
            return self.viewModel.tenantModel.introduceHeight==0.00?0.00:self.viewModel.tenantModel.introduceHeight +20;
        }else {
            
            return self.viewModel.tenantModel.introduceHeight==0.00?113:self.viewModel.tenantModel.introduceHeight+113;
        }
        return self.viewModel.tenantModel.cellHeight;
    }else if(self.viewModel.commentArr.count>0&&indexPath.section==2){
        return 50;
    }else {
        return 115;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.viewModel.commentArr.count>0) {
        if (section==3 && self.viewModel.recomNumber>3 &&!self.viewModel.shopAllBool) {
            return 54;
        }
    }else {
        if (section==2 && self.viewModel.recomNumber>3 &&!self.viewModel.shopAllBool) {
            return 54;
        }
    }
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
        
        return 10;
    }
    if (section==1) {
        return 0.1;
    }
    if (self.viewModel.commentArr.count>0) {
        if (section==2) {
            return 10;
        }else {
            return 55;
        }
    }else {
        if (section==2) {
            return 55;
        }else {
            return 0.1;
        }
    }
    
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = COLOR_BACKGROUND;
        return view;
    }
    /**
     *  section 标题
     */
    if ((self.viewModel.commentArr.count>0&&section==3) || (self.viewModel.commentArr.count==0&&section==2)) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
        view.backgroundColor = kUIColorFromRGB(0xffffff);
        UIView * heaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        heaView.backgroundColor = COLOR_BACKGROUND;
        [view addSubview:heaView];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 45)];
        titleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:14];
        titleLabel.textColor = kUIColorFromRGB(0x333333);
        [view addSubview:titleLabel];
        titleLabel.text = @"本院推荐";
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = HXRGB(221, 221, 221);
        [view addSubview:line];
        return view;
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ((self.viewModel.commentArr.count>0&&section==3)||(self.viewModel.commentArr.count==0&&section==2)) {
        UIView * footView;
        if (self.viewModel.recomNumber>3&& !self.viewModel.shopAllBool) {
            
            footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
            footView.backgroundColor = COLOR_BACKGROUND;
            
            UIButton * seeAllbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            seeAllbutton.selected = NO;
            [seeAllbutton addTarget:self action:@selector(seeAllAction:) forControlEvents:UIControlEventTouchUpInside];
            seeAllbutton.tag = FootBtnTag+section;
            seeAllbutton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
            seeAllbutton.backgroundColor = kUIColorFromRGB(0xffffff);
            seeAllbutton.titleLabel.font = [UIFont systemFontOfSize:14];
            [seeAllbutton setTitle:@"查看全部" forState:UIControlStateNormal];
            [seeAllbutton setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
            if(section==1){
                UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
                line.backgroundColor = HXRGB(221, 221, 221);
                [seeAllbutton addSubview:line];
            }
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = HXRGB(221, 221, 221);
            [seeAllbutton addSubview:line];
            [footView addSubview:seeAllbutton];
        }else {
            footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
            footView.backgroundColor = COLOR_BACKGROUND;
            
        }
        return footView;
    }
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        HXMapViewController * mapView = [[HXMapViewController alloc] init];
        CLLocationCoordinate2D coordinate =[self GCJ02FromBD09:CLLocationCoordinate2DMake([self.viewModel.tenantModel.latitude doubleValue],[self.viewModel.tenantModel.longitude doubleValue])];
        mapView.companyAddress = self.viewModel.tenantModel.companyAddress;
        mapView.coordinate = coordinate;
        mapView.titleName = self.viewModel.tenantModel.name;
        [self.navigationController pushViewController:mapView animated:YES];
        return;
    }
    if (self.viewModel.commentArr.count>0 && indexPath.section==2) {
        [self commentBtnAction];
    }
    if ((indexPath.section == 3&&self.viewModel.commentArr.count!=0) ||(indexPath.section==2&&self.viewModel.commentArr.count==0) ) {
        DtoListModel * model = [self.viewModel.dtoListArr objectAtIndex:indexPath.row];
        HXProductDetailViewController * product = [[HXProductDetailViewController alloc] init];
        product.viewModel.proId = model.id;
        [self.navigationController pushViewController:product animated:YES];
    }
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
#pragma mark -- request
- (void)getDetaile{
    [_viewModel archiveDetailDataWithReturnBlock:^{
        [self.tableView reloadData];
        self.titleLable.text = _viewModel.tenantModel.name?_viewModel.tenantModel.name:@"";
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.viewModel.tenantModel.icon] placeholderImage:[UIImage imageNamed:@"listLogo"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(image) {
             self.headImage.image =   [self cutImage:image];
            }
        }];
        CGFloat titleHeight = [Helper heightOfString:self.titleLable.text font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH-130];
        if (titleHeight > 32) {
            
        }
        self.star.star = [_viewModel.tenantModel.starRating doubleValue];
        [self.star setNeedsLayout];
        self.casesLabel.text = _viewModel.tenantModel.caseNum?[NSString stringWithFormat:@"总体：%@",_viewModel.tenantModel.starRating]:@"总体：0";
        NSString * yuyueStr = _viewModel.tenantModel.reservationNum?[NSString stringWithFormat:@"预约：%@",_viewModel.tenantModel.reservationNum]:@"预约：0";
        CGFloat length = [Helper widthOfString:yuyueStr font:[UIFont systemFontOfSize:13] height:13];
        if (length+15>80) {
            self.yuyueBackView.frame = CGRectMake(SCREEN_WIDTH-length-16, 20, length+16, 22);
            [self creatCorenadius];
        }else {
            self.yuyueBackView.frame = CGRectMake(SCREEN_WIDTH-80, 20, 80, 22);
            [self creatCorenadius];
        }
        self.orderLabel.text = yuyueStr;
        [self.bannerView reloadData];
        [self.tableView reloadData];
        
    } fail:^{
        [self.view bringSubviewToFront:self.backButton];
    }];
    
    [_viewModel archiveRecommendShopReturnBlock:^{
        [self.tableView reloadData];
    }];
    
    [_viewModel archiveCommentWithReturnBlock:^{
        
        [_tableView reloadData];
        
    }];
    
    
    
}
#pragma mark ZYBannerViewDataSource

// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {
    return self.viewModel.imgListArr.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的v iew, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    // 取出数据
    NSString *imageName = [Helper photoUrl:self.viewModel.imgListArr[index] width:SCREEN_WIDTH*2 height:460];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"banner3"] options:SDWebImageAllowInvalidSSLCertificates];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

#pragma mark ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld个项目", (long)index);
}
#pragma mark 查看全部
-(void)seeAllAction:(UIButton *)button {
    if (self.viewModel.commentArr.count>0) {
    if (button.tag == FootBtnTag+3) {
        self.viewModel.shopAllBool = YES;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    }else {
        if (button.tag == FootBtnTag+2) {
            self.viewModel.shopAllBool = YES;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }
    
}
#pragma mark -- hxcomdelegate
-(void)updateTableViewHeight {
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [CATransaction commit];
    
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
        HXPreDtoModel * model = [[HXPreDtoModel alloc] init];
        model.merId = self.viewModel.merId;
        model.id = @"";
        confirm.viewModel.name = self.viewModel.tenantModel.name;
        confirm.viewModel.address = self.viewModel.tenantModel.companyAddress;
        confirm.viewModel.preModel = model;
        confirm.viewModel.imageUrl = self.viewModel.tenantModel.icon;
        [self.navigationController pushViewController:confirm animated:YES];
    }else {
        [Helper pushLogin:self];
    }
    
}
-(void)commentBtnAction {
    
    HXAllEvaluationViewController * hxallEvaluation = [[HXAllEvaluationViewController alloc] init];
    hxallEvaluation.viewModel.commentArr = self.viewModel.commentArr;
    hxallEvaluation.viewModel.commentNumber = self.viewModel.commentNumber;
    hxallEvaluation.viewModel.merId = self.viewModel.merId;
    [self.navigationController pushViewController:hxallEvaluation animated:YES];
    
}

-(void)bringtoFront {
    
    [self.view bringSubviewToFront:self.backButton];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    if (scrollView.contentOffset.y<=0) {
    //        scrollView.contentOffset = CGPointMake(0, -20) ;
    //    }
}
#pragma mark -- 返回
-(void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
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
