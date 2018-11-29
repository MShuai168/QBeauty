//
//  HXRecordViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/21.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRecordViewController.h"
#import "HXRecordTableViewCell.h"
#import "HXRecordDetailViewController.h"
#import "FreezeHintView.h"
#import "HXShoppingCartViewController.h"
#import "HXScoreHomeViewController.h"
#import "HXPayView.h"
#import "HXAlertViewController.h"

#define  BtnTag 500
#define TableViewTag 1000
@interface HXRecordViewController ()<UITableViewDelegate,UITableViewDataSource,RecordDelegate,RecordDetailDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIView * selectLine;//红线
@property (nonatomic,strong)UITableView * dfkTableView;
@property (nonatomic,strong)UITableView * dskTableView;
@property (nonatomic,strong)UITableView * haveSuccessTableView;
@property (nonatomic,strong)UITableView * haveCancelTabelView;
@property (nonatomic,strong)NSMutableArray * tableViewArr;
@property (nonatomic,strong)UIView * headView;
@property (nonatomic,assign)BOOL dshRefresh;
@property (nonatomic,assign)BOOL dfkRefresh;
@property (nonatomic,strong)HXPaymentView * payment;
@property (nonatomic,strong)HXPayView *payView;

@end

@implementation HXRecordViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXRecordViewModel alloc] initWithController:self];
        self.dshRefresh = NO;
        self.dfkRefresh = NO;
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
    [self request:@""];
    [self request:@"1"];
    [self request:@"2"];
    [self request:@"5"];
    [self request:@"6"];
    if (self.viewModel.selectIndex==1) {
        self.dfkRefresh = YES;
        UIButton * btn = (UIButton *)[self.view viewWithTag:BtnTag+1];
        [self selectBtnAction:btn];
    }
    if (self.viewModel.selectIndex==2) {
        self.dshRefresh = YES;
        UIButton * btn = (UIButton *)[self.view viewWithTag:BtnTag+2];
        [self selectBtnAction:btn];
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"AliPaySucceed" object:nil];
    
    [self hiddenNavgationBarLine:NO];
//    if (self.viewModel.queryBool) {
//        self.viewModel.queryBool = NO;
//        [self.viewModel querypaymentWithReturnBlock:^{
//            HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
//            detail.viewModel.model = self.viewModel.model;
//            detail.delegate = self;
//            [self.navigationController pushViewController: detail animated:YES];
//        } failBlock:^{
//            HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
//            detail.viewModel.model = self.viewModel.model;
//            detail.delegate = self;
//            [self.navigationController pushViewController: detail animated:YES];
//        }];
//    }
}
-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AliPaySucceed" object:nil];
}

- (void)receiveNotification:(NSNotification *)noti {
    HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
    detail.viewModel.model = self.viewModel.model;
    detail.delegate = self;
    [self.navigationController pushViewController: detail animated:YES];
}

/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.title = @"兑换记录";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
-(void) hiddeKeyBoard{
    [self.view endEditing:YES];
}

