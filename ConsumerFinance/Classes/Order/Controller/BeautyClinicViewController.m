//
//  BeautyClinicViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BeautyClinicViewController.h"
#import "ScreenView.h"
#import "BeautyClinicCell.h"
#import "BeautyClinicModel.h"
#import "HXYmDetailsViewController.h"
#import "HXCommercialCell.h"
#import "DtoListModel.h"
#import "HXProductDetailViewController.h"
#import "HXSearchViewController.h"
#import "CurrentLocation.h"
#import "BarButtonView.h"
@interface BeautyClinicViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * _itemView; //项目控制的背景view
    UITableView * _itemTableView;//项目
    UITableView * _beautyTableView;//医美
    UISegmentedControl * _segment;
}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong)UIButton * projectBtn;
@property (nonatomic,strong)UIButton * shopBtn;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)TitileView * titleView;
@end

@implementation BeautyClinicViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel  = [[HXBeautyClinicViewModel alloc] initWithController:self];
        self.viewModel.projectIndex = 1;
        self.viewModel.shopIndex = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatViewModel];
    [self editNavi];
    [self creatUI];
    [MBProgressHUD showMessage:nil toView:self.view];
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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    [self setRightBarButtonWithIcon:@"search" action:@selector(seachAction)];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(void)creatViewModel {
    /**
     *  获取地区筛选数据
     */
    [_viewModel archiveAreaWithReturnValueBlock:^(id responseObject){
        
        [self.viewModel.screen areaData:responseObject];
        [self.viewModel.dockScreen areaData:responseObject];
    }];
    /**
     *  获取项目筛选数据
     */
    [_viewModel archiveProjectWithReturnValueBlock:^(id responseObject){
        [self.viewModel.screen projectData:responseObject];
        [self.viewModel.dockScreen projectData:responseObject];
    }];
    
    [_viewModel archiveSoreListWithReturnValueBlock:^(id responseObject){
        [self.viewModel.screen sortListData:responseObject];
        [self.viewModel.dockScreen sortListData:responseObject];
    }];
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
-(void)creatUI {
    /**
     *  顶部segment
     */
    TitileView * titleView = [[TitileView alloc] initWithFrame:CGRectMake(0, 0, 150, 35)];
    self.titleView = titleView;

    NSArray *items = @[@"项目",@"商家"];
    for (int i=0; i<2; i++) {
        UIButton * selectBtn = [[UIButton alloc] init];
        [selectBtn setTitle:[items objectAtIndex:i]  forState:UIControlStateNormal];
        [selectBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
        [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:selectBtn];
        if (i==0) {
            self.projectBtn = selectBtn;
            self.projectBtn.selected = YES;
            [selectBtn setTitleColor:kUIColorFromRGB(0xFF6098) forState:UIControlStateNormal];
            [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(titleView.mas_centerX).offset(0);
                make.top.and.bottom.equalTo(titleView);
                make.width.mas_equalTo(50);
            }];
            
        }else {
            self.shopBtn = selectBtn;
            self.shopBtn.selected = NO;
            [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleView.mas_centerX).offset(0);
                make.top.and.bottom.equalTo(titleView);
                make.width.mas_equalTo(50);
            }];
            
        }
    }
    UIView * lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = kUIColorFromRGB(0xFF6098);
    [titleView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleView.mas_bottom).offset(-1);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(40);
        make.centerX.equalTo(self.projectBtn);
    }];
   titleView.intrinsicContentSize = CGSizeMake(self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView = titleView;
    /**
     *  封装视图
     */
    ScreenView * screen = [[ScreenView alloc] initWithScreenNumber:3 segSelectIndex:0 selectContent:^{
        [MBProgressHUD showMessage:nil toView:self.view];
        self.viewModel.projectIndex = 1;
        [self archiveProject];
    }];
    self.viewModel.screen = screen;
    screen.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:screen];
    [screen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    /**
     *  封装视图
     */
    ScreenView * dockScreen = [[ScreenView alloc] initWithScreenNumber:3 segSelectIndex:1 selectContent:^{
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
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    
    /**
     *  项目tableview
     */
    UITableView * itemTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _itemTableView = itemTabView;
    _itemTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
    //上拉刷新
    _itemTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
    _itemTableView.estimatedRowHeight = 0;
    _itemTableView.estimatedSectionHeaderHeight = 0;
    _itemTableView.estimatedSectionFooterHeight = 0;
    itemTabView.delegate = self;
    itemTabView.dataSource = self;
    itemTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    itemTabView.backgroundColor = COLOR_BACKGROUND ;
    [self.viewModel.screen addSubview:itemTabView];
    [itemTabView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    /**
     *  医院tableview
     */
    UITableView * beautyTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _beautyTableView = beautyTabView;
    _beautyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
    //上拉刷新
    _beautyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
    _beautyTableView.estimatedRowHeight = 0;
    _beautyTableView.estimatedSectionHeaderHeight = 0;
    _beautyTableView.estimatedSectionFooterHeight = 0;
    beautyTabView.delegate = self;
    beautyTabView.dataSource = self;
    beautyTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    beautyTabView.backgroundColor = COLOR_BACKGROUND ;
    [self.viewModel.dockScreen addSubview:beautyTabView];
    [beautyTabView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_itemTableView]) {
        return self.viewModel.projectArr.count;
    }
    return self.viewModel.shopArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    static NSString *cellIdentitySec = @"IdentityInfoCellSec";
    if ([tableView isEqual:_itemTableView]) {
        
        BeautyClinicCell *cell = (BeautyClinicCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BeautyClinicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            [cell creatLine:0 hidden:NO];
        }
        cell.model = [self.viewModel.projectArr objectAtIndex:indexPath.row];
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
            [cell creatLine:0 hidden:NO];
        }
        cell.model = [self.viewModel.shopArr objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_itemTableView]) {
        
        return 115;
    }
    DtoListModel * model = [self.viewModel.shopArr objectAtIndex:indexPath.row];
    if (model.bigBool) {
        return 110;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.projectBtn.selected) {
        
        HXProductDetailViewController * details = [[HXProductDetailViewController alloc ] init];
        DtoListModel * model =[self.viewModel.projectArr objectAtIndex:indexPath.row];
        details.viewModel.proId = model.id?model.id:@"";
        [self.navigationController pushViewController:details animated:YES];
    }else {
        HXYmDetailsViewController * product = [[HXYmDetailsViewController alloc] init];
        DtoListModel * model = [self.viewModel.shopArr objectAtIndex:indexPath.row];
        product.viewModel.merId = model.id?model.id :@"";
        [self.navigationController pushViewController:product animated:YES];
    }
    
}
#pragma mark -- segment
-(void)selectBtnAction:(UIButton *)sender
{
    if ([sender isEqual:self.projectBtn]) {
        self.viewModel.screen.hidden = NO;
        self.viewModel.dockScreen.hidden = YES;
        self.projectBtn.selected = YES;
        self.shopBtn.selected = NO;
        [self.projectBtn setTitleColor:kUIColorFromRGB(0xFF6098) forState:UIControlStateNormal];
        [self.shopBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.titleView.mas_bottom).offset(-1);
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(40);
            make.centerX.equalTo(self.projectBtn);
        }];
        
    }else {
        self.viewModel.screen.hidden = YES;
        self.viewModel.dockScreen.hidden = NO;
        self.projectBtn.selected = NO;
        self.shopBtn.selected = YES;
        [self.shopBtn setTitleColor:kUIColorFromRGB(0xFF6098) forState:UIControlStateNormal];
        [self.projectBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.titleView.mas_bottom).offset(-1);
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(40);
            make.centerX.equalTo(self.shopBtn);
        }];
    }
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
#pragma mark -- 搜索
-(void)seachAction {
    HXSearchViewController * seach = [[HXSearchViewController alloc] init];
    seach.viewModel.addressModel = self.viewModel.addressModel;
    [self.navigationController pushViewController:seach animated:YES];
}

#pragma mark -- setter

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
