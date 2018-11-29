//
//  OccupiedCardDetailVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "OccupiedCardDetailVC.h"
#import "MeteringCardDetailCell.h"
#import "MeteringCardDetailFooterView.h"
#import "MeteringCardDetailHeaderView.h"

@interface OccupiedCardDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) MeteringCardDetailHeaderView *headerView;
@property (nonatomic, strong) MeteringCardDetailFooterView *footerView;
@property (nonatomic, assign) int type; //次卡类型(1:有限   2：无限)
@end

@implementation OccupiedCardDetailVC

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (MeteringCardDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MeteringCardDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
//        _headerView.backgroundColor = [UIColor greenColor];
    }
    return _headerView;
}

- (MeteringCardDetailFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[MeteringCardDetailFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    }
    return _footerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 35;
        _tableView.rowHeight = UITableViewAutomaticDimension;
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
    
    self.title = @"次卡详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MeteringCardDetailCell" bundle:nil] forCellReuseIdentifier:@"MeteringCardDetailCell"];
    [self.view addSubview:self.tableView];
    
    [self loadMeteringCardDetailData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.datasource.count > 0 ? 30 : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.datasource.count == 0) {
        return nil;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//    view.backgroundColor = [UIColor greenColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 5, 50, 20)];
    titleLabel.textColor = ColorWithHex(0x898989);
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.text = @"产品名称";
    [view addSubview:titleLabel];
    UILabel *totleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 50, 20)];
    totleLabel.centerX = SCREEN_WIDTH/2 + 30;
    totleLabel.textColor = ColorWithHex(0x898989);
    totleLabel.font = [UIFont systemFontOfSize:11];
    totleLabel.text = @"总次数";
    totleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:totleLabel];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 75, 5, 50, 20)];
    numLabel.textColor = ColorWithHex(0x898989);
    numLabel.font = [UIFont systemFontOfSize:11];
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.text = @"当前剩余";
    [view addSubview:numLabel];
//    titleLabel.backgroundColor = [UIColor redColor];
//    totleLabel.backgroundColor = [UIColor redColor];
//    numLabel.backgroundColor = [UIColor redColor];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeteringCardDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeteringCardDetailCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];  //取消cell点击效果
    MeteringCardDetailModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model withNumType:self.type];
    return cell;
}

- (void)loadMeteringCardDetailData {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%d",self.id]};
    [[HXNetManager shareManager] get:@"coupon/querySecDetail" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [self.datasource removeAllObjects];
            NSDictionary *dic = responseNewModel.body[@"data"];
            NSArray *arrayList = dic[@"cardProducts"];
            for (NSDictionary *dict in arrayList) {
                MeteringCardDetailModel *model = [MeteringCardDetailModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            self.type = [dic[@"type"] intValue];
            [self.headerView.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"defaultImg"]];
            if ([dic[@"imgUrl"] length] > 0) {
                [self.headerView.imgView setContentScaleFactor:[[UIScreen mainScreen] scale]];
                self.headerView.imgView.contentMode =  UIViewContentModeScaleAspectFill;
                self.headerView.imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                self.headerView.imgView.clipsToBounds  = YES;
            }
            self.headerView.titleLabel.text = dic[@"cardName"];
            self.headerView.durationLabel.text = dic[@"effectiveTime"];
            self.headerView.purchaseLabel.text = dic[@"buyTime"];
            self.footerView.shopNameLabel.text = dic[@"shopName"];
            
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
