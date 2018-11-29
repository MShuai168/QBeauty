//
//  HXWeddingdetailViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXWeddingdetailViewController.h"
#import "ComButton.h"
#import "DockBeautyCell.h"
#import "HXCommentCell.h"
#import "HXWeddingDetailCell.h"
#import "AcdseeCollection.h"
#import "HXConfirmReservationViewController.h"
#import "HXPreDtoModel.h"
#define FootBtnTag 500
@interface HXWeddingdetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UILabel * titleLable; //标题
@property (nonatomic,strong) UILabel * informationLabel; //预约期
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) HXStarView * starView;
@property (nonatomic,strong)UILabel * orderLabel;//订单数
@property (nonatomic,strong)UILabel * locationLabel; //地址
@property (nonatomic,strong)AcdseeCollection * acd; //图片浏览器
@property (nonatomic,strong)UILabel * titleLabel; //简介

@property (nonatomic,strong)UIButton * seeAllbutton;
@end

@implementation HXWeddingdetailViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXDetailsViewModel alloc] init];
//        [self.viewModel paddingData];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self creatUI];
    [self request];
}
-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
/**
 *  隐藏导航栏
 */
-(void)editNavi {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = COLOR_BACKGROUND;
}
-(void)creatUI {
    /**
     *  项目tableview
     */
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (iphone_X) {
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    _tableView = tableView;
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
        make.top.equalTo(self.view.mas_top).offset(-20);
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
    UIImageView * headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    //    headImage.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
    [headImage setImage:[UIImage imageNamed:@"bigHosptal"]];
    [headView addSubview:headImage];
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
        [footView addSubview:button];
        [button addTarget:self action:@selector(comButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footView);
            make.bottom.equalTo(footView);
            make.left.equalTo(footView.mas_left).offset(SCREEN_WIDTH/2*i);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
        if (i==0) {
            button.photoImage.image = [UIImage imageNamed:@"phone"];
            [button.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.mas_top).offset(5);
            }];
            [button.nameLabel setText:@"电话咨询"];
            [button.nameLabel setTextColor:ComonCharColor];
            [button.nameLabel setFont:[UIFont systemFontOfSize:10]];
            [button.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.photoImage.mas_bottom).offset(5);
            }];
            button.backgroundColor = kUIColorFromRGB(0xffffff) ;
        }else {
            button.backgroundColor = ComonBackColor ;
            [button setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [button setTitle:@"免费预约" forState:UIControlStateNormal];
        }
    }
    /**
     *  返回按钮
     */
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(30);
        
    }];
}
-(void)request {
    [_viewModel archiveDetailDataWithReturnBlock:^{
        [self.tableView reloadData];
    } fail:^{
        
    }];
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return _weddingBool?4:1;
    }
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
        self.titleLable.text = _viewModel.tenantModel.name?_viewModel.tenantModel.name:@"";
         self.orderLabel.text = _viewModel.tenantModel.reservationNum?[NSString stringWithFormat:@"%@预约",_viewModel.tenantModel.reservationNum]:@"0预约";
