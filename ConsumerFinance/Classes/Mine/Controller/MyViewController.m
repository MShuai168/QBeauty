//
//  MyViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//
#import "MyViewController.h"
#import "ComButton.h"
#import "MyTableViewCell.h"
#import "HXAddressViewController.h"
#import "MyProfileViewController.h"
#import "HXSettingViewController.h"
#import "HXMyViewModel.h"
#import "HXRecordViewController.h"
#import "HXMyViewLayout.h"
#import "HXMyNumberModel.h"

#import "PageViewController.h"
#import "StoreOrderViewController.h"  //门店订单
#import "BalanceDetailVC.h" //余额详情
#import "AmbassadorViewController.h"  //我的美丽大使
#import "ReservationViewController.h"  //我的预约

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
    UIView *_headView;
}
@property (nonatomic,strong)UIButton * loadButton;
@property (nonatomic,strong)UIImageView * headImage;
@property (nonatomic,strong)NSString * photoUrl;
@property (nonatomic,assign)BOOL first;
@property (nonatomic,strong)UIView * headView;
@property (nonatomic,strong)UIImageView * headVImageView;
@property (nonatomic,strong)UIImageView * photoBackImage;
@property (nonatomic,strong)UIImageView * userImageView;
@property (nonatomic,strong)HXMyViewModel * viewModel;
@property (nonatomic,strong)ComButton * userButton;
@property (nonatomic,strong)UILabel * dfkNumberLabel;
@property (nonatomic,strong)UILabel * dfhNumberLabel;
@property (nonatomic,strong)UILabel * dshNumberLabel;
@property (nonatomic,strong)UILabel * qtNumberLabel;

@property (nonatomic,strong)UILabel * yhqNumberLabel;
@property (nonatomic,strong)UILabel * jckNumberLabel;
@property (nonatomic,strong)UILabel * czkNumberLabel;
@property (nonatomic,strong)UILabel * mdNumberLabel;

@end

