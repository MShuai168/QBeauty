//
//  HXRecordDetailViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/21.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRecordDetailViewController.h"
#import "HXShoppingCartCell.h"
#import "FreezeHintView.h"
#import "HXScoreHomeViewController.h"
#import "HXShoppingCartViewController.h"
#import "HXAlertViewController.h"

@interface HXRecordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UILabel * statesLabel;
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,strong)UILabel * tsLabel;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UILabel * receiverLabel;
@property (nonatomic,strong)UILabel * receAddressLabel;
@property (nonatomic,strong)UILabel * phoneLabel;
@property (nonatomic,strong)UIButton * sureBtn;
@property (nonatomic,strong)UIButton * cancelBtn;
@property (nonatomic,strong)HXPaymentView * payment;
@property (nonatomic,strong)UIButton * addAddressBtn;
@property (nonatomic,strong)UIView * headView;
@property (nonatomic,strong)UILabel * shLabel;

@end

@implementation HXRecordDetailViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXRecordDetaiViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    [self hiddeKeyBoard];
    [MBProgressHUD showMessage:nil toView:self.view];
    [self request];
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [self hiddenNavgationBarLine:NO];
}
-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.title = @"兑换详情";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
-(void) hiddeKeyBoard{
    
    [self.view endEditing:YES];
    
}
-(void)createUI {
    UITableView *  tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    [tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 148)];
    self.headView = headView;
    tableView.tableHeaderView = headView;
    
    UIView * topView = [[UIView alloc] init];
    self.topView = topView;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kUIColorFromRGB(0xFA5578).CGColor,(__bridge id)[kUIColorFromRGB(0xFA7B55) colorWithAlphaComponent:1.0].CGColor , (__bridge id)kUIColorFromRGB(0xFA7B55).CGColor];
    gradientLayer.locations = @[@0.3,@0.7, @0.3];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    [topView.layer addSublayer:gradientLayer];
    [headView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(headView);
        make.top.equalTo(headView);
        make.height.mas_equalTo(60);
    }];
    
    UILabel * statesLabel = [[UILabel alloc] init];
    self.statesLabel = statesLabel;
    statesLabel.textColor = CommonBackViewColor;
    statesLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [topView addSubview:statesLabel];
    [statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.centerX.equalTo(topView);
        make.height.mas_equalTo(16);
    }];
    
    UILabel * tsLabel = [[UILabel alloc] init];
    self.tsLabel = tsLabel;
    tsLabel.hidden = YES;
    tsLabel.textColor = CommonBackViewColor;
    tsLabel.text = @"快买下我，超过24小时我就会消失～";
    tsLabel.font = [UIFont systemFontOfSize:12];
    [topView addSubview:tsLabel];
    [tsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.bottom.equalTo(topView).offset(-10);
    }];

    
    UIButton * addAddressBtn = [[UIButton alloc] init];
    self.addAddressBtn = addAddressBtn;
    addAddressBtn.backgroundColor = CommonBackViewColor;
    [headView addSubview:addAddressBtn];
    [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(headView);
        make.top.equalTo(headView).offset(60);
        make.height.mas_equalTo(78);
    }];
    
    UIImageView * locationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoplocation"]];
    [addAddressBtn addSubview:locationImage];
    [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addAddressBtn);
        make.left.equalTo(addAddressBtn).offset(12);
    }];
    UILabel * receiverLabel = [[UILabel alloc] init];
    self.receiverLabel = receiverLabel;
    receiverLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    receiverLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:receiverLabel];
    [receiverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addAddressBtn).offset(36);
        make.top.equalTo(addAddressBtn).offset(20);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-156);
        make.height.mas_equalTo(16);
    }];
    UILabel * shLabel = [[UILabel alloc] init];
    self.shLabel = shLabel;
    shLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    shLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:shLabel];
    [shLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addAddressBtn).offset(36);
        make.top.equalTo(addAddressBtn.mas_top).offset(43);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(12);
    }];
    
    UILabel * receAddressLabel = [[UILabel alloc] init];
    self.receAddressLabel = receAddressLabel;
    receAddressLabel.numberOfLines = 0 ;
    receAddressLabel.font = [UIFont systemFontOfSize:12];
    receAddressLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:receAddressLabel];
    [receAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shLabel.mas_right).offset(-3);
        make.top.equalTo(shLabel.mas_top).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-105);
        make.height.mas_equalTo(12);
    }];

    UILabel * phoneLabel = [[UILabel alloc] init];
    self.phoneLabel = phoneLabel;
    phoneLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    phoneLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addAddressBtn).offset(-12);
        make.top.equalTo(addAddressBtn).offset(20);
        make.width.mas_lessThanOrEqualTo(110);
        make.height.mas_equalTo(16);
    }];
    
    
    UIView * bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    bottomView.backgroundColor = CommonBackViewColor;
    bottomView.hidden = YES;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kUIColorFromRGB(0xE5E5E5);
    [bottomView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView);
        make.left.equalTo(bottomView).offset(0);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    UIButton * sureBtn = [[UIButton alloc] init];
    self.sureBtn = sureBtn;
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = [kUIColorFromRGB(0xFA5555) colorWithAlphaComponent:0.1];
    sureBtn.layer.borderColor = ComonBackColor.CGColor;
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sureBtn setTitleColor:ComonBackColor forState:UIControlStateNormal];
    sureBtn.layer.borderWidth = 0.5;
    [sureBtn setTitle:@"去支付" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 3;
    [bottomView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(-12);
        make.centerY.equalTo(bottomView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(88);
    }];
    
    UIButton * cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn = cancelBtn;
    cancelBtn.layer.borderColor = ComonCharColor.CGColor;
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancelBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
    cancelBtn.layer.borderWidth = 0.5;
    [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 3;
    [bottomView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sureBtn.mas_left).offset(-12);
        make.centerY.equalTo(bottomView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(88);
    }];
}
-(void)request {
    
    [self.viewModel archiveRecordStatesWithReturnBlock:^{
        [self changeStates];
    } failBlock:^{
        
    }];
    
}
-(void)changeStates {
    self.statesLabel.text = self.viewModel.headTitle;
    self.receiverLabel.text = [NSString stringWithFormat:@"收货人: %@",self.viewModel.detailModel.shippingReceiver.length!=0?self.viewModel.detailModel.shippingReceiver:@""];
    self.phoneLabel.text = self.viewModel.detailModel.shippingPhone.length!=0?self.viewModel.detailModel.shippingPhone:@"";
    self.receAddressLabel.text = [NSString stringWithFormat:@"%@",self.viewModel.detailModel.shippingAddress.length!=0?self.viewModel.detailModel.shippingAddress:@""];
    self.shLabel.text = @"收货地址：";
    CGFloat height = [Helper heightOfString:self.receAddressLabel.text font:[UIFont systemFontOfSize:12] width:SCREEN_WIDTH-105];
    if (height>20) {
        [self.receAddressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        [self.addAddressBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(43+height+15);
        }];
        self.headView.frame = CGRectMake(0, 0,SCREEN_WIDTH , 60+43+height+15+10);
    }else {
        [self.receAddressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(12);
        }];
        [self.addAddressBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(77);
        }];
        self.headView.frame = CGRectMake(0, 0,SCREEN_WIDTH , 148);
    }
    