-(void)createUI {
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.headView = headView;
    [self.view addSubview:headView];
    headView.backgroundColor = CommonBackViewColor;
    NSArray * nameArr = @[@"全部",@"待付款",@"待收货",@"已完成",@"已取消"];
    for (int i = 0 ; i<5 ; i++) {
        UIButton * selectBtn = [[UIButton alloc] init];
        [selectBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
        [selectBtn setTitle:[nameArr objectAtIndex:i] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        selectBtn.tag = i+BtnTag;
        [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [headView addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView).offset(SCREEN_WIDTH/5*i);
            make.top.and.bottom.equalTo(headView);
            make.width.mas_equalTo(SCREEN_WIDTH/5);
        }];
        if (i==0) {
            UIView * selectLine = [[UIView alloc] init];
            self.selectLine = selectLine;
            selectLine.backgroundColor = ComonBackColor;
            [headView addSubview:selectLine];
            [selectLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(selectBtn);
                make.bottom.equalTo(headView);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(2);
            }];
            [selectBtn setTitleColor:ComonBackColor forState:UIControlStateNormal];
        }
    }
    for (int i = 0; i<5; i++) {
        
        /**
         *  tableView
         */
        UITableView *  tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.tag = i+TableViewTag;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
        //上拉刷新
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
        tableView.dataSource = self;
        tableView.hidden = YES;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tableView];
        [tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(40);
            make.left.equalTo(self.view).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
        }];
        [self.tableViewArr addObject:tableView];
        if (i==0) {
            tableView.hidden = NO;
            self.tableView = tableView;
        }else if (i==1) {
            self.dfkTableView = tableView;
        }else if (i==2) {
            self.dskTableView = tableView;
        }else if (i==3) {
            self.haveSuccessTableView = tableView;
        }else {
            self.haveCancelTabelView = tableView;
        }
    }
}
#pragma mark -- request
-(void)request:(NSString *)type {
    [self.viewModel archiveRecodDataType:type returnBlock:^{
        if (type.length==0) {
            [self detailTableView:self.tableView type:7 scoreBool:self.viewModel.allDataArr.count==0?NO:YES kindType:type];
            [self.tableView reloadData];
            if (!self.dshRefresh&&!self.dfkRefresh) {
                
                [MBProgressHUD hideHUDForView:self.view];
            }
        }else if ([type isEqualToString:@"1"]) {
             [self detailTableView:self.dfkTableView type:7 scoreBool:self.viewModel.dfKDataArr.count==0?NO:YES kindType:type];
            [self.dfkTableView reloadData];
        }else if ([type isEqualToString:@"2"]) {
             [self detailTableView:self.dskTableView type:7 scoreBool:self.viewModel.dshDataArr.count==0?NO:YES kindType:type];
            [self.dskTableView reloadData];
        }else if ([type isEqualToString:@"5"]) {
            if (self.dshRefresh) {
                [MBProgressHUD hideHUDForView:self.view];
                self.dshRefresh = NO;
            }
             [self detailTableView:self.haveSuccessTableView type:7 scoreBool:self.viewModel.haveSuccessDataArr.count==0?NO:YES kindType:type];
            [self.haveSuccessTableView reloadData];
        }else {
            if (self.dfkRefresh) {
                [MBProgressHUD hideHUDForView:self.view];
                self.dfkRefresh = NO;
            }
             [self detailTableView:self.haveCancelTabelView type:7 scoreBool:self.viewModel.haveCancelDataArr.count==0?NO:YES kindType:type];
            [self.haveCancelTabelView reloadData];
        }
        if (self.viewModel.openHdBool) {
            [MBProgressHUD hideHUDForView:self.view];
            self.viewModel.openHdBool = NO;
        }
    } failBlock:^{
        if (type.length==0) {
            if (!self.dshRefresh && !self.dfkRefresh) {
                
                [MBProgressHUD hideHUDForView:self.view];
            }
            [self detailTableView:self.tableView type:0 scoreBool:self.viewModel.allDataArr.count==0?NO:YES kindType:type];
        }else if ([type isEqualToString:@"1"]) {
            [self detailTableView:self.dfkTableView type:0 scoreBool:self.viewModel.dfKDataArr.count==0?NO:YES kindType:type];
        }else if ([type isEqualToString:@"2"]) {
            [self detailTableView:self.dskTableView type:0 scoreBool:self.viewModel.dshDataArr.count==0?NO:YES kindType:type];
        }else if ([type isEqualToString:@"5"]) {
            if (self.dshRefresh) {
                [MBProgressHUD hideHUDForView:self.view];
                self.dshRefresh = NO;
            }
            [self detailTableView:self.haveSuccessTableView type:0 scoreBool:self.viewModel.haveSuccessDataArr.count==0?NO:YES kindType:type];
        }else {
            if (self.dfkRefresh) {
                [MBProgressHUD hideHUDForView:self.view];
                self.dfkRefresh = NO;
            }
            [self detailTableView:_haveCancelTabelView type:0 scoreBool:self.viewModel.haveCancelDataArr.count==0?NO:YES kindType:type];
        }
        if (self.viewModel.openHdBool) {
            [MBProgressHUD hideHUDForView:self.view];
            self.viewModel.openHdBool = NO;
        }
    }];
}
-(void)detailTableView:(UITableView *)tableView type:(NSInteger)type scoreBool:(BOOL)scoreBool kindType:(NSString *)kindType{
    tableView.scrollEnabled = scoreBool;
    [self.viewModel showItemView:tableView type:scoreBool?500:type kindType:kindType];
    [self stopBeatyRefresh:tableView];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == TableViewTag) {
        return self.viewModel.allDataArr.count;
        
    }else if (tableView.tag == TableViewTag+1) {
        return self.viewModel.dfKDataArr.count;
    }else if (tableView.tag == TableViewTag+2) {
        return self.viewModel.dshDataArr.count;
    }else if (tableView.tag == TableViewTag+3) {
        return self.viewModel.haveSuccessDataArr.count;
    }else {
        return self.viewModel.haveCancelDataArr.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == TableViewTag) {
        
        static NSString *cellIdentity = @"IdentityInfoCell";
        HXRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        cell.delegate = self;
        cell.model = [self.viewModel.allDataArr objectAtIndex:indexPath.section];
        return cell;
    }else if (tableView.tag == TableViewTag+1) {
        
        static NSString *cellIdentity = @"IdentityInfoCell1";
        HXRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        cell.delegate = self;
        cell.model = [self.viewModel.dfKDataArr objectAtIndex:indexPath.section];
        return cell;
        
        
    }else if (tableView.tag == TableViewTag+2) {
        
        static NSString *cellIdentity = @"IdentityInfoCell2";
        HXRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        cell.delegate = self;
        cell.model = [self.viewModel.dshDataArr objectAtIndex:indexPath.section];
        return cell;
        
        
    }else if (tableView.tag == TableViewTag+3) {
        static NSString *cellIdentity = @"IdentityInfoCell3";
        HXRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        cell.delegate = self;
        cell.model = [self.viewModel.haveSuccessDataArr objectAtIndex:indexPath.section];
        return cell;

    }else {
        static NSString *cellIdentity = @"IdentityInfoCell4";
        HXRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        cell.delegate = self;
        cell.model = [self.viewModel.haveCancelDataArr objectAtIndex:indexPath.section];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 176;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HXRecordModel * model;
    if ([tableView isEqual:_tableView]) {
        model = [self.viewModel.allDataArr objectAtIndex:indexPath.section];
    }else if ([tableView isEqual:_dfkTableView]){
        model = [self.viewModel.dfKDataArr objectAtIndex:indexPath.section];
    }else if ([tableView isEqual:_dskTableView]){
        model = [self.viewModel.dshDataArr objectAtIndex:indexPath.section];
    }else if ([tableView isEqual:_haveSuccessTableView]){
        model = [self.viewModel.haveSuccessDataArr objectAtIndex:indexPath.section];
    }else {
        model = [self.viewModel.haveCancelDataArr objectAtIndex:indexPath.section];
    }
    HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
    detail.viewModel.model = model;
    detail.delegate = self;
    [self.navigationController pushViewController: detail animated:YES];
}

