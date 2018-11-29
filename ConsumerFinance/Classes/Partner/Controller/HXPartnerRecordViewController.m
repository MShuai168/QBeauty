//
//  HXPartnerRecordViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerRecordViewController.h"
#import "HXPartnerRecordTableViewCell.h"
#import "HXPartnerResultViewController.h"
#define  BtnTag 500
#define TableViewTag 1000
@interface HXPartnerRecordViewController ()<UITableViewDelegate,UITableViewDataSource,partnerResultDlegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIView * selectLine;//红线
@property (nonatomic,strong)NSMutableArray * tableViewArr;
@property (nonatomic,strong)UITableView * incomeTableview;
@property (nonatomic,strong)UITableView * withdrawTableView;
@property (nonatomic,strong)UIView * headView;
@end

@implementation HXPartnerRecordViewController
-(id)init{
    
    self = [super init];
    if (self) {
        self.viewModel = [[HXPartnerRecordViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self hiddeKeyBoard];
    [self createUI];
    self.view.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [MBProgressHUD showMessage:nil toView:self.view];
    [self request:@"1"];
    [self request:@"2"];
    [self request:@"3"];
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"记录";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
-(void) hiddeKeyBoard{
    
    [self.view endEditing:YES];
    
}
-(void)createUI {
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [self.view addSubview:headView];
    self.headView = headView;
    headView.backgroundColor = CommonBackViewColor;
    NSArray * nameArr = @[@"购买记录",@"收益记录",@"提现记录"];
    for (int i = 0 ; i<3 ; i++) {
        UIButton * selectBtn = [[UIButton alloc] init];
        [selectBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
        [selectBtn setTitle:[nameArr objectAtIndex:i] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        selectBtn.tag = i+BtnTag;
        [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [headView addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView).offset(SCREEN_WIDTH/3*i);
            make.top.and.bottom.equalTo(headView);
            make.width.mas_equalTo(SCREEN_WIDTH/3);
        }];
        if (i==0) {
            UIView * selectLine = [[UIView alloc] init];
            self.selectLine = selectLine;
            selectLine.backgroundColor = ComonBackColor;
            [headView addSubview:selectLine];
            [selectLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(selectBtn);
                make.bottom.equalTo(headView);
                make.width.mas_equalTo(60);
                make.height.mas_equalTo(2);
            }];
            [selectBtn setTitleColor:ComonBackColor forState:UIControlStateNormal];
        }
    }
    for (int i = 0; i<3; i++) {
        
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
            make.top.equalTo(self.view.mas_top).offset(54);
            make.left.equalTo(self.view).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
        }];
        [self.tableViewArr addObject:tableView];
        if (i==0) {
            tableView.hidden = NO;
            self.tableView = tableView;
        }else if (i==1) {
            self.incomeTableview = tableView;
        }else {
            self.withdrawTableView = tableView;
        }
    }
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == TableViewTag) {
        return self.viewModel.buyRecordArr.count;
    }else if (tableView.tag == TableViewTag+1) {
        return self.viewModel.incomeArr.count;
    }else if (tableView.tag == TableViewTag+2) {
        return self.viewModel.withdrawArr.count;
    }else {
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == TableViewTag) {
        static NSString *cellIdentity = @"IdentityInfoCell";
        HXPartnerRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXPartnerRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            [cell creatLine:15 hidden:NO];
        }
        cell.model = [self.viewModel.buyRecordArr objectAtIndex:indexPath.row];
        return cell;
    }else if (tableView.tag == TableViewTag+1) {
        
        static NSString *cellIdentity = @"IdentityInfoCell1";
        HXPartnerRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXPartnerRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.stateLabel.hidden = YES;
            [cell.moneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).offset(-15);
            }];
            [cell creatLine:15 hidden:NO];
        }
        cell.incomeModel = [self.viewModel.incomeArr objectAtIndex:indexPath.row];
        return cell;
        
        
    }else {
        static NSString *cellIdentity = @"IdentityInfoCell2";
        HXPartnerRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXPartnerRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            [cell creatLine:15 hidden:NO];
        }
        cell.withdrawModel = [self.viewModel.withdrawArr objectAtIndex:indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 73;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([tableView isEqual:_tableView]) {
        HXPartnerResultViewController * result = [[HXPartnerResultViewController alloc] init];
        result.delegate = self;
        HXBuyRecordModel * model  = [self.viewModel.buyRecordArr objectAtIndex:indexPath.row];
        result.viewModel.id = model.id;
        [self.navigationController pushViewController:result animated:YES];
    }
    
    if ([tableView isEqual:_withdrawTableView]) {
      HXBuyRecordModel * model =    [self.viewModel.withdrawArr objectAtIndex:indexPath.row];
        if ([model.type isEqualToString:@"4"]) {
            HXPartnerResultViewController * result = [[HXPartnerResultViewController alloc] init];
            result.viewModel.orderStates = PartnerOrderStatesFail;
            result.viewModel.id = model.id;
            [self.navigationController pushViewController:result animated:YES];
        }
    }
    
}

