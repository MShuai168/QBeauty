//
//  StoreOrderDetailVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "StoreOrderDetailVC.h"
#import "StoreOrderDetailCell.h"
#import "FooterView.h"

@interface StoreOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FooterView *footerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation StoreOrderDetailVC

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (FooterView *)footerView {
    if (!_footerView) {
        _footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 340)];
    }
    return _footerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.tableFooterView = self.footerView;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 35;
        _tableView.rowHeight = UITableViewAutomaticDimension;
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
    
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreOrderDetailCell" bundle:nil] forCellReuseIdentifier:@"StoreOrderDetailCell"];
    [self.view addSubview:self.tableView];
    
    [self loadStoreOrderDetails];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 35;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreOrderDetailCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];  //取消cell点击效果
    //    cell.textLabel.text = @"测试(⊙_⊙)?";
    StoreOrderDetailModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (void)loadStoreOrderDetails {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%d",self.id]};
    [[HXNetManager shareManager] get:@"mtOrder/details" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [self.datasource removeAllObjects];
            NSArray *arrayList = [responseNewModel.body valueForKey:@"details"];
            for (NSDictionary *dict in arrayList) {
                StoreOrderDetailModel *model = [StoreOrderDetailModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            
            NSDictionary *dic = [responseNewModel.body valueForKey:@"statistics"];
            self.footerView.totalPricesLabel.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"orderPrice"] floatValue]];
            self.footerView.discountLabel.text = [NSString stringWithFormat:@"-￥%.2f",[dic[@"totalDiscount"] floatValue]];
            NSDictionary *dict = [responseNewModel.body valueForKey:@"mtOrder"];
            NSString *couponName = dict[@"couponName"];
            float couponMoney = [dict[@"couponMoney"] floatValue];
            if (couponName.length > 0) {
                self.footerView.couponNameTemp.hidden = false;
                self.footerView.couponMoneyTemp.hidden = false;
                self.footerView.couponNameLabel.text = couponName;
                self.footerView.couponMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f", couponMoney];
                self.footerView.topHeightConstraint.constant = 60;
            } else {
                self.footerView.topHeightConstraint.constant = 10;
            }
            self.footerView.receivableLabel.text = [NSString stringWithFormat:@"￥%.2f",[dict[@"totalPrice"] floatValue]];
            self.footerView.paidMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[dict[@"realFee"] floatValue]];
            self.footerView.orderCodeLabel.text = dict[@"orderCode"];
            self.footerView.createLabel.text = [Helper dateWithTimeStampAll:[dict[@"gmtCreate"] integerValue] / 1000];
            //支付方式及支付金额
            NSString *payTypeName1 = dict[@"payTypeName1"];
            NSString *payTypeName2 = dict[@"payTypeName2"];
            if (payTypeName1.length > 0 && payTypeName2.length > 0) {
                self.footerView.tempHeightConstraint.constant = 30;
                self.footerView.payTypeName2Label.hidden = false;
                self.footerView.payTypeLabel.text = [NSString stringWithFormat:@"%@  ￥%.2f", payTypeName1, [dict[@"payTypeMoney1"] floatValue]];
                self.footerView.payTypeName2Label.text = [NSString stringWithFormat:@"%@  ￥%.2f", payTypeName2, [dict[@"payTypeMoney2"] floatValue]];
            } else {
                self.footerView.tempHeightConstraint.constant = 10;
                self.footerView.payTypeLabel.text = [NSString stringWithFormat:@"%@  %@",dict[@"payTypeName"],self.footerView.paidMoneyLabel.text];
            }
            float tkFee = [dict[@"tkFee"] floatValue];
            if (tkFee > 0) {
                self.footerView.tkFeeTemp.hidden = false;
                self.footerView.tkFeeLabel.hidden = false;
                self.footerView.tkFeeLabel.text = [NSString stringWithFormat:@"￥%.2f", tkFee];
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
