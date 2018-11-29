//
//  HXShoppingCartViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXShoppingCartViewController.h"
#import "HXShoppingCartCell.h"
#import "HXProductLayout.h"
#import "HXProductCollectionViewCell.h"
#import "ComButton.h"
#import "HXShopCarModel.h"
#import "FreezeHintView.h"
#import "HXAddressViewController.h"
#import "FreezeHintView.h"
#import "HXPayView.h"
#import "HXAlertViewController.h"
#import "HXScoreProductDetailViewController.h"
#import "HXRecordDetailViewController.h"
#import "HXWKWebView.h"


@interface HXShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,productDelegate,productCollectDelegate,shopCartDelegate,UIScrollViewDelegate,WebShopDelegate>

@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UICollectionView * productCollectionView;
@property (nonatomic,strong)ComButton * selectAllBtn;
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,strong)UILabel * informationLabel;
@property (nonatomic,strong)UILabel * yfLabel;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UILabel * receiverLabel;
@property (nonatomic,strong)UILabel * receAddressLabel;
@property (nonatomic,strong)UILabel * phoneLabel;
@property (nonatomic,strong)UILabel * addAddressLabel;
@property (nonatomic,strong)UITextField * numberTextField;
@property (nonatomic,strong)HXPaymentView * payment;
@property (nonatomic,strong)HXPayView *payView;
@property (nonatomic,strong)UIButton * addAddressBtn;
@property (nonatomic,strong)UIView * headView;
@property (nonatomic,strong)UILabel * shLabel;

@end

@implementation HXShoppingCartViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXShoppingCartViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    [self hiddeKeyBoard];
//    [self request];
    [self archiveRecommend];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notifierKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notifierKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

}
-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:NO];
    [self request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"AliPaySucceed" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AliPaySucceed" object:nil];
}

- (void)receiveNotification:(NSNotification *)noti {
    HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
    HXRecordModel * model = [[HXRecordModel alloc] init];
    model.orderNo = self.viewModel.orderNo;
    model.id = self.viewModel.orderId;
    detail.viewModel.model = model;
    [self.navigationController pushViewController: detail animated:YES];
}

-(void)request {
        [self.viewModel archiveShopCarInformationWithSuccessBlock:^{
        [self archiveCarriage];
        [self changeAllMoney];
        [self changeHeight:_productCollectionView.frame.size.height];
        [self changeSelctStates];
        [self changeAddress];
        [_tableView reloadData];
    } failBlock:^{
        
    }];
}
-(void)pushDetail {
    HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
    HXRecordModel * model = [[HXRecordModel alloc] init];
    model.orderNo = self.viewModel.orderNo;
    model.id = self.viewModel.orderId;
    detail.viewModel.model = model;
    [self.navigationController pushViewController:detail animated:YES];
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[HXShoppingCartViewController class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
    
}
-(void)archiveRecommend {
    
    [self.viewModel archivewRecommendProduceWithSuccessBlock:^{
        [self changeHeight:_productCollectionView.frame.size.height];
        [_productCollectionView reloadData];
        [self.scrollView.mj_footer endRefreshing];
    } failBlock:^{
        if (self.viewModel.page>1) {
            self.viewModel.page--;
        }
        [self.scrollView.mj_footer endRefreshing];

    }];
    
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"购物车";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
-(void) hiddeKeyBoard{
    
    [self.view endEditing:YES];
    
}
-(void)createUI {
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView  = scrollView;
    self.scrollView.delegate = self;
    _scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = COLOR_BACKGROUND;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
//    _tableView.bounces = NO;
//    _tableView.alwaysBounceHorizontal = YES;
//    _tableView.alwaysBounceVertical = YES;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    [self.scrollView addSubview:_tableView];
    NSInteger height = self.viewModel.shopCartNumberArr.count==0?120:self.viewModel.shopCartNumberArr.count*134+40;
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top);
        make.left.equalTo(self.scrollView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(91+height);
    }];
    [self creatHeadView];
    [self creatProductCollection];
    
    UISwipeGestureRecognizer * recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [_tableView addGestureRecognizer:recognizer];

    
    UIView * bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    self.bottomView.hidden = YES;
    bottomView.backgroundColor = CommonBackViewColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.height.mas_equalTo(50);
        make.left.and.right.mas_equalTo(self.view);
    }];
