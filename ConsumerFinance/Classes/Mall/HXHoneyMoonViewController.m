//
//  HXHoneyMoonViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/16.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXHoneyMoonViewController.h"
#import "ScreenView.h"
#import "BeautyClinicCell.h"
#import "DockBeautyCell.h"
#import "BeautyClinicModel.h"
#import "HXTravelCell.h"
#import "DockBeautyCell.h"
#import "HXCommercialCell.h"
#import "HXYmDetailsViewController.h"
#import "HXProductDetailViewController.h"
#import "HXSearchViewController.h"
@interface HXHoneyMoonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * _itemView; //项目控制的背景view
    UITableView * _itemTableView;//项目
    UITableView * _beautyTableView;//医美
    UISegmentedControl * _segment;
}
@end

@implementation HXHoneyMoonViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel  = [[HXHoneyMoonViewModel alloc] initWithController:self];
        self.viewModel.projectIndex = 1;
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
    [self setRightBarButtonWithIcon:@"search" action:@selector(seachAction)];
    self.view.backgroundColor = COLOR_BACKGROUND;
}
-(void)creatUI {
    /**
     *  顶部segment
     */
    NSArray *items;
    if (self.viewModel.style == HoneymoonStyle) {
        items = @[@"项目",@"商家"];
    }else {
        items = @[@"项目",@"商家"];
    }
    
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:items];
    _segment = segment;
    segment.frame = CGRectMake(0, 0, 150, 29);
    segment.selectedSegmentIndex = 0;
    segment.tintColor = ComonBackColor;
    segment.backgroundColor = [UIColor clearColor];
    segment.layer.cornerRadius = 4.0f;
    segment.layer.masksToBounds = YES;
    segment.layer.borderColor = ComonBackColor.CGColor;
    segment.layer.borderWidth = 0.5;
    self.navigationItem.titleView = segment;
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    /**
     *  封装视图
     */
    ScreenView * screen = [[ScreenView alloc] initWithScreenNumber:2 segSelectIndex:0 selectContent:^{
        [MBProgressHUD showMessage:nil toView:self.view];
        self.viewModel.projectIndex = 1;
        [self archiveProject];
    }];
    if (self.viewModel.style != WeddingPhotoStyle) {
        
        screen.travel = YES;
    }
    self.viewModel.screen = screen;
    screen.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:screen];
    [screen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    /**
     *  封装视图
     */
    ScreenView * dockScreen = [[ScreenView alloc] initWithScreenNumber:2 segSelectIndex:1 selectContent:^{
        [MBProgressHUD showMessage:nil toView:self.view];
        self.viewModel.shopIndex = 1;
        [self archiveShop];
    }];
    self.viewModel.dockScreen = dockScreen;
    dockScreen.hidden = YES;
    dockScreen.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:dockScreen];
    [dockScreen mas_makeConstraints:^(MASConstraintMaker *make) {
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
    _itemTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
    //上拉刷新
    _itemTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
    itemTabView.delegate = self;
    itemTabView.dataSource = self;
    _itemTableView.estimatedRowHeight = 0;
    _itemTableView.estimatedSectionHeaderHeight = 0;
    _itemTableView.estimatedSectionFooterHeight = 0;
    itemTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    itemTabView.backgroundColor = COLOR_BACKGROUND;
    [self.viewModel.screen addSubview:itemTabView];
    [itemTabView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewModel.screen.mas_top).offset(40);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    /**
     *  机构tableview
     */
    UITableView * beautyTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _beautyTableView = beautyTabView;
    _beautyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
    //上拉刷新
    _beautyTableView.estimatedRowHeight = 0;
    _beautyTableView.estimatedSectionHeaderHeight = 0;
    _beautyTableView.estimatedSectionFooterHeight = 0;
    _beautyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
    beautyTabView.delegate = self;
    beautyTabView.dataSource = self;
    beautyTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    beautyTabView.backgroundColor = COLOR_BACKGROUND;
    [self.viewModel.dockScreen addSubview:beautyTabView];
    [beautyTabView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
}

#pragma mark --request 
-(void)request {
    if (self.viewModel.style == HoneymoonStyle) {
    [self.viewModel archiveProjectWithReturnValueBlock:^(id responseObject){
        [self.viewModel.screen travelData:responseObject];
    }];
        [_viewModel archiveAreaWithReturnValueBlock:^(id responseObject){
            
           [self.viewModel.dockScreen areaData:responseObject];
        }];
    }else {
        /**
         *  获取地区筛选数据
         */
        [_viewModel archiveAreaWithReturnValueBlock:^(id responseObject){
            
            [self.viewModel.screen areaData:responseObject];
            [self.viewModel.dockScreen areaData:responseObject];
        }]; 
        
    }
    [_viewModel archiveSoreListWithReturnValueBlock:^(id responseObject){
        [self.viewModel.screen sortListData:responseObject];
        [self.viewModel.dockScreen sortListData:responseObject];
    }];
    [MBProgressHUD showMessage:nil toView:self.view];
    [self archiveProject];
    [self archiveShop];
}
-(void)archiveProject {
    [_viewModel archiveProjectDataWithReturnBlock:^{
        [_itemTableView reloadData];
        [self stopRefresh];
        [MBProgressHUD hideHUDForView:self.view];
        if (self.viewModel.projectArr.count!=0) {
            [self.viewModel.projectStateView removeFromSuperview];
        }else {
            [self.viewModel showProjectView:_itemTableView type:2];
        }
    }failBlock:^{
        [self stopRefresh];
        [MBProgressHUD hideHUDForView:self.view];
        [self.viewModel showProjectView:_itemTableView type:0];
    }];
    
}
-(void)archiveShop {
    [_viewModel archiveTenantDataWithReturnBlock:^{
        [_beautyTableView reloadData];
        [self stopBeatyRefresh];
        [MBProgressHUD hideHUDForView:self.view];
        if (self.viewModel.shopArr.count!=0) {
            [self.viewModel.itemStateView removeFromSuperview];
        }else {
            [self.viewModel showItemView:_beautyTableView type:2];
        }
    } failBlock:^{
        [self stopBeatyRefresh];
        [MBProgressHUD hideHUDForView:self.view];
        [self.viewModel showItemView:_beautyTableView type:0];

    }];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:_itemTableView]) {
        return self.viewModel.projectArr.count;
    }
    return self.viewModel.shopArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    static NSString *cellIdentitySec = @"IdentityInfoCellSec";
    if ([tableView isEqual:_itemTableView]) {
        
        BeautyClinicCell *cell = (BeautyClinicCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BeautyClinicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        cell.model = [self.viewModel.projectArr objectAtIndex:indexPath.section];
        return cell;
    }else
    {
        HXCommercialCell *cell = (HXCommercialCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentitySec];
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
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_itemTableView]) {
        return 115;
    }
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
    if (_segment.selectedSegmentIndex ==0) {
        
        HXProductDetailViewController * details = [[HXProductDetailViewController alloc ] init];
        DtoListModel * model =[self.viewModel.projectArr objectAtIndex:indexPath.section];
        details.viewModel.proId = model.id?model.id:@"";
        [self.navigationController pushViewController:details animated:YES];
    }else {
        HXYmDetailsViewController * product = [[HXYmDetailsViewController alloc] init];
        DtoListModel * model = [self.viewModel.shopArr objectAtIndex:indexPath.section];
        product.viewModel.merId = model.id?model.id :@"";
        [self.navigationController pushViewController:product animated:YES];
    }
    
}
#pragma mark -- segment
-(void)segmentValueChanged:(id)sender
{
    UISegmentedControl * segment = (UISegmentedControl *)sender;
    if (segment.selectedSegmentIndex==0) {
        self.viewModel.screen.hidden = NO;
        self.viewModel.dockScreen.hidden = YES;
    }else {
        self.viewModel.screen.hidden = YES;
        self.viewModel.dockScreen.hidden = NO;
    }
    
    
}
#pragma mark -- 搜索
-(void)seachAction {
    HXSearchViewController * seach = [[HXSearchViewController alloc] init];
    seach.viewModel.addressModel = self.viewModel.addressModel;
    [self.navigationController pushViewController:seach animated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
-(void)loadNewTopic:(UITableView*)tableView {
    [MBProgressHUD showMessage:nil toView:self.view];
    if ([tableView isEqual:_itemTableView.mj_header]) {
        self.viewModel.projectIndex = 1;
        [self archiveProject];
    }else {
        self.viewModel.shopIndex = 1;
        [self archiveShop];
    }
}
-(void)loadMoreTopic:(UITableView*)tableView {
    [MBProgressHUD showMessage:nil toView:self.view];
    if ([tableView isEqual:_itemTableView.mj_footer]) {
        self.viewModel.projectIndex++;
        [self archiveProject];
        
    }else {
        self.viewModel.shopIndex ++;
        [self archiveShop];
    }
}
-(void)stopRefresh {
    [_itemTableView.mj_header endRefreshing];
    [_itemTableView.mj_footer endRefreshing];
}
-(void)stopBeatyRefresh {
    [_beautyTableView.mj_header endRefreshing];
    [_beautyTableView.mj_footer endRefreshing];
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
