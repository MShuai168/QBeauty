//
//  PrepaidCardInvalidVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/23.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "PrepaidCardInvalidVC.h"
#import "PrepaidCardUsedCell.h"
#import "PrepaidCardUsedDetailVC.h"

@interface PrepaidCardInvalidVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation PrepaidCardInvalidVC

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PrepaidCardUsedCell" bundle:nil] forCellReuseIdentifier:@"PrepaidCardUsedCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeadRefreshWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView addFooterRefreshWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.page = 1;
    [self loadDataInvalidCardList];
}

#pragma mark - refresh
- (void)loadNewData {
    self.page = 1;
    [self loadDataInvalidCardList];
}
- (void)loadMoreData {
    self.page += 1;
    [self loadDataInvalidCardList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 280;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrepaidCardUsedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrepaidCardUsedCell"];
    PrepaidCardModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model withType:2];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PrepaidCardModel *model = self.datasource[indexPath.row];
    PrepaidCardUsedDetailVC *VC = [[PrepaidCardUsedDetailVC alloc] init];
    VC.cardId = model.cardId;
    VC.purchaseTime = [Helper dateWithTimeStampAll:model.purchaseTime/1000];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)loadDataInvalidCardList {
    [MBProgressHUD showMessage:nil toView:self.view];  //S_CKZT_SYZ:使用中  S_CKZT_YSX:已失效
    NSDictionary *parameters = @{@"type":@"S_CKZT_YSX", @"page":[NSString stringWithFormat:@"%d",self.page], @"rows":@10};
    [[HXNetManager shareManager] get:@"moneyCard/queryMoneyCards" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            if (self.page == 1) {
                [self.datasource removeAllObjects];
            }
            NSArray *arrayList = [responseNewModel.body valueForKey:@"moneyCards"];
            for (NSDictionary *dict in arrayList) {
                PrepaidCardModel *model = [PrepaidCardModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            if (self.datasource.count == 0) {
                self.tableView.bounces = NO;
                [self.tableView showNullDataImageViewWithImage:@"nodingdan" andTitleStr:@"暂无数据" titleColor:0x999999 withIsShow:YES];
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