//    
//    if (self.phoneLabel.text.length !=0&&self.phoneLabel.text.length>=8) {
//        self.phoneLabel.text =  [self.phoneLabel.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//    }
    
    if (self.viewModel.states == ShopStatuesWaitMoney || self.viewModel.states==ShopStatesStock) {
        self.tsLabel.hidden = NO;
        [self.statesLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView).offset(10);
            make.centerX.equalTo(self.topView);
            make.height.mas_equalTo(16);
        }];
        self.bottomView.hidden = NO;
        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-50);
        }];
    }else if (self.viewModel.states == ShopStatuesArchive) {
        self.bottomView.hidden = NO;
        [self.sureBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        self.cancelBtn.hidden = YES;
        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-50);
        }];
    }else {
        self.tsLabel.hidden = YES;
        [self.statesLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.topView);
            make.centerX.equalTo(self.topView);
            make.height.mas_equalTo(16);
            self.bottomView.hidden = YES;
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(0);
            }];
        }];
        
    }
    
    [self.tableView reloadData];
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.viewModel.detailModel.pro.count==0) {
        return 0;
    }
    return 1+self.viewModel.inforArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section!=0) {
        NSArray * arr = [self.viewModel.inforArr objectAtIndex:section-1];
        return arr.count;
    }else {
        return self.viewModel.detailModel.pro.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellIdentity = @"IdentityInfoCell";
        HXShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.detailBool = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.proModel = [self.viewModel.detailModel.pro objectAtIndex:indexPath.row];
        [cell creatLine:0 hidden:NO];
        return cell;
    }else {
        
        static NSString *cellIdentity = @"IdentityInfoCell1";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameLabel.font = [UIFont systemFontOfSize:12];
            cell.nameLabel.textColor = ComonCharColor;
            [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(12);
                make.top.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).offset(-12);
                make.height.mas_equalTo(17);
            }];
            cell.titleLabel.font = [UIFont systemFontOfSize:12];
            cell.titleLabel.textColor = ComonCharColor;
            cell.titleLabel.numberOfLines = 0;
            cell.titleLabel.hidden = YES;
            [cell.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).offset(70);
                make.top.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).offset(-12);
                make.height.mas_equalTo(17);
            }];
        }
        if(self.viewModel.states == ShopStatuesSuccess || self.viewModel.states == ShopStatuesArchive) {
        NSString * str =  [[self.viewModel.inforArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
            if ([str isEqualToString:@"商品信息："]) {
                cell.nameLabel.text = str;
                cell.titleLabel.hidden = NO;
                cell.titleLabel.text = [self.viewModel.shopInforArr objectAtIndex:indexPath.section-2];
                CGFloat height = [[self.viewModel.shopHeightArr objectAtIndex:indexPath.section-2] floatValue];
                [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(12);
                    make.top.equalTo(cell.contentView);
                    make.height.mas_equalTo(17);
                }];
                [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(height);
                }];
            }else {
                [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(12);
                    make.top.equalTo(cell.contentView);
                    make.right.equalTo(cell.contentView).offset(-12);
                    make.height.mas_equalTo(17);
                }];
                cell.nameLabel.text = [[self.viewModel.inforArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
                cell.titleLabel.hidden = YES;
                cell.titleLabel.text = @"";
            }
        }else {
            [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(12);
                make.top.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).offset(-12);
                make.height.mas_equalTo(17);
            }];
            cell.nameLabel.text = [[self.viewModel.inforArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
            cell.titleLabel.text = @"";
            cell.titleLabel.hidden = YES;
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 124;
    }else {
    if (self.viewModel.states == ShopStatuesSuccess || self.viewModel.states == ShopStatuesArchive ) {
         NSString * str =  [[self.viewModel.inforArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
         if ([str isEqualToString:@"商品信息："]) {
              CGFloat height = [[self.viewModel.shopHeightArr objectAtIndex:indexPath.section-2] floatValue];
             return height;
         }
       return indexPath.section==0?124:17;
    }else {
        return indexPath.section==0?124:17;
    }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return section==0?60:12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }else if (section==1) {
        return 22;
    }else if(section == 2) {
        return 12;
    }else {
        return 12;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section!=0) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
        view.backgroundColor = COLOR_BACKGROUND;
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 12)];
        
        UIImageView * baoguoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baoguo"]];
        [headView addSubview:baoguoImage];
        [baoguoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headView);
            make.right.equalTo(headView);
        }];
        
        UILabel * baoguoLabel = [[UILabel alloc] init];
        baoguoLabel.textColor = CommonBackViewColor;
        baoguoLabel.font = [UIFont systemFontOfSize:12];
        [baoguoImage addSubview:baoguoLabel];
        [baoguoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.and.centerY.equalTo(baoguoImage);
        }];
        
        if (section!=1) {
            view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 12);
            headView.frame = CGRectMake(0,0, SCREEN_WIDTH, 12);
            UIView * bottomLine = [[UIView alloc] init];
            bottomLine.backgroundColor = kUIColorFromRGB(0xE5E5E5);
            [headView addSubview:bottomLine];
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headView);
                make.left.equalTo(headView).offset(0);
                make.height.mas_equalTo(0.5);
                make.width.mas_equalTo(SCREEN_WIDTH);
            }];
            baoguoLabel.text = [NSString stringWithFormat:@"包裹%ld",section-1];
        }else {
            baoguoImage.hidden = YES;
        }
        [view addSubview:headView];
        headView.backgroundColor = CommonBackViewColor;
        return view;
        
    }
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = CommonBackViewColor;
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    titleLabel.textColor = ComonCharColor;
    titleLabel.text = @"全部商品";
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(12);
    }];
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kUIColorFromRGB(0xE5E5E5);
    [view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view);
        make.left.equalTo(view).offset(0);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    return view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section!=0) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 12)];
        view.backgroundColor = CommonBackViewColor;
        return view;
    }
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = CommonBackViewColor;
    
    UILabel * informationLabel = [[UILabel alloc] init];
    informationLabel.textAlignment =NSTextAlignmentRight;
    informationLabel.font = [UIFont systemFontOfSize:11];
    [view addSubview:informationLabel];
    [informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-120);
        make.right.equalTo(view).offset(-12);
        make.centerY.equalTo(view);
    }];
    NSString * totoalScore = @"0" ;
    NSString * totalMoney = @"0.00";
    NSInteger totalNumber = 0;
    for (HXProArrModel * model in self.viewModel.detailModel.pro) {
        model.quantity = model.quantity.length!=0?model.quantity:@"0";
        totalNumber = totalNumber + [model.quantity intValue];
    }
    totalMoney = self.viewModel.detailModel.totalAmount.length!=0?[NumAgent roundDown:self.viewModel.detailModel.totalAmount ifKeep:YES]:@"0.00";
    totoalScore = self.viewModel.detailModel.totalScore.length!=0?[NSString stringWithFormat:@"%d",[self.viewModel.detailModel.totalScore intValue]]:@"0";

    informationLabel.text = [NSString stringWithFormat:@"%@趣贝+¥%@",totoalScore,totalMoney];
    [Helper changeTextWithFont:16 title:informationLabel.text changeTextArr:@[totoalScore,totalMoney] label:informationLabel color:ComonBackColor];

    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = [NSString stringWithFormat:@"共%ld件  实付：",totalNumber];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    titleLabel.textColor = ComonTextColor;
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(informationLabel.mas_left).offset(0);
        make.centerY.equalTo(view);
    }];
    NSString * carrage = self.viewModel.detailModel.shippingExpense.length!=0?self.viewModel.detailModel.shippingExpense:@"0.00";
    UILabel * yfLabel = [[UILabel alloc] init];
    if ([carrage doubleValue]==0) {
        yfLabel.text = @"(免运费)";
    }else {
        yfLabel.text = [NSString stringWithFormat:@"(含运费：%@元)",[NumAgent roundDown:carrage ifKeep:YES]];;
    }
    yfLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    yfLabel.textColor = ComonCharColor;
    [view addSubview:yfLabel];
    [yfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).offset(-5);
        make.right.equalTo(informationLabel.mas_right).offset(0);
    }];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)sureBtnAction {
    if (self.viewModel.states == ShopStatuesArchive) {
        HXScorePromptView * promptView = [[HXScorePromptView alloc] initWithName:@"" TitleArr:@[@"商品全部到货后再确认收货哦~"] selectNameArr:@[@"再等等",@"确认收货"] comBool:YES sureBlock:^{
            [self changeType:@"5"];
            
        } cancelBlock:^{
            
        }];
        [promptView showAlert];
        return;
    }
    if (self.viewModel.undercarriage) {
        [self clearShopProduct];
        return;
    }
    if (self.viewModel.states == ShopStatuesWaitMoney) {
        [self.viewModel changeShopClearWithReturnBlock:^{
            self.payment = [[HXPaymentView alloc] initWithOrderNo:self.viewModel.model.orderNo sureBlock:^(NSString * successBool){
                if ([successBool boolValue]) {
                    
                    self.viewModel.queryBool = YES;
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view];
                        HXAlertViewController *alertViewController = [HXAlertViewController alertControllerWithTitle:@"" message:@"支付是否完成？" leftTitle:@"否" rightTitle:@"是"];
                        
                        alertViewController.leftAction = ^{
                            [self updatePayResult];
                        };
                        alertViewController.rightAction = ^{
                            [self updatePayResult];
                        };
                        
                        [self presentViewController:alertViewController animated:YES completion:nil];
                    });
                    
                }
            } cancelBlock:^{
                
            }];
            self.payment.controller = self;
        } failBlock:^(NSString * clearBoolStr){
            if ([clearBoolStr boolValue]) {
                [self clearShopProduct];             }
        }];
    }
}
-(void)clearShopProduct {
    HXScorePromptView * promptView = [[HXScorePromptView alloc] initWithName:@"" TitleArr:@[@"部分商品已下架，",@"差一步你就可以拥有我了～"] selectNameArr:@[@"确定"] comBool:NO sureBlock:^{
        [self changeType:@"6"];
    } cancelBlock:^{
    }];
    [promptView showAlert];
    
}
- (void)updatePayResult {
    [self.viewModel querypaymentWithReturnBlock:^{
        [self request];
        if ([self.delegate respondsToSelector:@selector(updateCancelStates:)]) {
            self.viewModel.model.orderStatus = @"0";
            [self.delegate updateCancelStates:self.viewModel.model];
        }
    } failBlock:^{
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

-(void)cancelBtnAction {
    
    HXScorePromptView * promptView = [[HXScorePromptView alloc] initWithName:@"" TitleArr:@[@"真的不要我了么?"] selectNameArr:@[@"不要你了",@"我再想想"]  comBool:YES sureBlock:^{
        
    } cancelBlock:^{
        [self changeType:@"6"];
        
    }];
    [promptView showAlert];
}
-(void)changeType:(NSString *)type {
    [self.viewModel changeRecordStateWithType:type returnBlock:^{
        if ([self.delegate respondsToSelector:@selector(updateCancelStates:)]) {
            [self.delegate updateCancelStates:self.viewModel.model];
        }
        if ([type isEqualToString:@"5"]) {
            [self request];
        }else {
            [self changeStates];
        }
    } failBlock:^{
        
    }];
    
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