@implementation MyViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXMyViewModel alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.first = NO;
    
    [self createTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updaStates) name:Notification_HeadPHoto object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    if ([[AppManager manager] isOnline]) {
        self.loadButton.hidden = YES;
        self.userButton.hidden = NO;
        if ([[AppManager manager] getMyPhone].length !=0) {
            self.userButton.nameLabel.text = [[AppManager manager] getMyPhone];
        }else {
            self.userButton.nameLabel.text = @"";
        }
        if (!self.first) {
            [self request];
            self.first = YES;
        }
        [self archiveNumber];
    }else {
        self.loadButton.hidden = NO;
        self.userButton.hidden = YES;
        self.userImageView.image = [UIImage imageNamed:@"toxiang"];
        self.viewModel.numberModel = nil;
        [_tableView reloadData];
    }
}
-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (BOOL)hidesBottomBarWhenPushed {
    return (self.navigationController.topViewController != self);
}
-(void)createTableView{
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.backgroundColor = CommonBackViewColor;
    //    if (@available(iOS 11.0, *)) {
    //        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    //    }
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(iphone_X?-44:-20);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    /**
     *  tableHeaderView
     */
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    headView.backgroundColor = COLOR_BACKGROUND;
    _tableView.tableHeaderView = headView;
    
    UIImageView * headVImageView = [[UIImageView alloc] init];
    self.headVImageView = headVImageView;
    [headVImageView setImage:[UIImage imageNamed:@"mybg"]];
    [headView addSubview:headVImageView];
    [headVImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(0);
        make.left.equalTo(headView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(230);
    }];
    
    UIButton * loadButton = [[UIButton alloc] init];
    self.loadButton = loadButton;
    loadButton.backgroundColor = [CommonBackViewColor colorWithAlphaComponent:0.2];
    loadButton.layer.borderWidth = 0.5;
    loadButton.layer.borderColor = [CommonBackViewColor colorWithAlphaComponent:0.8].CGColor;
    [loadButton setTitle:@"登录/注册" forState:UIControlStateNormal];
    [loadButton setTitleColor:CommonBackViewColor forState:UIControlStateNormal];
    [loadButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    loadButton.layer.cornerRadius = 0.5;
    loadButton.layer.cornerRadius = 20;
    [loadButton addTarget:self action:@selector(loandButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:loadButton];
    [loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.centerX.equalTo(headView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    
    
    ComButton * userButton = [[ComButton alloc] init];
    self.userButton = userButton;
    [userButton addTarget:self action:@selector(loandButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [loadButton setTitle:@"登录/注册" forState:UIControlStateNormal];
    [userButton.nameLabel setFont: [UIFont systemFontOfSize:18]];
    [userButton.nameLabel setTextColor:CommonBackViewColor];
    [headView addSubview:userButton];
    
    UIImageView * photoBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userphoto2"]];
    self.photoBackImage = photoBackImage;
    self.photoBackImage.hidden = YES;
    [userButton addSubview:photoBackImage];
    [photoBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userButton).offset(20);
        make.centerX.equalTo(userButton);
    }];
    
    UIImageView * userImageView  =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toxiang"]];
    self.userImageView = userImageView;
    userImageView.layer.cornerRadius = 35;
    userImageView.layer.masksToBounds = YES;
    [userButton addSubview:userImageView];
    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userButton).offset(32);
        make.centerX.equalTo(loadButton);
        make.height.and.width.mas_equalTo(70);
    }];
    
    [userButton.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(userButton);
        make.centerX.equalTo(userButton);;
    }];
    
    [userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(44);
        make.centerX.equalTo(headView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(140);
    }];
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else {
        return 5;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    static NSString *cellIdentifyFir = @"IdentityInfoCellFir";
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            NSArray * nameArr = @[@"待付款",@"待发货",@"待收货",@"趣淘订单",@"优惠券",@"计次卡",@"储值卡",@"门店订单"];
            NSArray * imageNameArr = @[@"daizhifu",@"daifahuo",@"daishouhuo",@"qutaoorder",@"youHuiQuan",@"jiCiKa",@"chuZhiKa",@"menDianDingDan"];
            /**
             *   预约 订单 评价
             */
            for (int i = 0; i < nameArr.count; i++) {
                
                ComButton * comButton = [[ComButton alloc] init];
                [comButton addTarget:self action:@selector(comButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                comButton.tag = i+200;
                [comButton.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(comButton).offset(10);
                }];
                comButton.nameLabel.text = [nameArr objectAtIndex:i];
                comButton.nameLabel.font = [UIFont systemFontOfSize:14];
                [comButton.photoImage setImage:[UIImage imageNamed:[imageNameArr objectAtIndex:i]]];
                comButton.nameLabel.textColor = ComonTextColor ;
                //                comButton.backgroundColor = [UIColor cyanColor];
                //                cell.backgroundColor = UIColor.magentaColor;
                [cell.contentView addSubview:comButton];
                [comButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.offset(85);
                    make.width.offset(SCREEN_WIDTH/4);
                    
                    make.left.equalTo(cell.contentView.mas_left).offset(SCREEN_WIDTH/4*(i%4));;
                    make.top.equalTo(cell.contentView.mas_top).offset((i/4)%2*87); //第二排和第一排的间距(87-85)
                    //                    NSLog(@"i=%d %@  top=%d", i,comButton.nameLabel.text,(i/4)%2*85 + 0);
                }];
                
                UILabel * numberLabel = [[UILabel alloc] init];
                numberLabel.text = @"0";
                numberLabel.hidden = YES;
                numberLabel.layer.cornerRadius = 8.5;
                numberLabel.layer.masksToBounds = YES;
                numberLabel.textAlignment = NSTextAlignmentCenter;
                numberLabel.backgroundColor = kUIColorFromRGB(0xFF6098);
                numberLabel.textColor = CommonBackViewColor;
                numberLabel.font = [UIFont systemFontOfSize:12];
                [comButton.photoImage addSubview:numberLabel];
                [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(comButton.photoImage).offset(-5);
                    make.right.equalTo(comButton.photoImage).offset(2);
                    make.height.and.width.mas_equalTo(17);
                }];
                
                if (i==0) {
                    self.dfkNumberLabel = numberLabel;
                } else if (i==1) {
                    self.dfhNumberLabel = numberLabel;
                } else if (i==2) {
                    self.dshNumberLabel = numberLabel;
                } else if (i==3) {
                    self.qtNumberLabel  = numberLabel;
                } else if (i == 4) {
                    self.yhqNumberLabel = numberLabel;
                } else if (i == 5) {
                    self.jckNumberLabel = numberLabel;
                } else if (i == 6) {
                    self.czkNumberLabel = numberLabel;
                } else if (i == 7) {
                    self.mdNumberLabel = numberLabel;
                }
            }
        }
        if (self.viewModel.numberModel) {
            [self showNumberWithCell:_dfkNumberLabel number:self.viewModel.numberModel.obligationNum?self.viewModel.numberModel.obligationNum:@"0"];
            [self showNumberWithCell:_dfhNumberLabel number:self.viewModel.numberModel.deliveringNum?self.viewModel.numberModel.deliveringNum:@"0"];
            [self showNumberWithCell:_dshNumberLabel number:self.viewModel.numberModel.deliveredNum?self.viewModel.numberModel.deliveredNum:@"0"];
            [self showNumberWithCell:_qtNumberLabel number:self.viewModel.numberModel.mallOrderNum?self.viewModel.numberModel.mallOrderNum:@"0"];
            
            [self showNumberWithCell:_yhqNumberLabel number:self.viewModel.numberModel.couponNum?self.viewModel.numberModel.couponNum:@"0"];
            [self showNumberWithCell:_jckNumberLabel number:self.viewModel.numberModel.accountCardNum?self.viewModel.numberModel.accountCardNum:@"0"];
            [self showNumberWithCell:_czkNumberLabel number:self.viewModel.numberModel.valueCardNum?self.viewModel.numberModel.valueCardNum:@"0"];
            //            [self showNumberWithCell:_mdNumberLabel number:self.viewModel.numberModel.mdNum?self.viewModel.numberModel.mdNum:@"0"];
        } else {
            _dfkNumberLabel.hidden = YES;
            _dfhNumberLabel.hidden = YES;
            _dshNumberLabel.hidden = YES;
            _qtNumberLabel.hidden = YES;
            
            _yhqNumberLabel.hidden = YES;
            _jckNumberLabel.hidden = YES;
            _czkNumberLabel.hidden = YES;
            _mdNumberLabel.hidden = YES;
        }
        return cell;
    } else {
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifyFir];
        if (!cell) {
            cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifyFir];
            [cell.rightButton setImage:[UIImage imageNamed:@"NextButton"] forState:UIControlStateNormal];
            [cell.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).offset(-15);
            }];
            NSArray * nameArr = @[@"我的余额",@"我的美丽大使",@"我的预约",@"地址管理",@"设置"];
            NSArray * imageNameArr = @[@"woDeYuE",@"ambassador",@"mysubscribe",@"mysite",@"myset"];
            cell.nameLabel.text = [nameArr objectAtIndex:indexPath.row];
            [cell.photoImage setImage:[UIImage imageNamed:[imageNameArr  objectAtIndex:indexPath.row]]];
            
            [cell.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
                if (indexPath.row == 1) {
                    make.left.equalTo(cell.contentView).offset(15);
                } else {
                    make.left.equalTo(cell.contentView).offset(0);
                }
                make.centerY.equalTo(cell.contentView);
            }];
        }
        
        if (indexPath.row != 0) {
            cell.numberLabel.hidden = YES;
        } else {
            //            if (self.viewModel.numberModel) {
            //                [self yuyueNumberWithCell:cell number:self.viewModel.numberModel.balance?self.viewModel.numberModel.balance:@"0"];
            //            } else {
            //                cell.numberLabel.hidden = YES;
            //            }
            if (self.viewModel.numberModel) {
                cell.statesLabel.text = self.viewModel.numberModel.balance?[NSString stringWithFormat:@"￥%.2f",self.viewModel.numberModel.balance]:@"";
            } else {
                cell.numberLabel.hidden = YES;
                cell.statesLabel.text = @"";
            }
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }else {
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return 10;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==1) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = COLOR_BACKGROUND;
        return view;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        return;
    }
    if (![[AppManager manager] isOnline]) {
        [Helper pushLogin:self];
        return;
    }
    if (indexPath.row == 0) {
        //我的余额
        BalanceDetailVC *VC = [[BalanceDetailVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        //        VC.totalMoney = self.viewModel.numberModel.balance;
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row == 1) {
        //我的美丽大使
        AmbassadorViewController *VC = [[AmbassadorViewController alloc] init];
        VC.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row==2) {
        //我的预约
        //        HXBookingViewController *bookingController = [[HXBookingViewController alloc] init];
        //        [self.navigationController pushViewController:bookingController animated:YES];
        ReservationViewController *VC = [[ReservationViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row==3) {
        HXAddressViewController *controller = [[HXAddressViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        controller.title = @"收货地址";
        controller.url = [NSString stringWithFormat:@"%@address",kScoreUrl];
        [self.navigationController pushViewController:controller animated:YES];
    } else if(indexPath.row==4){
        //设置
        HXSettingViewController * beauty = [[HXSettingViewController alloc] init];
        beauty.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:beauty animated:YES];
    }
}

-(void)showNumberWithCell:(UILabel *)numberLabel number:(NSString *)numberStr {
    if ([numberStr intValue]==0 || numberStr.length==0) {
        numberLabel.hidden = YES;
        numberLabel.text = @"0";
    } else {
        numberLabel.hidden = NO;
        numberLabel.text = [NSString stringWithFormat:@"%d",[numberStr intValue]>=99?99:[numberStr intValue]];
    }
}
-(void)yuyueNumberWithCell:(MyTableViewCell *)cell number:(NSString *)numberStr {
    if ([numberStr intValue]==0 || numberStr.length==0) {
        cell.numberLabel.hidden = YES;
        cell.numberLabel.text = @"0";
    }else {
        cell.numberLabel.hidden = NO;
        cell.numberLabel.text = [NSString stringWithFormat:@"%d",[numberStr intValue]>=99?99:[numberStr intValue]];
    }
}

-(void)request {
    NSDictionary * body = @{@"version":SHORT_VERSION,
                            @"device":@"iOS"
                            };
    [[HXNetManager shareManager] post:GetHeaderUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
//            if ([responseNewModel.body objectForKey:@"isBinding"]) {
//                if (![[responseNewModel.body objectForKey:@"isBinding"] boolValue]) {
//                    [HXSingletonView signletonView].model = [HXBankDtoModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"bankDto"]];
//                    [[HXSingletonView signletonView] creatView];
//                }
//            }
            
            self.photoUrl = [responseNewModel.body objectForKey:@"icon"];
            NSString *url = [Helper photoUrl:[responseNewModel.body objectForKey:@"icon"] width:100 height:100];
            //获取APP icon
            NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
            NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
            [self.userImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:icon] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    self.photoBackImage.hidden = NO;
                }else {
                    self.photoBackImage.hidden = YES;
                }
            }];
            self.first = YES;
        }else {
            self.first = NO;
        }
        
    } failure:^(NSError *error) {
        self.first = NO;
    }];
    
}
-(void)archiveNumber {
    [[HXNetManager shareManager] get:MyCenter parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.viewModel.numberModel = [HXMyNumberModel mj_objectWithKeyValues:responseNewModel.body];
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark Private Methods

-(void)loandButtonAction {
    if ([[AppManager manager] isOnline]) {
        MyProfileViewController * myprofile = [[MyProfileViewController alloc] init];
        NSString * url = [Helper photoUrl:self.photoUrl width:100 height:100];
        myprofile.photoUrl = url;
        myprofile.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myprofile animated:YES];
    }else {
        
        [Helper pushLogin:self];
    }
}
//监听
-(void)updaStates {
    [self request];
}

-(void)comButtonClick:(UIButton *)button {
    if (![[AppManager manager] isOnline]) {
        [Helper pushLogin:self];
        return;
    }
    switch (button.tag-200) {
        case 0:
        {
            HXRecordViewController * recored = [[HXRecordViewController alloc] init];
            recored.hidesBottomBarWhenPushed = YES;
            recored.viewModel.selectIndex = 1;
            [self.navigationController pushViewController:recored animated:YES];
        }
            break;
        case 1:
        {
            HXRecordViewController * recored = [[HXRecordViewController alloc] init];
            recored.hidesBottomBarWhenPushed = YES;
            recored.viewModel.selectIndex = 2;
            [self.navigationController pushViewController:recored animated:YES];
        }
            break;
        case 2:
        {
            HXRecordViewController * recored = [[HXRecordViewController alloc] init];
            recored.hidesBottomBarWhenPushed = YES;
            recored.viewModel.selectIndex = 2;
            [self.navigationController pushViewController:recored animated:YES];
        }
            break;
        case 3:
        {
            HXRecordViewController * recored = [[HXRecordViewController alloc] init];
            recored.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:recored animated:YES];
        }
            break;
            
        case 4:
        {  //我的优惠券
            PageViewController *recored = [[PageViewController alloc] init];
            recored.hidesBottomBarWhenPushed = YES;
            recored.typeFlag = @"youHuiQuan";
            [self.navigationController pushViewController:recored animated:YES];
        }
            break;
        case 5:
        { //计次卡
            PageViewController * recored = [[PageViewController alloc] init];
            recored.hidesBottomBarWhenPushed = YES;
            recored.typeFlag = @"jiCiKa";
            [self.navigationController pushViewController:recored animated:YES];
        }
            break;
        case 6:
        { //储值卡
            PageViewController * recored = [[PageViewController alloc] init];
            recored.hidesBottomBarWhenPushed = YES;
            recored.typeFlag = @"chuZhiKa";
            [self.navigationController pushViewController:recored animated:YES];
        }
            break;
        case 7:
        { //门店订单
            StoreOrderViewController * VC = [[StoreOrderViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        default:
            break;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

