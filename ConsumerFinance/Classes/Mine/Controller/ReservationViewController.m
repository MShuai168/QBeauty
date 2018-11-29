//
//  ReservationViewController.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/23.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "ReservationViewController.h"
#import "ReservationCell.h"
#import "ReservationDetailVC.h"

@interface ReservationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, assign) int page;

@end

@implementation ReservationViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (iphone_X?55:64)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = COLOR_BACKGROUND;
    }
    return _tableView;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    self.view.backgroundColor = COLOR_BACKGROUND;
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"我的预约";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReservationCell" bundle:nil] forCellReuseIdentifier:@"ReservationCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeadRefreshWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView addFooterRefreshWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.page = 1;
    [self loadReservationListData];
}

#pragma mark - refresh
- (void)loadNewData {
    self.page = 1;
    [self loadReservationListData];
}
- (void)loadMoreData {
    self.page += 1;
    [self loadReservationListData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationCell"];
    ReservationListModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReservationDetailVC *VC = [[ReservationDetailVC alloc] init];
    ReservationListModel *model = self.datasource[indexPath.row];
    VC.id = model.id;
    VC.reserveDate = [Helper dateWithTimeStampAll:model.gmtStart/1000];
    VC.reserveStatusName = model.reserveStatusName;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)loadReservationListData {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%d",self.page], @"rows":@10};
    [[HXNetManager shareManager] get:@"mtReserve/list" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            if (self.page == 1) {
                [self.datasource removeAllObjects];
            }
            NSArray *arrayList = [responseNewModel.body valueForKey:@"mtReservationList"];
            for (NSDictionary *dict in arrayList) {
                ReservationListModel *model = [ReservationListModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            if (self.datasource.count == 0) {
                self.tableView.bounces = NO;
                [self.tableView showNullDataImageViewWithImage:@"nodingdan" andTitleStr:@"亲，您还没有预约哦～" titleColor:0x999999 withIsShow:YES];
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
