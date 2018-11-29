//
//  CouponUnusedVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/21.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "CouponUnusedVC.h"
#import "CouponUnusedCell.h"
#import "CouponDetailViewController.h"

@interface CouponUnusedVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation CouponUnusedVC

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (iphone_X?88:64) - 45)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = COLOR_BACKGROUND;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"CouponUnusedCell" bundle:nil] forCellReuseIdentifier:@"CouponUnusedCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeadRefreshWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView addFooterRefreshWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.page = 1;
    [self loadUnusedCoouponData];
}

#pragma mark - refresh
- (void)loadNewData {
    self.page = 1;
    [self loadUnusedCoouponData];
}
- (void)loadMoreData {
    self.page += 1;
    [self loadUnusedCoouponData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponUnusedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponUnusedCell"];
    CouponListModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model withType:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CouponListModel *model = self.datasource[indexPath.row];
    CouponDetailViewController *VC = [[CouponDetailViewController alloc] init];
    VC.id = model.id;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)loadUnusedCoouponData {
    [MBProgressHUD showMessage:nil toView:self.view];  //优惠券：S_HYYHQZT_WSY-未使用、S_HYYHQZT_YSY-已使用、S_HYYHQZT_YGQ-已过期
    NSDictionary *parameters = @{@"type":@"S_HYYHQZT_WSY", @"page":[NSString stringWithFormat:@"%d",self.page], @"pageSize":@10};
    [[HXNetManager shareManager] get:@"coupon/queryCouponList" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            if (self.page == 1) {
                [self.datasource removeAllObjects];
            }
            NSArray *arrayList = [responseNewModel.body valueForKey:@"data"];
            for (NSDictionary *dict in arrayList) {
                CouponListModel *model = [CouponListModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            if (self.datasource.count == 0) {
                self.tableView.bounces = NO;
                [self.tableView showNullDataImageViewWithImage:@"nodingdan" andTitleStr:@"暂无优惠券" titleColor:0x999999 withIsShow:YES];
            } else {
                self.tableView.bounces = YES;
                [self.tableView showNullDataImageViewWithImage:@"" andTitleStr:@"" titleColor:0x999999 withIsShow:NO];
            }
            [self.tableView reloadData];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
        //停止刷新
        [self.tableView endRefreshHeaderAndFooter];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
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
