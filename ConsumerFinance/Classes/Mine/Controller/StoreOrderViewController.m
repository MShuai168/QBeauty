//
//  StoreOrderViewController.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "StoreOrderViewController.h"
#import "StoreOrderCell.h"
#import "StoreOrderDetailVC.h"

@interface StoreOrderViewController ()<UITableViewDelegate, UITableViewDataSource> {
    int page;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation StoreOrderViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (iphone_X?55:64)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = COLOR_BACKGROUND;;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//        self.view.backgroundColor = COLOR_BACKGROUND;
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"门店订单";
    self.view.backgroundColor = kUIColorFromRGB(0xF5F7F7);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreOrderCell" bundle:nil] forCellReuseIdentifier:@"StoreOrderCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeadRefreshWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView addFooterRefreshWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    page = 1;
    [self loadStoreOrderList];
}

#pragma mark - refresh
- (void)loadNewData {
    page = 1;
    [self loadStoreOrderList];
}
- (void)loadMoreData {
    page += 1;
    [self loadStoreOrderList];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 131;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreOrderCell"];
//    cell.textLabel.text = @"测试♪(^∇^*)";
    StoreOrderListModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreOrderListModel *model = self.datasource[indexPath.row];
    StoreOrderDetailVC *VC = [[StoreOrderDetailVC alloc] init];
    VC.id = model.id;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)loadStoreOrderList {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%d",page], @"rows":@10};
    [[HXNetManager shareManager] get:@"mtOrder/orderList" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            if (self->page == 1) {
                [self.datasource removeAllObjects];
            }
            NSArray *arrayList = [responseNewModel.body valueForKey:@"mtOrderList"];
            for (NSDictionary *dict in arrayList) {
                StoreOrderListModel *model = [StoreOrderListModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            if (self.datasource.count == 0) {
                self.tableView.bounces = NO;
                [self.tableView showNullDataImageViewWithImage:@"nodingdan" andTitleStr:@"暂无订单" titleColor:0x999999 withIsShow:YES];
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