//        NSString * money = self.viewModel.preDtoModel.stagePrice?[NumAgent roundDown:self.viewModel.preDtoModel.stagePrice ifKeep:NO] : @"0";
//        NSString * date = self.viewModel.preDtoModel.stagePeriod ? self.viewModel.preDtoModel.stagePeriod :@"0";
//        self.informationLabel.text = [NSString stringWithFormat:@"约：¥%@起 x%@期",money,date];
//        [Helper justLabel:self.informationLabel title:[NSString stringWithFormat:@"%@",money] font:24];
        self.starView.star = _viewModel.tenantModel.starRating ? [_viewModel.tenantModel.starRating doubleValue] :0;
        if (_viewModel.tenantModel.starRating) {
            
            [self.starView layoutSubviews];
        }
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellIdentity = @"IdentityInfoCell1";
        BaseTableViewCell * cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
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
            locationLabel.textColor = kUIColorFromRGB(0x999999);
            [cell.contentView addSubview:locationLabel];
            [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView).offset(36);
                make.right.equalTo(cell.contentView).offset(-40);
                make.height.mas_lessThanOrEqualTo(36);
            }];
            
        }
        self.locationLabel.text = self.viewModel.tenantModel.companyAddress?self.viewModel.tenantModel.companyAddress:@"";
        return cell;
        
    }else if (indexPath.section == 2) {
        if (_weddingBool) {
            
            static NSString *cellIdentity = @"IdentityInfoCell2";
            HXWeddingDetailCell *cell = (HXWeddingDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if (!cell) {
                cell = [[HXWeddingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
                [cell creatLine:15 hidden:NO];
            }
            return cell;
        }else {
            static NSString *cellIdentity = @"IdentityInfoCell2";
            BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if (!cell) {
                cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
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
            float height = self.viewModel.tenantModel.introduceHeight>50 ?50:self.viewModel.tenantModel.introduceHeight;
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            self.acd.imageArr = self.viewModel.imgDocArr;
            [self.acd.collectionView reloadData];
            return cell ;

        }
        
    }else {
        static NSString *cellIdentity = @"IdentityInfoCell3";
        HXCommentCell *cell = (HXCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        cell.hxcModel = self.viewModel.hxcModel;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.viewModel.tenantModel.titleHeight>90? self.viewModel.tenantModel.titleHeight :90;
    }else if(indexPath.section == 1) {
        return 50;
    }else if(indexPath.section == 2){
        NSLog(@"%f",self.viewModel.tenantModel.cellHeight);
        if (_weddingBool) {
            
            return 90 ;
        }
        UIButton * footButton = (UIButton *)[_tableView viewWithTag:FootBtnTag+2];
        if (self.viewModel.tenantModel.introduceHeight>50) {
            if (!footButton.selected) {
                return 163;
            }else {
                return self.viewModel.tenantModel.introduceHeight +113;
            }
            
        }
        return self.viewModel.tenantModel.cellHeight;
    }else {
        return self.viewModel.hxcModel.cellHeight;;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==2 && !_weddingBool) {
        if (self.viewModel.tenantModel.introduceHeight<50) {
            return 0.1;
        }else {
            return 44;
        }
    }
    if (section==3) {
        return 10;
    }
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }else if(section==1){
        return 10;
    }else {
        return 54;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }else if(section==1){
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        headView.backgroundColor = COLOR_BACKGROUND;
        return headView;
    }else if(section==2){
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
        headView.backgroundColor = COLOR_BACKGROUND;
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 45)];
        view.backgroundColor = kUIColorFromRGB(0xffffff);
        [headView addSubview:view];
        /**
         *  婚宴厅
         */
        UILabel * weddLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 45)];
        weddLable.font = [UIFont fontWithName:@".PingFangSC-Medium" size:14];
        weddLable.textColor = ComonTextColor;
        weddLable.text = _weddingBool ?@"宴会厅(6)":@"商户信息";
        [view addSubview:weddLable];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = CellLineColor;
        [headView addSubview:line];
        
        return headView;
    }else {
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
        headView.backgroundColor = COLOR_BACKGROUND;
        /**
         *  评论按钮
         */
        UIButton * commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
        commentBtn.backgroundColor = kUIColorFromRGB(0xffffff);
        [headView addSubview:commentBtn];
        /**
         *  网友点评
         */
        UILabel * commentLabel = [[UILabel alloc] init];
        commentLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:14];
        commentLabel.text = @"网友点评 (24)";
        commentLabel.textColor = kUIColorFromRGB(0x333333);
        [commentBtn addSubview:commentLabel];
        [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(commentBtn);
            make.left.equalTo(commentBtn.mas_left).offset(15);
        }];
        /**
         *  箭头图标
         */
        UIImageView * arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NextButton"]];
        [commentBtn addSubview:arrowImage];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(commentBtn);
            make.right.equalTo(commentBtn.mas_right).offset(-15);
        }];
        /**
         *  下划线
         */
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 53.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = CellLineColor;
        [headView addSubview:line];
        
        return headView;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2 && !_weddingBool) {
        if (self.viewModel.tenantModel.introduceHeight<50) {
            return nil;
        }
        if (_seeAllbutton == nil) {
            
            UIButton * seeAllbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.seeAllbutton = seeAllbutton;
            seeAllbutton.selected = NO;
            [seeAllbutton addTarget:self action:@selector(seeAllAction:) forControlEvents:UIControlEventTouchUpInside];
            seeAllbutton.tag = FootBtnTag+section;
            seeAllbutton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
            seeAllbutton.backgroundColor = kUIColorFromRGB(0xffffff);
            seeAllbutton.titleLabel.font = [UIFont systemFontOfSize:14];
            [seeAllbutton setTitle:@"查看全部" forState:UIControlStateNormal];
            [seeAllbutton setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
            if(section==2){
                UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
                line.backgroundColor = HXRGB(221, 221, 221);
                [seeAllbutton addSubview:line];
            }
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = HXRGB(221, 221, 221);
            [seeAllbutton addSubview:line];
        }
        return _seeAllbutton;
    }
    if (section==3) {
        UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        footView.backgroundColor = COLOR_BACKGROUND;
        return footView;
    }
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    /**
     *  星星
     */
    HXStarView * star = [[HXStarView alloc] init];
    self.starView =star;
    [cell.contentView addSubview:star];
    [star  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(10);
        make.left.equalTo(cell.contentView).offset(15);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(100);
    }];
    
    UILabel * informationLabel = [[UILabel alloc] init];
    self.informationLabel = informationLabel;
    informationLabel.font = [UIFont systemFontOfSize:14];
    informationLabel.textColor = kUIColorFromRGB(0x999999);
    [cell.contentView addSubview:informationLabel];
    [informationLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView.mas_bottom).offset(-10);
        make.left.equalTo(cell.contentView).offset(15);
        make.right.equalTo(cell.contentView).offset(-15);
        make.height.mas_lessThanOrEqualTo(24);
    }];
    
    /**
     *  预约
     */
    UILabel * orderLabel = [[UILabel alloc] init];
    self.orderLabel = orderLabel;
    orderLabel.font = [UIFont systemFontOfSize:11];
    orderLabel.textColor = kUIColorFromRGB(0x999999);
    [cell.contentView addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView.mas_bottom).offset(-10);
        make.right.equalTo(cell.contentView.mas_right).offset(-15);
    }];
}
#pragma mark 查看全部
-(void)seeAllAction:(UIButton *)button {
    if (button.tag == FootBtnTag+2) {
        if (!button.selected) {
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.viewModel.tenantModel.introduceHeight);
            }];
            [button setTitle:@"点击回收" forState:UIControlStateNormal];
        }else {
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(50);
            }];
            [button setTitle:@"查看全部" forState:UIControlStateNormal];
        }
        button.selected = !button.selected;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
    
    
}
#pragma  mark -- 预约 电话
-(void)comButtonAction:(id)sender {
    
    HXConfirmReservationViewController * confirm = [[HXConfirmReservationViewController alloc] init];
    HXPreDtoModel * model = [[HXPreDtoModel alloc] init];
    model.merId = self.viewModel.merId;
    model.id = @"";
    confirm.viewModel.name = self.viewModel.tenantModel.name;
    confirm.viewModel.address = self.viewModel.tenantModel.companyAddress;
    confirm.viewModel.preModel = model;
    [self.navigationController pushViewController:confirm animated:YES];
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
