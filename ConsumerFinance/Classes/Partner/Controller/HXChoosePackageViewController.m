//
//  HXChoosePackageViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXChoosePackageViewController.h"
#import "HXChoosePackageTableViewCell.h"
#import "HXPackageModel.h"
#import "HXChoosePackageViewModel.h"
#import "HXPackageDetailViewController.h"
#import "HXPartnerResultViewController.h"
#import "HXPartnerViewController.h"

#import <RZDataBinding/RZDataBinding.h>

@interface HXChoosePackageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) NSString *selectedId;

@end

@implementation HXChoosePackageViewController

- (instancetype)init {
    if (self == [super init]) {
        _viewModel = [[HXChoosePackageViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择套餐";
    self.view.backgroundColor = ColorWithHex(0xF9F9F9);
    
    [self setUpNavigation];
    [self setUpTableView];
    [self showNullDataViewInView:self.view withTitle:@"暂未发布内容"];
    
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
    [self.viewModel rz_addTarget:self action:@selector(refererData) forKeyPathChange:RZDB_KP(HXChoosePackageViewModel, packageDic)];
}

- (void)refererData {
    self.commitButton.enabled = NO;
    [self.tableView reloadData];
    NSArray *personArray = [self.viewModel valueForKey:@"packagePersonArray"];
    NSArray *shopArray = [self.viewModel valueForKey:@"packageShopArray"];
    
    if (personArray.count > 0 || shopArray.count > 0) {
        [self hideExceptionView];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
        self.commitButton = [[UIButton alloc] init];
        self.commitButton.enabled = NO;
        [self.commitButton addTarget:self action:@selector(commitButton:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:self.commitButton];
        [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footerView).offset(15);
            make.right.equalTo(footerView).offset(-15);
            make.bottom.equalTo(footerView).offset(-15);
            make.height.mas_equalTo(50);
        }];
        [self.commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        [self.commitButton setBackgroundImage:[UIImage imageNamed:@"packageEnableButton"] forState:UIControlStateNormal];
        [self.commitButton setBackgroundImage:[UIImage imageNamed:@"packageDisableButton"] forState:UIControlStateDisabled];
        [self.commitButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.commitButton setTitleColor:ColorWithHex(0xffffff) forState:UIControlStateNormal];
        self.commitButton.layer.cornerRadius = 25;
        _tableView.tableFooterView = footerView;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[HXChoosePackageTableViewCell class] forCellReuseIdentifier:@"HXChoosePackageTableViewCell"];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.packageDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.viewModel.packageDic objectForKey:[NSString stringWithFormat:@"%ld",(long)section]]) {
        return ((NSArray *)[self.viewModel.packageDic objectForKey:[NSString stringWithFormat:@"%ld",(long)section]]).count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id obj = [self.viewModel.packageDic objectForKey:[NSString stringWithFormat:@"%ld",(long)section]];
    if (obj && ((NSArray *)obj).count > 0) {
        return 55;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXChoosePackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXChoosePackageTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HXChoosePackageTableViewCell alloc] init];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HXPackageModel *model = [[HXPackageModel alloc] init];
    if ([self.viewModel.packageDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) {
        model = [((NSArray *)[self.viewModel.packageDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) objectAtIndex:indexPath.row];
    }
    
    if ([model.id isEqualToString:self.selectedId]) {
        model.isChoosed = YES;
        self.commitButton.enabled = YES;
    }
    
    cell.model = model;
    
    __weak typeof(self) weadSelf = self;
    cell.hx_command = [[HXCommand alloc] initWithBlock:^(id input) {
        __strong __typeof (weadSelf) sself = weadSelf;
        if ([input isKindOfClass:[UIButton class]]) {
            UIButton *button = ((UIButton *)input);
            if ([button.superview.superview isMemberOfClass:[HXChoosePackageTableViewCell class]]) {
                HXChoosePackageTableViewCell *cell = (HXChoosePackageTableViewCell *)button.superview.superview;
                [sself.viewModel resetModel];
                cell.model.isChoosed = YES;
                sself.selectedId = model.id;
//                sself.commitButton.enabled = YES;
                
                [sself.tableView reloadData];
            }
        }
    }];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = ColorWithHex(0xF9F9F9);
    UILabel *label = [[UILabel alloc] init];
    if (section == 0) {
        label.text = @"个人会员套餐";
    } else {
        label.text = @"商家会员套餐";
    }
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = ColorWithHex(0x999999);
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.centerY.equalTo(headerView);
        make.size.mas_equalTo(label.intrinsicContentSize);
    }];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXPackageModel *model = [[HXPackageModel alloc] init];
    if ([self.viewModel.packageDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) {
        model = [((NSArray *)[self.viewModel.packageDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) objectAtIndex:indexPath.row];
    }
    
    HXPackageDetailViewController *controller = [[HXPackageDetailViewController alloc] init];
    controller.viewModel.id = model.id;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)commitButton:(UIButton *)button {
    // 此代码，只是为了，更新selectedId，不做下订单的id的取值来源。
    self.selectedId = [self.viewModel getSelectedId];
    
    __weak typeof(self) weadSelf = self;
    [self.viewModel buyPackageWithSucess:^(id value) {
        // 跳转到结果页
        __strong __typeof (weadSelf) sself = weadSelf;
        HXPartnerResultViewController *controller = [[HXPartnerResultViewController alloc] init];
        controller.viewModel.id = [NSString stringWithFormat:@"%@",value?value:@""];
        [sself.navigationController pushViewController:controller animated:YES];

        NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:sself.navigationController.viewControllers];
        for (UIViewController *vc in marr) {
            if ([vc isKindOfClass:[HXChoosePackageViewController class]]) {
                [marr removeObject:vc];
                break;
            }
        }
        sself.navigationController.viewControllers = marr;

        NSMutableArray *marr1 = [[NSMutableArray alloc] initWithArray:sself.navigationController.viewControllers];
        for (UIViewController *vc in marr1) {
            if ([vc isKindOfClass:[HXPartnerViewController class]]) {
                [marr removeObject:vc];
                break;
            }
        }
        sself.navigationController.viewControllers = marr;
    } failure:^{

    }];
}

- (void)dealloc {
//    NSLog(@"HXChoosePackageViewController dealloc.");
}

@end