//    bottomView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    bottomView.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    bottomView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
//    bottomView.layer.shadowRadius = 4;//阴影半径，默认3
    
    UILabel * hjLable = [[UILabel alloc] init];
    hjLable.text = @"合计:";
    hjLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    hjLable.textColor = ComonTextColor;
    [bottomView addSubview:hjLable];
    [hjLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(12);
        make.width.mas_lessThanOrEqualTo(40);
        make.centerY.equalTo(bottomView);
    }];
    
    UILabel * informationLabel = [[UILabel alloc] init];
    self.informationLabel = informationLabel;
    informationLabel.font = [UIFont systemFontOfSize:11];
    informationLabel.textColor = kUIColorFromRGB(0x252525);
    [bottomView addSubview:informationLabel];
    [informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(53);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-188);
        make.centerY.equalTo(bottomView);
    }];
    
    UILabel * yfLabel = [[UILabel alloc] init];
    self.yfLabel = yfLabel;
    yfLabel.hidden = YES;
    yfLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    yfLabel.textColor = kUIColorFromRGB(0xFB585B);
    [bottomView addSubview:yfLabel];
    [yfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView).offset(-5);
        make.right.equalTo(informationLabel.mas_right).offset(0);
    }];
    
    
    UIButton * paymentBtn = [[UIButton alloc] init];
    [paymentBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [paymentBtn addTarget:self action:@selector(paymentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kUIColorFromRGB(0xFA5578).CGColor,(__bridge id)[kUIColorFromRGB(0xFA7B55) colorWithAlphaComponent:1.0].CGColor , (__bridge id)kUIColorFromRGB(0xFA7B55).CGColor];
    gradientLayer.locations = @[@0.3,@0.7, @0.3];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, 130, 50);
    [paymentBtn.layer addSublayer:gradientLayer];
    [paymentBtn setTitleColor:CommonBackViewColor forState:UIControlStateNormal];
    [paymentBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:15]];
    [bottomView addSubview:paymentBtn];
    [paymentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.top.and.bottom.equalTo(bottomView);
        make.width.mas_equalTo(130);
    }];
    
}
-(void)creatHeadView {
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 91)];
    self.headView = headView;
    headView.backgroundColor = CommonBackViewColor;
    _tableView.tableHeaderView = headView;
    
    UIButton * addAddressBtn = [[UIButton alloc] init];
    self.addAddressBtn = addAddressBtn;
    [addAddressBtn addTarget:self action:@selector(addAddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
    addAddressBtn.backgroundColor = CommonBackViewColor;
    [headView addSubview:addAddressBtn];
    [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(headView);
        make.top.equalTo(headView);
        make.height.mas_equalTo(77);
    }];
    
    UIImageView * locationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoplocation"]];
    [addAddressBtn addSubview:locationImage];
    [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addAddressBtn);
        make.left.equalTo(addAddressBtn).offset(12);
    }];
    
    
    UILabel * addAddressLabel = [[UILabel alloc] init];
    self.addAddressLabel = addAddressLabel;
    addAddressLabel.text = @"添加收货地址";
    addAddressLabel.hidden = NO;
    addAddressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    addAddressLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:addAddressLabel];
    [addAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addAddressBtn);
        make.left.equalTo(headView).offset(36);
    }];
    
    UILabel * receiverLabel = [[UILabel alloc] init];
    self.receiverLabel = receiverLabel;
    receiverLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    receiverLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:receiverLabel];
    [receiverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addAddressBtn).offset(36);
        make.top.equalTo(addAddressBtn).offset(17);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-170);
        make.height.mas_equalTo(16);
    }];
    
    UILabel * shLabel = [[UILabel alloc] init];
    self.shLabel = shLabel;
    self.shLabel.hidden = YES;
    shLabel.font = [UIFont systemFontOfSize:12];
    shLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:shLabel];
    [shLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addAddressBtn).offset(36);
        make.top.equalTo(addAddressBtn.mas_top).offset(43);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(12);
    }];
    
    UILabel * receAddressLabel = [[UILabel alloc] init];
    self.receAddressLabel = receAddressLabel;
    receAddressLabel.numberOfLines = 0;
    receAddressLabel.font = [UIFont systemFontOfSize:12];
    receAddressLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:receAddressLabel];
    [receAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shLabel.mas_right).offset(-3);
        make.top.equalTo(shLabel).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-127);
        make.height.mas_equalTo(12);
    }];
    
    UILabel * phoneLabel = [[UILabel alloc] init];
    self.phoneLabel = phoneLabel;
    phoneLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    phoneLabel.textColor = ComonTextColor;
    [addAddressBtn addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addAddressBtn).offset(-63/2);
        make.top.equalTo(addAddressBtn).offset(17);
        make.width.mas_lessThanOrEqualTo(110);
        make.height.mas_equalTo(16);
    }];
    
    
    UIImageView * botImage = [[UIImageView alloc] init];
    botImage.image = [UIImage imageNamed:@"xingzhi"];
    [addAddressBtn addSubview:botImage];
    [botImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addAddressBtn.mas_bottom).offset(0);
        make.left.and.right.equalTo(headView);
        make.height.mas_equalTo(4);
    }];
    //间隙
    UIView * jxView = [[UIView alloc] init];
    jxView.backgroundColor = COLOR_BACKGROUND;
    [headView addSubview:jxView];
    [jxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(botImage.mas_bottom).offset(0);
        make.left.and.right.equalTo(headView);
        make.bottom.equalTo(headView);
        
    }];
    
    UIImageView * arrowView = [[UIImageView alloc] init];
    arrowView.image = [UIImage imageNamed:@"listarrow"];
    [addAddressBtn addSubview:arrowView];
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(addAddressBtn).offset(-12);
        make.centerY.equalTo(addAddressBtn);
    }];
    
}
-(void)handleSwipeFrom:(id)sender {
    _tableView.editing = NO;
    
}
-(void)creatProductCollection {
    HXProductLayout *layout = [HXProductLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(12,_tableView.origin.y+_tableView.frame.size.height, SCREEN_WIDTH-24,0) collectionViewLayout:layout];
    _productCollectionView = collectionView;
    layout.delegate = self;
    collectionView.backgroundColor = kUIColorFromRGB(0xffffff);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = NO;
    [collectionView registerClass:[HXProductCollectionViewCell class] forCellWithReuseIdentifier:@"identifier1"];
    [self.scrollView addSubview:collectionView];
    [_productCollectionView registerClass:[UICollectionViewCell class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader"];
    [_productCollectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collettionSectionFoot"];
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.viewModel.shopCartNumberArr.count!=0 && self.viewModel.stopShopArr.count!=0) {
        return 2;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.viewModel.shopCartNumberArr.count==0 && self.viewModel.stopShopArr.count==0) {
        return 1;
    }else if (self.viewModel.shopCartNumberArr.count!=0&&self.viewModel.stopShopArr.count!=0) {
        if (section==0) {
            return self.viewModel.shopCartNumberArr.count;
        }else {
           return  self.viewModel.stopShopArr.count;
        }
    }else if(self.viewModel.shopCartNumberArr.count!=0&&self.viewModel.stopShopArr.count==0) {
        
        return self.viewModel.shopCartNumberArr.count;
        
    }else if (self.viewModel.shopCartNumberArr.count==0&&self.viewModel.stopShopArr.count!=0) {
        return self.viewModel.stopShopArr.count;
    }else {
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewModel.shopCartNumberArr.count==0&&self.viewModel.stopShopArr.count==0) {
        static NSString *cellIdentity = @"IdentityInfoCell1";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            UILabel * titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            titleLabel.textColor = ComonCharColor;
            titleLabel.text = @"您的购物车是空的";
            [cell.contentView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView.mas_centerX).offset(-30);
            }];
            
            
            UIImageView * photoImage = [[UIImageView alloc] init];
            photoImage.image = [UIImage imageNamed:@"cartsimple2"];
            [cell.contentView addSubview:photoImage];
            [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(titleLabel.mas_left).offset(-16);
            }];
        }
        
        return cell;
    }
    static NSString *cellIdentity = @"IdentityInfoCell";
    HXShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[HXShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell creatLine:0 hidden:NO];
    cell.delegate = self;
    if (self.viewModel.shopCartNumberArr.count!=0 && self.viewModel.stopShopArr.count!=0) {
        if (indexPath.section==0) {
            
            cell.model = [self.viewModel.shopCartNumberArr objectAtIndex:indexPath.row];
        }else {
            cell.model = [self.viewModel.stopShopArr objectAtIndex:indexPath.row];
        }
    }else if (self.viewModel.shopCartNumberArr.count!=0 && self.viewModel.stopShopArr.count==0) {
        cell.model = [self.viewModel.shopCartNumberArr objectAtIndex:indexPath.row];
        
    }else if (self.viewModel.shopCartNumberArr.count==0 && self.viewModel.stopShopArr!=0) {
        cell.model = [self.viewModel.stopShopArr objectAtIndex:indexPath.row];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 134;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.viewModel.shopCartNumberArr.count && self.viewModel.stopShopArr.count!=0) {
        return 10;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return self.viewModel.shopCartNumberArr.count==0&&self.viewModel.stopShopArr.count==0?0:40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.viewModel.shopCartNumberArr.count!=0 &&section==0) {
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,40)];
        headView.backgroundColor = CommonBackViewColor;
        
        ComButton * selectAllBtn = [[ComButton alloc] init];
        self.selectAllBtn = selectAllBtn;
        [selectAllBtn addTarget:self action:@selector(selectAllBtnAction) forControlEvents:UIControlEventTouchUpInside];
        selectAllBtn.photoImage.image = [UIImage imageNamed:self.viewModel.selectAllBool?@"select":@"unselected"];
        [headView addSubview:selectAllBtn];
        [selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView);
            make.top.and.bottom.equalTo(headView);
            make.width.mas_equalTo(44);
        }];
        [selectAllBtn.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView).offset(15);
            make.centerY.equalTo(headView);
        }];
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        titleLabel.textColor = ComonTextColor;
        titleLabel.text = @"全部";
        [headView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headView);
            make.left.equalTo(headView).offset(44);
        }];
        
        
        UILabel * freightLabel = [[UILabel alloc] init];
        freightLabel.text = [NSString stringWithFormat:@"运费%@元",[NumAgent roundDown:self.viewModel.carriage ifKeep:YES]];
        if ([self.viewModel.carriage doubleValue]<=0.00) {
            freightLabel.text = @"已免运费";
        }else {
            freightLabel.hidden = NO;
        }
        BOOL selectAllBool = NO;
        for (HXShopCarModel * model in self.viewModel.shopCartNumberArr) {
            if (model.selectedBool==YES) {
                selectAllBool = YES;
                break;
            }
        }
        if (selectAllBool) {
            freightLabel.hidden =NO;
        }else {
            freightLabel.hidden = YES;
        }
        
        freightLabel.textColor = kUIColorFromRGB(0xFB585B );
        freightLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        [headView addSubview: freightLabel];
        [freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headView).offset(-12);
            make.centerY.equalTo(headView);
            make.width.mas_lessThanOrEqualTo(150);
        }];
        
        UIView * bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = kUIColorFromRGB(0xE5E5E5);
        [headView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(headView);
            make.left.equalTo(headView).offset(0);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        return headView;
    }
    
    if (self.viewModel.stopShopArr.count!=0) {
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,40)];
        headView.backgroundColor = kUIColorFromRGB(0xFAFAFA);
        
        UILabel * nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textColor = ComonTitleColor;
        nameLabel.text =@"商品下架或无库存";
        [headView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headView);
            make.left.equalTo(headView).offset(12);
        }];
        
        UIView * bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = kUIColorFromRGB(0xE5E5E5);
        [headView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(headView);
            make.left.equalTo(headView).offset(0);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        return headView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModel.shopCartNumberArr.count==0&&self.viewModel.stopShopArr.count==0) {
        return NO;
    }
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self removeShopCarContentWithIndex:indexPath];

}
-(void)removeShopCarContentWithIndex:(NSIndexPath *)indexPath{
    HXScorePromptView * promptView = [[HXScorePromptView alloc] initWithName:@"" TitleArr:@[@"听说删除是因为在意",@"你确定不再考虑一下吗？"] selectNameArr:@[@"去意已决",@"我再想想"]  comBool:YES sureBlock:^{
    
        self.tableView.editing = NO;
        
    } cancelBlock:^{
        HXShopCarModel * model;
        BOOL firstDelegate = NO;
        if (indexPath.section==0) {
            model = self.viewModel.shopCartNumberArr.count!=0?[self.viewModel.shopCartNumberArr objectAtIndex:indexPath.row]:[self.viewModel.stopShopArr objectAtIndex:indexPath.row];
            if (self.viewModel.shopCartNumberArr.count==0) {
                firstDelegate = YES;
            }
        }else if(indexPath.section==1){
            firstDelegate = YES;
            model = [self.viewModel.stopShopArr objectAtIndex:indexPath.row];
        }else {
            
            return;
        }
        
        [self.viewModel removeShopCartInformationWithModel:model returnBlock:^{
            if (firstDelegate) {
                [self.viewModel.stopShopArr removeObjectAtIndex:indexPath.row];
            }else {
                [self.viewModel.shopCartNumberArr removeObjectAtIndex:indexPath.row];
                [self archiveCarriage];
                [self changeAllMoney];
            }
            self.bottomView.hidden = self.viewModel.shopCartNumberArr.count==0&&self.viewModel.stopShopArr.count==0?YES:NO;
            [self changeSelctStates];
            [self changeHeight:_productCollectionView.frame.size.height];
            [_tableView reloadData];
            
        }];
    }];
    [promptView showAlert];
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProductCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier1" forIndexPath:indexPath];
    cell.delegate = self;
    cell.contentView.layer.borderWidth = 0.5;
    cell.shoopBool = YES;
    cell.model = [self.viewModel.recomendArr objectAtIndex:indexPath.row];
    cell.contentView.layer.borderColor = kUIColorFromRGB(0xE6E6E6).CGColor;
    return cell;
    
}
    //设置sectionHeader | sectionFoot
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:_productCollectionView]) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView* view = [_productCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collettionSectionHeader" forIndexPath:indexPath];
            UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
            backView.backgroundColor = COLOR_BACKGROUND;
            [view addSubview:backView];
            
            UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tuijian"]];
            [backView addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.and.centerY.equalTo(backView);
            }];
            
            return view;
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            UICollectionReusableView* view = [_productCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collettionSectionFoot" forIndexPath:indexPath];
            
            return view;
        }else{
            return nil;
        }
    
    }
    return nil;
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
-(void)selectAllBtnAction {
    self.viewModel.selectAllBool  = !self.viewModel.selectAllBool;
    self.selectAllBtn.photoImage.image = [UIImage imageNamed:self.viewModel.selectAllBool?@"select":@"unselected"];
    for (HXShopCarModel * shopModel in self.viewModel.shopCartNumberArr) {
        shopModel.selectedBool = self.viewModel.selectAllBool;
    }
    self.viewModel.integration = 0.00;
    self.viewModel.money = @"0.00";
    self.viewModel.carriage = @"0.00";
    if (self.viewModel.selectAllBool) {
       
    }else {
        self.viewModel.integration = 0.00;
        self.viewModel.money = @"0.00";
        self.viewModel.carriage = @"0.00";
        
    }
    [self archiveCarriage];
    [self changeAllMoney];
    [_tableView reloadData];
}
#pragma mark -- productCollectDelegate
-(void)changeShopCart:(HXShopCarModel *)model {
    if ([model.stock intValue]==0) {
        [KeyWindow displayMessage:@"你来晚了， 我已经被掏空了!"];
        return;
    }
    for (HXShopCarModel * shopModel in self.viewModel.shopCartNumberArr) {
        if ([model.skuId isEqualToString:shopModel.skuId]) {
            int number = [shopModel.proNum intValue];
            number++;
            if ([shopModel.proNum intValue] < [shopModel.stock intValue]) {
                
                [self changeProduceShopCart:shopModel addBool:YES];
                return;
            }else {
                [KeyWindow displayMessage:@"当前产品库存不足"];
            }
            return;
        }
    }
    
    __weak typeof(self) weakSelf = self;
    [self.viewModel addShopCarNumberWithModel:model returnBlock:^{
        model.selectedBool = YES;
        model.proOnshelfStatus = @"1";
        model.proNum = @"1";
        [weakSelf.viewModel.shopCartNumberArr addObject:model];
        [weakSelf changeSelctStates];
        [weakSelf changeHeight:weakSelf.productCollectionView.frame.size.height];

       [weakSelf archiveCarriage];
        [weakSelf changeAllMoney];
        [weakSelf.tableView reloadData];
        
    } failBlock:^{
        
    }];
    
}
-(void)updateHeight:(NSInteger)height {
    [self changeHeight:height];
}
-(void)changeHeight:(NSInteger)cellHeight {
    NSInteger tabHeight = 120;
    if (self.viewModel.shopCartNumberArr.count==0 && self.viewModel.stopShopArr.count==0) {
        tabHeight = 120;
    }else if (self.viewModel.shopCartNumberArr.count!=0&&self.viewModel.stopShopArr.count!=0){
        
        tabHeight = self.viewModel.shopCartNumberArr.count*134 + 40*2 + self.viewModel.stopShopArr.count*134 + 10;
    }else if(self.viewModel.shopCartNumberArr.count!=0&&self.viewModel.stopShopArr.count==0){
        
        tabHeight = self.viewModel.shopCartNumberArr.count*134+40;
    }else if(self.viewModel.shopCartNumberArr.count==0&&self.viewModel.stopShopArr.count!=0) {
        tabHeight = self.viewModel.stopShopArr.count*134+40;
    }
    
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.headView.frame.size.height+tabHeight);
    }];
    
    NSInteger height = tabHeight;
    NSInteger bottomHeight = self.viewModel.shopCartNumberArr.count!=0||self.viewModel.stopShopArr.count!=0?50:0;
    self.bottomView.hidden = self.viewModel.shopCartNumberArr.count==0&&self.viewModel.stopShopArr.count==0?YES:NO;
    if (bottomHeight==50) {
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-50);
        }];
    }else {
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(0);
        }];
    }
    [_productCollectionView setFrame:CGRectMake(0,self.headView.frame.size.height+height, SCREEN_WIDTH,cellHeight)];
    if (cellHeight==0) {
       [self.scrollView setContentSize:CGSizeMake(0,self.headView.frame.size.height+height+cellHeight)];
    }else {
    [self.scrollView setContentSize:CGSizeMake(0,self.headView.frame.size.height+height+cellHeight)];
    }
}