-(void)selectBtnAction:(UIButton *)button {
    [button setTitleColor:ComonBackColor forState:UIControlStateNormal];
    [self.selectLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.bottom.equalTo(self.headView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(2);
    }];
    for (int i = 0; i<3; i++) {
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
-(void)request:(NSString * )type {
    [self.viewModel archiveRecordInformationWithType:type returnBlock:^{
        if ([type isEqualToString:@"1"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [_tableView reloadData];
             [self detailTableView:self.tableView type:8 scoreBool:self.viewModel.buyRecordArr.count==0?NO:YES kindType:type];
        }else if ([type isEqualToString:@"2"]){
            [self.incomeTableview reloadData];
             [self detailTableView:self.incomeTableview type:8 scoreBool:self.viewModel.incomeArr.count==0?NO:YES kindType:type];
        }else {
             [self detailTableView:self.withdrawTableView type:8 scoreBool:self.viewModel.withdrawArr.count==0?NO:YES kindType:type];
            [_withdrawTableView reloadData];
        }
        if (self.viewModel.openHdBool) {
            [MBProgressHUD hideHUDForView:self.view];
            self.viewModel.openHdBool = NO;
        }
    } failBlock:^{
        if ([type isEqualToString:@"1"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [self detailTableView:self.tableView type:0 scoreBool:self.viewModel.buyRecordArr.count==0?NO:YES kindType:type];
        }else if ([type isEqualToString:@"2"]) {
            [self detailTableView:self.incomeTableview type:0 scoreBool:self.viewModel.incomeArr.count==0?NO:YES kindType:type];
        }else {
            
             [self detailTableView:self.withdrawTableView type:0 scoreBool:self.viewModel.withdrawArr.count==0?NO:YES kindType:type];
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
-(void)stopBeatyRefresh:(UITableView *)tableView {
    if ([tableView isEqual:_tableView]) {
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    
    if ([tableView isEqual:_incomeTableview]) {
        [_incomeTableview.mj_header endRefreshing];
        [_incomeTableview.mj_footer endRefreshing];
    }
    if ([tableView isEqual:_withdrawTableView]) {
        [_withdrawTableView.mj_header endRefreshing];
        [_withdrawTableView.mj_footer endRefreshing];
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
        self.viewModel.buyRecordIndex = moreBool?self.viewModel.buyRecordIndex+1:1;
        [self request:@"1"];
    }
    if ([tableView isEqual:_incomeTableview.mj_header] || [tableView isEqual:_incomeTableview.mj_footer]) {
        self.viewModel.incomeIndex = moreBool?self.viewModel.incomeIndex+1:1;
        [self request:@"2"];
    }
    if ([tableView isEqual:_withdrawTableView.mj_header] || [tableView isEqual:_withdrawTableView.mj_footer]) {
        self.viewModel.withdrawIndex = moreBool?self.viewModel.withdrawIndex+1:1;
        [self request:@"3"];
    }
    
}
-(void)update {
    [MBProgressHUD showMessage:nil toView:self.view];
    [self request:@"1"];
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