-(void)selectBtnAction:(UIButton *)button {
    [button setTitleColor:ComonBackColor forState:UIControlStateNormal];
    [self.selectLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.bottom.equalTo(self.headView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(2);
    }];
    for (int i = 0; i<5; i++) {
        UITableView * tableView =  [self.tableViewArr objectAtIndex:i];
        tableView.hidden = YES;
        if (i+BtnTag == button.tag) {
            tableView.hidden = NO;
            [tableView reloadData];
            continue;
        }
        UIButton * btn = (UIButton *)[self.view viewWithTag:i+BtnTag];
        [btn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
    }
    
}

-(void)loadNewTopic:(UITableView*)tableView {
    [self archiveModel:NO tableView:tableView];
}
-(void)loadMoreTopic:(UITableView*)tableView {
    [self archiveModel:YES tableView:tableView];
}
-(void)archiveModel:(BOOL)moreBool tableView:(UITableView *)tableView {
    if ([tableView isEqual:_tableView.mj_header] || [tableView isEqual:_tableView.mj_footer]) {
        self.viewModel.allPage = moreBool?self.viewModel.allPage+1:1;
        [self request:@""];
    }
    if ([tableView isEqual:_dfkTableView.mj_header] || [tableView isEqual:_dfkTableView.mj_footer]) {
         self.viewModel.dfkPage = moreBool?self.viewModel.dfkPage+1:1;
        [self request:@"1"];
    }
    if ([tableView isEqual:_dskTableView.mj_header] || [tableView isEqual:_dskTableView.mj_footer]) {
         self.viewModel.dshPage = moreBool?self.viewModel.dshPage+1:1;
        [self request:@"2"];
    }
    
    if ([tableView isEqual:_haveSuccessTableView.mj_header] || [tableView isEqual:_haveSuccessTableView.mj_footer]) {
         self.viewModel.suceessPage = moreBool?self.viewModel.suceessPage+1:1;
        [self request:@"5"];
    }
    if ([tableView isEqual:_haveCancelTabelView.mj_header] || [tableView isEqual:_haveCancelTabelView.mj_footer]) {
         self.viewModel.canPage = moreBool?self.viewModel.canPage+1:1;
        [self request:@"6"];
    }
}
-(void)stopBeatyRefresh:(UITableView *)tableView {
    if ([tableView isEqual:_tableView]) {
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    
    if ([tableView isEqual:_dfkTableView]) {
        [_dfkTableView.mj_header endRefreshing];
        [_dfkTableView.mj_footer endRefreshing];
    }
    if ([tableView isEqual:_dskTableView]) {
        [_dskTableView.mj_header endRefreshing];
        [_dskTableView.mj_footer endRefreshing];
    }
    
    if ([tableView isEqual:_haveSuccessTableView]) {
        
        [_haveSuccessTableView.mj_header endRefreshing];
        [_haveSuccessTableView.mj_footer endRefreshing];
    }
    if ([tableView isEqual:_haveCancelTabelView]) {
        
        [_haveCancelTabelView.mj_header endRefreshing];
        [_haveCancelTabelView.mj_footer endRefreshing];
    }
    
}
#pragma mark -- RecordDelegate
-(void)changeRecordData:(HXRecordModel *)model {
    if ([model.orderStatus intValue]==1) {
        if ([model.isEnable boolValue]) {
            [self changeshopClear:model];
            return;
        }
        [self.viewModel changeShopClear:model returnBlock:^{
            self.viewModel.model = model;
            self.payment = [[HXPaymentView alloc] initWithOrderNo:model.orderNo sureBlock:^(NSString * succrssBool){
                if ([succrssBool boolValue]) {
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
                    
                }else {
                    HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
                    detail.viewModel.model = model;
                    detail.delegate = self;
                    [self.navigationController pushViewController: detail animated:YES];
                }
                
            } cancelBlock:^{
                
            }];
            self.payment.controller = self;
        } failBlock:^(NSString * clearBoolStr){
            if ([clearBoolStr boolValue]) {
                [self changeshopClear:model];
            }
        }];
    }
    if ([model.orderStatus intValue]==4) {
        HXScorePromptView * promptView = [[HXScorePromptView alloc] initWithName:@"" TitleArr:@[@"商品全部到货后再确认收货哦~"] selectNameArr:@[@"再等等",@"确认收货"] comBool:YES sureBlock:^{
            [self.viewModel changeRecordStateWithOrderId:model.id returnBlock:^{
                self.viewModel.allPage = 1;
                self.viewModel.dfkPage = 1;
                self.viewModel.dshPage = 1;
                self.viewModel.suceessPage = 1;
                self.viewModel.canPage = 1;
                self.dshRefresh = YES;
                [self request:@""];
                [self request:@"1"];
                [self request:@"2"];
                [self request:@"5"];
                [self request:@"6"];
                [KeyWindow displayMessage:@"确认收货成功"];
                UIButton * btn = (UIButton *)[self.view viewWithTag:BtnTag+3];
                [self selectBtnAction:btn];
            } failBlock:^{
                
            }];
            
        } cancelBlock:^{
            
        }];
        [promptView showAlert];
    }
}

/**
 商品下架处理

 @param model model
 */
-(void)changeshopClear:(HXRecordModel *)model {
    HXScorePromptView * promptView = [[HXScorePromptView alloc] initWithName:@"" TitleArr:@[@"部分商品已下架，",@"差一步你就可以拥有我了～"] selectNameArr:@[@"确定"]  comBool:NO sureBlock:^{
        [self.viewModel cancelRecordStateWithOrderId:model.id returnBlock:^{
            self.dshRefresh = NO;
            self.dfkRefresh = NO;
            self.viewModel.allPage = 1;
            self.viewModel.dfkPage = 1;
            self.viewModel.dshPage = 1;
            self.viewModel.suceessPage = 1;
            self.viewModel.canPage = 1;
            [self request:@""];
            [self request:@"1"];
            [self request:@"2"];
            [self request:@"5"];
            [self request:@"6"];
        } failBlock:^{
            
        }];
    } cancelBlock:^{
        
    }];
    [promptView showAlert];
    
}
- (void)updatePayResult {
    [self.viewModel querypaymentWithReturnBlock:^{
        HXRecordDetailViewController * detail = [[HXRecordDetailViewController alloc] init];
        detail.viewModel.model = self.viewModel.model;
        detail.delegate = self;
        [self.navigationController pushViewController: detail animated:YES];
        HXRecordModel * model =   [[HXRecordModel alloc] init];
        [self updateCancelStates:model];
    } failBlock:^{
        
    }];
}
#pragma mark -- RecordDetailDelegate
-(void)updateCancelStates:(HXRecordModel *)model {
//    [MBProgressHUD showMessage:nil toView:self.view];
    self.viewModel.allPage = 1;
    self.viewModel.dfkPage = 1;
    self.viewModel.dshPage = 1;
    self.viewModel.suceessPage = 1;
    self.viewModel.canPage = 1;
    if ([model.orderStatus intValue]==4) {
        self.dfkRefresh = NO;
        self.dshRefresh = YES;
//        [KeyWindow displayMessage:@"确认收货成功"];
        UIButton * btn = (UIButton *)[self.view viewWithTag:BtnTag+3];
        [self selectBtnAction:btn];
    }
    if ([model.orderStatus intValue]==1) {
        self.dfkRefresh = YES;
        self.dshRefresh = NO;
//        [KeyWindow displayMessage:@"取消订单成功"];
        UIButton * btn = (UIButton *)[self.view viewWithTag:BtnTag+4];
        [self selectBtnAction:btn];
    }
    [self request:@""];
    [self request:@"1"];
    [self request:@"2"];
    [self request:@"5"];
    [self request:@"6"];
}
#pragma mark -- setter and getter
-(NSMutableArray *)tableViewArr {
    if (_tableViewArr == nil) {
        _tableViewArr = [[NSMutableArray alloc] init];
    }
    return _tableViewArr;
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
