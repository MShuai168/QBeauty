//
//  HXClubHouseViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/3.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXClubHouseViewController.h"
#import "ScreenView.h"
#import "HXTravelCell.h"
#import "HXCommercialCell.h"
#import "DtoListModel.h"
#import "HXWeddingdetailViewController.h"
#import "HXSearchViewController.h"
#import "HXYmDetailsViewController.h"
@interface HXClubHouseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * _itemView; //项目控制的背景view
    UITableView * _itemTableView;//项目
}
@end

@implementation HXClubHouseViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel  = [[HXClubHouseViewModel alloc] initWithController:self];
        self.viewModel.shopIndex = 1;
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
    
    [self hiddenNavgationBarLine:NO];
}
-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}
/**
 *  隐藏导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = COLOR_BACKGROUND;
    if (self.viewModel.style == WeddingStyle) {
       self.navigationItem.title = @"婚宴酒店";
    }else {
        
        self.navigationItem.title = @"月子会所";
    }
    [self setRightBarButtonWithIcon:@"search" action:@selector(seachAction)];
}
-(void)creatUI {
    /**
     *  封装视图 筛选完回调在这里
     */
    ScreenView * screen = [[ScreenView alloc] initWithScreenNumber:2 segSelectIndex:0 selectContent:^{
        self.viewModel.shopIndex = 1;
        [self archiveShop];
    }];
    self.viewModel.dockScreen = screen;
    screen.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:screen];
    [screen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
   
    /**
     *  项目tableview
     */
    UITableView * itemTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _itemTableView = itemTabView;
    _itemTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //上拉刷新
    _itemTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    itemTabView.delegate = self;
    itemTabView.dataSource = self;
    _itemTableView.estimatedRowHeight = 0;
    _itemTableView.estimatedSectionHeaderHeight = 0;
    _itemTableView.estimatedSectionFooterHeight = 0;
    itemTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    itemTabView.backgroundColor = COLOR_BACKGROUND;
    [self.viewModel.dockScreen addSubview:itemTabView];
    [itemTabView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewModel.dockScreen.mas_top).offset(40);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}
#pragma mark --request
-(void)request {
    /**
     *  获取地区筛选数据
     */
    [_viewModel archiveAreaWithReturnValueBlock:^(id responseObject){
        
        [self.viewModel.dockScreen areaData:responseObject];
    }];
    
    [_viewModel archiveSoreListWithReturnValueBlock:^(id responseObject){
        [self.viewModel.dockScreen sortListData:responseObject];
    }];
    [self archiveShop];
}
-(void)archiveShop {
    [MBProgressHUD showMessage:nil toView:self.view];
    [_viewModel archiveTenantDataWithReturnBlock:^{
        [_itemTableView reloadData];
        [self stopBeatyRefresh];
        
        [MBProgressHUD hideHUDForView:self.view];
        if (self.viewModel.shopArr.count!=0) {
            [self.viewModel.projectStateView removeFromSuperview];
        }else {
            [self.viewModel showProjectView:_itemTableView type:2];
        }
    } failBlock:^{
        [self stopBeatyRefresh];
        [MBProgressHUD hideHUDForView:self.view];
        [self.viewModel showProjectView:_itemTableView type:0];
    }];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.shopArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    HXCommercialCell *cell = (HXCommercialCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[HXCommercialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(90);
        }];
        [cell.paymontLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(90);
        }];
    }
    cell.model = [self.viewModel.shopArr objectAtIndex:indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DtoListModel * model = [self.viewModel.shopArr objectAtIndex:indexPath.section];
    if (model.bigBool) {
        return 110;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    }
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
//    HXWeddingdetailViewController * detail = [[HXWeddingdetailViewController alloc] init];
//    detail.weddingBool = _viewModel.style ==WeddingStyle ?YES:NO;
    HXYmDetailsViewController * detail = [[HXYmDetailsViewController alloc] init];
    DtoListModel * model = [self.viewModel.shopArr objectAtIndex:indexPath.section];
    detail.viewModel.merId = model.id;
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma mark -- 搜索
-(void)seachAction {
    HXSearchViewController * seach = [[HXSearchViewController alloc] init];
    seach.viewModel.addressModel = self.viewModel.addressModel;
    [self.navigationController pushViewController:seach animated:YES];
}
-(void)loadNewTopic  {
    self.viewModel.shopIndex = 1;
    [self archiveShop];
}
-(void)loadMoreTopic {
    self.viewModel.shopIndex ++;
    [self archiveShop];
}
-(void)stopBeatyRefresh {
    [_itemTableView.mj_header endRefreshing];
    [_itemTableView.mj_footer endRefreshing];
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