#pragma mark -- 全部选择状态
-(void)changeSelctStates {
    BOOL selectAllBool = YES;
    for (HXShopCarModel * model in self.viewModel.shopCartNumberArr) {
        if (model.selectedBool==NO) {
            selectAllBool = NO;
            break;
        }
    }
    
    if (selectAllBool) {
        self.viewModel.selectAllBool = YES;
    }else {
        self.viewModel.selectAllBool = NO;
    }
    self.selectAllBtn.photoImage.image = [UIImage imageNamed:self.viewModel.selectAllBool?@"select":@"unselected"];
}

#pragma mark -- shopCartDelegate
-(void)changeProduceShopCart:(HXShopCarModel *)model addBool:(BOOL)addBool {
    [self.viewModel changeShopCarNumberWithAddBool:addBool model:model returnBlock:^{
        if (addBool) {
            if (!model.selectedBool) {
                model.selectedBool = YES;
            }
        }else {
            model.selectedBool = YES;
        }
        [self archiveCarriage];
        [self changeAllMoney];
        [self archiveCarriage];
        [self changeSelctStates];
        [_tableView reloadData];
    } failBlock:^{
        
    }];
}

/**
 修改全部金额 积分
 */
-(void)changeAllMoney {
    NSInteger fontNumber = SCREEN_WIDTH<=320?12:16;
    self.viewModel.integration = 0.00;
    self.viewModel.money = @"0.00";
    self.viewModel.money =[NumAgent roundDown:[NSString stringWithFormat:@"%@",SNAdd(self.viewModel.money, self.viewModel.carriage)] ifKeep:YES];
    NSDecimalNumber * money = [[NSDecimalNumber alloc] initWithString:self.viewModel.money];
    for (HXShopCarModel * model in self.viewModel.shopCartNumberArr) {
        if (model.selectedBool) {
            
            money =  SNAdd_handler(money, SNMul(model.price, model.proNum), NSRoundDown, 2);
            self.viewModel.integration = self.viewModel.integration + [model.score doubleValue]*[model.proNum intValue];
        }
    }
    self.viewModel.money = [NumAgent roundDown:[NSString stringWithFormat:@"%@",money] ifKeep:YES];
    
    self.informationLabel.text = [NSString stringWithFormat:@"%.f趣贝+%@元",self.viewModel.integration,self.viewModel.money];
    [Helper changeTextWithFont:fontNumber title:self.informationLabel.text changeTextArr:@[[NSString stringWithFormat:@"%.f",self.viewModel.integration],[NSString stringWithFormat:@"%@",self.viewModel.money]] label:self.informationLabel color:ComonBackColor];
    if ([self.viewModel.carriage doubleValue]>0.00) {
        self.yfLabel.hidden  = NO;
        [self.informationLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(53);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-188);
            make.top.equalTo(_bottomView).offset(11);
        }];
        self.yfLabel.text = [NSString stringWithFormat:@"(含运费：%@元)",[NumAgent roundDown:self.viewModel.carriage ifKeep:YES]];
    }else {
        
        self.yfLabel.hidden = YES;
        [self.informationLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(53);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-188);
            make.centerY.equalTo(self.bottomView);
        }];
        
    }
}

