//
//  HXEarnSoreViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXEarnScoreViewController.h"
#import "HXEarnScoreTableViewCell.h"
#import "HXEarnScoreModel.h"
#import "MyProfileViewController.h"
#import "DataAuthenticationViewController.h"
#import "HXAddressViewController.h"
#import "HXSecurityViewController.h"
#import "MyViewController.h"
#import "HXFriendViewController.h"
#import "HXScoreHomeViewController.h"

#import <Masonry/Masonry.h>
#import <RZDataBinding/RZDataBinding.h>

#import "ScoreConversionVC.h"

@interface HXEarnScoreViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HXEarnScoreViewController

- (instancetype)init {
    if (self == [super init]) {
        _viewModel = [[HXEarnScoreViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赚积分";
    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    
    [self setUpNavigation];
    [self setUpTableView];
    
    [self bind];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewModel request];
}

- (void)setUpNavigation {
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}

- (void)setUpTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)bind {
    [self.viewModel rz_addTarget:self action:@selector(refreshTableView) forKeyPathChange:RZDB_KP(HXEarnScoreViewModel, scoreWayArray)];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
//        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_tableView registerClass:[HXEarnScoreTableViewCell class] forCellReuseIdentifier:@"HXEarnScoreTableViewCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.scoreWayArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

//添加门店积分转换
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 0.5)];
//    lineLabel.backgroundColor = ColorWithHex(0xe8e9ea);
    lineLabel.backgroundColor = ColorWithHex(0xb3b5bd);
    [footerView addSubview:lineLabel];
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpButton.frame = CGRectMake(10, 5, SCREEN_WIDTH - 20, 40);
    [jumpButton addTarget:self action:@selector(jumpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:jumpButton];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
    imgView.image = [UIImage imageNamed:@"jifen"];
    [footerView addSubview:imgView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 15, 15, 90, 20)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHex:0x333333];
    titleLabel.text = @"门店积分转换";
    [footerView addSubview:titleLabel];
    UIImageView *jumpImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 15, 20, 20)];
    jumpImg.image = [UIImage imageNamed:@"NextButton"];
    [footerView addSubview:jumpImg];
    UILabel *lineLabelX = [[UILabel alloc] initWithFrame:CGRectMake(15, 49.5, SCREEN_WIDTH - 15, 0.5)];
    lineLabelX.backgroundColor = ColorWithHex(0xb3b5bd);
    [footerView addSubview:lineLabelX];
    return footerView;
}

- (void)jumpButtonAction:(UIButton *)sender {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"type":@1};
    [[HXNetManager shareManager] get:@"exchange/queryExchange" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            ScoreConversionVC *VC = [[ScoreConversionVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXEarnScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXEarnScoreTableViewCell"];
    if (!cell) {
        cell = [[HXEarnScoreTableViewCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).mas_equalTo(-33);
        }];
    }
    
    HXEarnScoreModel *model = [[HXEarnScoreModel alloc] init];
    model = [self.viewModel.scoreWayArray objectAtIndex:indexPath.row];
    if (model) {
        switch (model.id) {
            case 13:
            model.leftImage = @"qiandao";
            break;
            case 1:
            model.leftImage = @"lihe";
            break;
            case 2:
            model.leftImage = @"touxiang";
            break;
            case 3:
            model.leftImage = @"dizhi";
            break;
            case 4:
            model.leftImage = @"ziliao";
            break;
            case 5:
            model.leftImage = @"shiming";
            break;
            case 6:
            model.leftImage = @"yunyinshang";
            break;
            case 7:
            model.leftImage = @"youxiang";
            break;
            case 8:
            model.leftImage = @"zhengxin";
            break;
            case 10:
            model.leftImage = @"mima";
            break;
            case 16:
            model.leftImage = @"invite";
            break;
            
            default:
            break;
        }
        cell.model = model;
        if (model.isCompleted) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXEarnScoreModel *model = [[HXEarnScoreModel alloc] init];
    model = [self.viewModel.scoreWayArray objectAtIndex:indexPath.row];
    if (model.isCompleted) {
        return;
    }
    switch (model.id) {
        case 1:{
            // 新人礼盒
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[HXScoreHomeViewController class]]) {
                    controller.tabBarController.selectedIndex = 0;
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            
        }
            break;
        case 2: {
            // 设置头像
            MyProfileViewController *controller = [[MyProfileViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
        case 3: {
            // 完善收货地址
            HXAddressViewController *controller = [[HXAddressViewController alloc] init];
            controller.title = @"收货地址";
            controller.url = [NSString stringWithFormat:@"%@address",kScoreUrl];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 4:case 5:case 6:case 7:case 8: {
//            // 完善个人信息
//            DataAuthenticationViewController * dataAuth = [[DataAuthenticationViewController alloc] init];
//            dataAuth.viewModel.style = DefaultStyle;
//            [self.navigationController pushViewController:dataAuth animated:YES];
        }
            break;
        case 10: {
            //设置支付密码
            HXSecurityViewController * serious = [[HXSecurityViewController alloc] init];
            [self.navigationController pushViewController:serious animated:YES];
        }
            break;
        case 16: {
            //邀请好友
            HXFriendViewController *controller = [[HXFriendViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (void)refreshTableView {
    [self.tableView reloadData];
}

- (void)onBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"HXEarnSoreViewController dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
