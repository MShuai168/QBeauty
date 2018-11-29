//
//  ReservationDetailVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/23.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "ReservationDetailVC.h"
#import "ReservationDetailHeaderView.h"
#import "ReservationDetailCell.h"

@interface ReservationDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ReservationDetailHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation ReservationDetailVC

- (ReservationDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ReservationDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        _headerView.reserveStatusLabel.text = self.reserveStatusName;
        _headerView.reserveDateLabel.text = self.reserveDate;
    }
    return _headerView;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        _tableView.backgroundColor = [UIColor orangeColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    self.view.backgroundColor = COLOR_BACKGROUND;
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"预约详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReservationDetailCell" bundle:nil] forCellReuseIdentifier:@"ReservationDetailCell"];
    [self.view addSubview:self.tableView];
    
    [self loadeservationDetailData];
}

-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReservationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationDetailCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];  //取消cell点击效果
    ReservationDetailModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (void)loadeservationDetailData {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%d",self.id]};
    [[HXNetManager shareManager] get:@"mtReserve/details" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [self.datasource removeAllObjects];
            NSArray *arrayList = [responseNewModel.body valueForKey:@"mtReserveDetails"];
            for (NSDictionary *dict in arrayList) {
                ReservationDetailModel *model = [ReservationDetailModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            [self.tableView reloadData];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
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