-(void)selectProcut:(HXShopCarModel *)model {
    [self archiveCarriage];
    [self changeAllMoney];
    [self changeSelctStates];
    [_tableView reloadData];
    
}

/**
 获取购物车的运费
 */
-(void)archiveCarriage {
    self.viewModel.carriage = @"0.00";
    for (HXShopCarModel * model in self.viewModel.shopCartNumberArr) {
        if (model.selectedBool) {
            self.viewModel.carriage = [self.viewModel.carriage doubleValue]>=[model.shippingExpense doubleValue]?self.viewModel.carriage:model.shippingExpense;
        }
    }
}

-(NSDecimalNumber *)decimalNumber:(double)num {
    NSString *numString = [NSString stringWithFormat:@"%.2lf", num];
    return [NSDecimalNumber decimalNumberWithString:numString];
}

-(void)paymentBtnAction {
    BOOL shopDataBool = NO;
    for (HXShopCarModel * model in self.viewModel.shopCartNumberArr) {
        if (model.selectedBool && [model.stock intValue]!=0) {
            if ([model.proNum intValue]<=[model.stock intValue]) {
                
                shopDataBool = YES;
            }else {
                [KeyWindow displayMessage:@"购物车产品库存不足无法下单"];
                return;
            }
        }
        if([model.proNum intValue]==0 && model.selectedBool) {
            [KeyWindow displayMessage:@"购买商品数量不能为0"];
            return;
        }
        if (model.selectedBool) {
            if ([model.proNum intValue]>[model.stock intValue]) {
                
                [KeyWindow displayMessage:@"购物车产品库存不足无法下单"];
                return;
            }
        }
    }
    if (!shopDataBool) {
        [KeyWindow displayMessage:@"请选择购买的商品"];
        return;
    }
    if (self.viewModel.addressModel.receiver.length==0) {
        [KeyWindow displayMessage:@"请添加收货地址"];
        return;
    }
    if (self.viewModel.addressModel.address.length==0) {
        [KeyWindow displayMessage:@"请添加收货地址"];
        return;
    }
    if (self.viewModel.addressModel.phone.length==0) {
        [KeyWindow displayMessage:@"请添加收货地址"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.viewModel placeOrderWithReturnBlock:^(ResponseModel *object){
        __strong __typeof (weakSelf) sself = weakSelf;
        NSString * totalAmount = [object.body objectForKey:@"totalAmount"];
        NSString * orderNo = [[object.body objectForKey:@"orderNo"] stringValue];
        NSString * orderId = [[object.body objectForKey:@"orderId"] stringValue];
        totalAmount = totalAmount.length!=0?totalAmount:@"";
        orderNo = orderNo.length!=0?orderNo:@"";
        sself.viewModel.orderNo = orderNo;
        sself.viewModel.orderId = orderId;
        
        if ([sself.viewModel.money doubleValue]==0.00) {
            HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
            HXRecordModel * model = [[HXRecordModel alloc] init];
            model.orderNo = orderNo;
            model.id = orderId.length!=0?orderId:@"";
            model.orderStatus = @"2";
            detail.viewModel.model = model;
            [self.navigationController pushViewController:detail animated:YES];
            NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in marr) {
                if ([vc isKindOfClass:[HXShoppingCartViewController class]]) {
                    [marr removeObject:vc];
                    break;
                }
            }
            self.navigationController.viewControllers = marr;
            return ;
        }
    

    sself.payment = [[HXPaymentView alloc] initWithOrderNo:orderNo sureBlock:^(NSString * successBool){
        if ([successBool boolValue]) {
            
            sself.viewModel.queryBool = YES;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];
                HXAlertViewController *alertViewController = [HXAlertViewController alertControllerWithTitle:@"" message:@"支付是否完成？" leftTitle:@"否" rightTitle:@"是"];
                
                alertViewController.leftAction = ^{
                    [sself updatePayResult];
                };
                alertViewController.rightAction = ^{
                    [sself updatePayResult];
                };
                
                [self presentViewController:alertViewController animated:YES completion:nil];
            });
            
            
        }else {
            
            [self pushDetail];
        }
       
        } cancelBlock:^{
            [self pushDetail];
        }];
        sself.payment.controller = self;
        
    } failBlock:^(ResponseNewModel * object){
        if (object) {
            if ([object.status isEqualToString:@"0511"]) {
                NSString * score = [NSString stringWithFormat:@"%d",[[object.body objectForKey:@"currentScore"] intValue]];
                score = score.length!=0?score:@"0";
                HXScorePromptView* promptView = [[HXScorePromptView alloc] initWithName:[NSString stringWithFormat:@"可用趣贝：%@",score] TitleArr:@[@"趣贝不足，快去赚趣贝吧！",@"用趣贝，去变美！"] selectNameArr:@[@"确定"] comBool:NO sureBlock:^{
                    
                } cancelBlock:^{
                    
                }];
                [promptView showAlert];
                [Helper changeTextWithFont:18 title:promptView.titleLabel.text changeTextArr:@[score] label:promptView.titleLabel color:ComonBackColor];
            }else if ([object.status isEqualToString:@"0512"]) {
                [self request];
            }else if ([object.status isEqualToString:@"0513"]) {
                [self request];
            }
        }
    }];
}

