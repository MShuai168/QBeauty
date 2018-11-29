//
//  HXMyTeamViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/30.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyTeamViewController.h"
#import "HXMyTeamTableViewCell.h"

@interface HXMyTeamViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation HXMyTeamViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXMyTeamViewModel alloc] initWithController:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    self.view.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [self request];
}
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"我的团队";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
-(void)createUI {
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //上拉刷新
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.teamArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity1 = @"IdentityInfoCell1";
    HXMyTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
    if (!cell) {
        cell = [[HXMyTeamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell creatLine:15 hidden:NO];
    }
    cell.model = [self.viewModel.teamArr objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 98;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

-(void)request {
    [self.viewModel archiveInformationWithReturnBlock:^{
        if (self.viewModel.teamArr.count > 0) {
            _tableView.bounces = YES;
            [_tableView showNullDataImageViewWithImage:@"" imageRect:CGRectMake(0, 0, 0, 0) andTitleStr:@"" titleColor:0x999999 withIsShow:NO];
        } else {
            _tableView.bounces = NO;
            [_tableView showNullDataImageViewWithImage:@"nodingdan" andTitleStr:@"暂无记录" titleColor:0x999999 withIsShow:YES];
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } failBlock:^{
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}
-(void)loadNewTopic  {
    self.viewModel.pageIndex = 1;
    [self request];
}
-(void)loadMoreTopic {
    self.viewModel.pageIndex ++;
    [self request];
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
