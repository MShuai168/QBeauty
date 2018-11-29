//
//  HXSettingViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/16.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXSettingViewController.h"
#import "HXAbountViewController.h"
#import "HXSecurityViewController.h"

@interface HXSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation HXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    [self hiddeKeyBoard];
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"设置";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = HXRGB(255, 255, 255);
}
-(void) hiddeKeyBoard{
    [self.view endEditing:YES];
}
-(void)createUI {
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    /**
     *  footView
     */
    
    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
    footView.backgroundColor = COLOR_BACKGROUND;
    [_tableView setTableFooterView:footView];
    
    /**
     *  登录
     */
    
    UIButton * loginButton = [[UIButton alloc] init];
    [loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginButton setTitleColor:ComonBackColor forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchUpInside];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:4];
    loginButton.enabled = YES;
    [Helper createImageWithColor:CommonBackViewColor button:loginButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:loginButton style:UIControlStateHighlighted];
    [footView addSubview:loginButton];
    [loginButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footView.mas_top).offset(40);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        cell.nameLabel.font  = [UIFont fontWithName:@".PingFangSC-Regular" size:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section==0) {
            cell.nameLabel.text = @"安全中心";
        }else {
        cell.nameLabel.text = @"关于我们";
        [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(0);
        }];
//        cell.titleLabel.text = SHORT_VERSION ? [NSString stringWithFormat:@"V%@ %@",SHORT_VERSION,BUILD_VERSION]:@"";
            cell.titleLabel.text = [NSString stringWithFormat:@"V%@",SHORT_VERSION];
        }
    }
    if (indexPath.section==0) {
        cell.titleLabel.hidden = YES;
    }else {
        cell.titleLabel.hidden = NO;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0.1;
    }
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==0) {
        HXSecurityViewController * serious = [[HXSecurityViewController alloc] init];
        serious.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serious animated:YES];
    } else {
        HXAbountViewController * about = [[HXAbountViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }
}

#pragma mark -- 退出登录
-(void)quitAction {
    [[UIAlertTool alloc] showAlertView:self :@"" :@"确认退出" :@"取消" :@"确认" :^{
        
        [MBProgressHUD showMessage:nil toView:self.view];
        [[HXNetManager shareManager] post:@"user/logout" parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
            [MBProgressHUD hideHUDForView:self.view];
            if ([responseNewModel.status isEqualToString:@"0000"]) {
                
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view];
        }];
        [[AppManager manager] signOutProgressHandler:self userInfo:nil];
        
    } :^{
        
        
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
