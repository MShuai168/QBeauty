//
//  BalanceDetailVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "BalanceDetailVC.h"
#import "BalanceDetailCell.h"

@interface BalanceDetailVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *totalMoneyLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation BalanceDetailVC

- (NSMutableArray *)datasource {
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _headerView.backgroundColor = kUIColorFromRGB(0xF5F7F7);
        [_headerView addSubview:self.totalMoneyLabel];
    }
    return _headerView;
}

- (UILabel *)totalMoneyLabel {
    if(!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, SCREEN_WIDTH - 10, 40)];
        _totalMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _totalMoneyLabel.font = [UIFont boldSystemFontOfSize:28];
    }
    return _totalMoneyLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (iphone_X?83:49) - 16) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.tableHeaderView = self.headerView;
//        _tableView.backgroundColor = [UIColor orangeColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    self.view.backgroundColor = COLOR_BACKGROUND;
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"余额明细";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BalanceDetailCell" bundle:nil] forCellReuseIdentifier:@"BalanceDetailCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeadRefreshWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView addFooterRefreshWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.page = 1;
    [self loadDataBalanceRecords];
}

#pragma mark - refresh
- (void)loadNewData {
    self.page = 1;
    [self loadDataBalanceRecords];
}
- (void)loadMoreData {
    self.page += 1;
    [self loadDataBalanceRecords];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BalanceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceDetailCell"];
//    cell.textLabel.text = @"测试(⊙_⊙)?";
    BalanceDetailModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadDataBalanceRecords {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%d",self.page], @"rows":@10};
    [[HXNetManager shareManager] get:@"balance/queryBalanceRecords" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            if (self.page == 1) {
                [self.datasource removeAllObjects];
                
                NSString *totalMoney = [responseNewModel.body valueForKey:@"balance"];
                if (totalMoney != nil) {
                    self.totalMoneyLabel.text = [NSString stringWithFormat:@"￥%@", totalMoney];
                } else {
                    self.totalMoneyLabel.text = @"￥0.00";
                }
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.totalMoneyLabel.text];
                //设置颜色
                //        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(0, 1)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
                //设置尺寸
                [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, 1)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
                //这段代码必须要写 否则没效果
                self.totalMoneyLabel.attributedText = attributedString;
            }
            
            NSArray *arrayList = [responseNewModel.body valueForKey:@"balanceRecords"];
            for (NSDictionary *dict in arrayList) {
                BalanceDetailModel *model = [BalanceDetailModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            if (self.datasource.count == 0) {
                self.tableView.bounces = NO;
                [self.tableView showNullDataImageViewWithImage:@"nodata" andTitleStr:@"暂无明细" titleColor:0x999999 withIsShow:YES];
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