- (void)updatePayResult {
    __weak typeof(self) weakSelf = self;
    [self.viewModel querypaymentWithReturnBlock:^{
        __strong __typeof (weakSelf) sself = weakSelf;
        [sself pushDetail];
    } failBlock:^{
        __strong __typeof (weakSelf) sself = weakSelf;
        [sself pushDetail];
    }];
}

-(void)addAddressBtnAction {
    HXAddressViewController * addressView = [[HXAddressViewController alloc] init];
    if (self.viewModel.addressModel) {
        addressView.url = [NSString stringWithFormat:@"%@address/%@",kScoreUrl,self.viewModel.addressModel.id];
    } else {
        addressView.url = [NSString stringWithFormat:@"%@address",kScoreUrl];
    }
    addressView.returnAddress = ^(HXShopAddressModel * model){
        self.viewModel.addressModel = model;
        [self changeAddress];
    };
    [self.navigationController pushViewController:addressView animated:YES];
}
-(void)changeAddress {
    if (self.viewModel.addressModel.receiver.length!=0 || self.viewModel.addressModel.address.length!=0 || self.viewModel.addressModel.phone.length!=0) {
        self.addAddressLabel.hidden = YES;
        self.receiverLabel.hidden = NO;
        self.receAddressLabel.hidden = NO;
        self.shLabel.hidden = NO;
        self.phoneLabel.hidden = NO;
        NSString * address = [NSString stringWithFormat:@"%@%@%@%@",self.viewModel.addressModel.provinceName.length!=0?self.viewModel.addressModel.provinceName:@"",self.viewModel.addressModel.cityName.length!=0?self.viewModel.addressModel.cityName:@"",self.viewModel.addressModel.areaName.length!=0?self.viewModel.addressModel.areaName:@"",self.viewModel.addressModel.address.length!=0?self.viewModel.addressModel.address:@""];
        self.shLabel.text = @"收货地址：";
        self.viewModel.addressModel.address = address;
        self.receAddressLabel.text = [NSString stringWithFormat:@"%@",address];
        CGFloat height = [Helper heightOfString:self.receAddressLabel.text font:[UIFont systemFontOfSize:12] width:SCREEN_WIDTH-127];
        if (height>20) {
            [self.receAddressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            [self.addAddressBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(43+height+15);
            }];
            self.headView.frame = CGRectMake(0, 0,SCREEN_WIDTH , 43+height+15+14);
        }else {
            [self.receAddressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(12);
            }];
            [self.addAddressBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(77);
            }];
            self.headView.frame = CGRectMake(0, 0,SCREEN_WIDTH , 91);
        }
        
        self.receiverLabel.text = [NSString stringWithFormat:@"收货人: %@",self.viewModel.addressModel.receiver.length!=0?self.viewModel.addressModel.receiver:@""];
        self.phoneLabel.text = self.viewModel.addressModel.phone.length!=0?self.viewModel.addressModel.phone:@"";
//        NSString *numberString ;
//        if (self.viewModel.addressModel.phone.length !=0) {
//            numberString =  [self.viewModel.addressModel.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//            self.phoneLabel.text = numberString;
//        }
    }else {
        self.receiverLabel.hidden = YES;
        self.receAddressLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
        self.shLabel.hidden = YES;
        self.addAddressLabel.hidden = NO;
        [self.receAddressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(12);
        }];
        [self.addAddressBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(77);
        }];
        self.headView.frame = CGRectMake(0, 0,SCREEN_WIDTH , 91);
    }
    _tableView.tableHeaderView = self.headView;
    [self changeHeight:_productCollectionView.frame.size.height];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:_productCollectionView]) {
        HXShopCarModel * model = [self.viewModel.recomendArr objectAtIndex:indexPath.row];
        
        HXScoreProductDetailViewController *controller = [[HXScoreProductDetailViewController alloc] init];
        controller.webShopDelegate = self;
        controller.title = @"商品详情";
        NSString * url  = [NSString stringWithFormat:@"%@goods/%@/%@",kScoreUrl,model.id,K_CURRENT_TIMESTAMP];
        controller.url = url;
        controller.isTransparente = NO;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (void) notifierKeyboardWillShow:(NSNotification*)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect oldframe = [self.numberTextField convertRect:self.numberTextField.bounds toView:[UIApplication sharedApplication].keyWindow];
    float height = SCREEN_HEIGHT-oldframe.size.height-oldframe.origin.y-keyboardRect.size.height-15;
    if (height<0) {
        CGPoint scrollPoint = CGPointMake(0.0,_scrollView.contentOffset.y+ -height);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}

- (void) notifierKeyboardWillHide:(NSNotification*)notification {
    
    
}

-(void)changeTextField:(UITextField *)textField {
    self.numberTextField = textField;
    
}
-(void)updateNewNumber:(UITextField *)textField model:(HXShopCarModel *)model index:(NSIndexPath *)indexPath{
    if ([textField.text intValue]==0) {
        [self.view endEditing:YES];
        [self removeShopCarContentWithIndex:indexPath];
        return;
    }
    NSInteger lastNumber = [model.proNum intValue];
    if ([textField.text intValue]==lastNumber) {
        [self.view endEditing:YES];
        return;
    }
    [self.viewModel updateShopCarNumberWithModel:model number:[textField.text intValue]  returnBlock:^{
        if (model.selectedBool) {
        }else {
            model.selectedBool = YES;
        }
        [self archiveCarriage];
        [self changeAllMoney];
        [self changeSelctStates];
        [_tableView reloadData];
    } failBlock:^{
        [self.view endEditing:YES];
    }];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if ([scrollView isEqual:_tableView]) {
//        CGFloat offY = scrollView.contentOffset.y;
//        if (offY != 0) {
//            scrollView.contentOffset = CGPointZero;
////            self.scrollView.contentOffset = CGPointMake(0,offY);
//        }
//    }
//}
//#pragma mark -- WebViewDelegate
-(void)refreshShopCar {
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    [self request];
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
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
