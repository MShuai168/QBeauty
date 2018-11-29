//
//  HXPartneInformationViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartneInformationViewController.h"
#import "HXPartnerBankViewController.h"
#import "HXChangeInformationViewController.h"
#import "HXPartneInformationModel.h"
@interface HXPartneInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HXChangeInforDelegate>
{
    UITableView *_tableView;
}
@end

@implementation HXPartneInformationViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXPartneInformationViewModel alloc] initWithController:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self hiddeKeyBoard];
    [self createUI];
    self.view.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [self request];
}
-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:NO];
}
    /*
     *
     *  导航栏
     */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"个人信息";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
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
   
}

-(void)request {
    [self.viewModel archiceInformationWithReturnBlock:^{
        [_tableView reloadData];
    } failBlock:^{
        
    }];
    
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else {
        return 2;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellIdentity = @"IdentityInfoCell";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameLabel.text = @"推荐码：";
            cell.nameLabel.textColor = ComonTextColor;
            cell.nameLabel.font = [UIFont systemFontOfSize:16];
            [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView).offset(15);
            }];
            cell.writeTextfield.font = [UIFont systemFontOfSize:16];
            cell.writeTextfield.enabled = NO;
            cell.writeTextfield.text = @"等级：";
        }
        cell.nameLabel.text = [NSString stringWithFormat:@"推荐码：%@",self.viewModel.inviterCodeStr.length!=0?self.viewModel.inviterCodeStr:@""];
        cell.writeTextfield.text =[NSString stringWithFormat:@"等级：%@",self.viewModel.gradeNameStr.length!=0?self.viewModel.gradeNameStr:@""];
        return cell;
    }else {
    static NSString *cellIdentity1 = @"IdentityInfoCell1";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell creatLine:0 hidden:NO];
        cell.writeTextfield.enabled = NO;
        cell.writeTextfield.textColor = ComonCharColor;
        cell.writeTextfield.font = [UIFont systemFontOfSize:14];
        cell.writeTextfield.tag = indexPath.row+indexPath.section*10;
        [cell.writeTextfield mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(0);
            make.centerY.equalTo(cell.contentView);
            make.top.and.bottom.equalTo(cell.contentView);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-50);
        }];
    }
        cell.writeTextfield.keyboardType = UIKeyboardTypeDefault;
        if (indexPath.row==0) {
            cell.nameLabel.text = @"个人信息";
            cell.writeTextfield.text = self.viewModel.nameStr.length!=0?self.viewModel.nameStr:@"";
        }else {
            cell.nameLabel.text = @"银行卡";
            cell.writeTextfield.text = @"";
        }
    return cell;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 64;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==0 ) {
        
        return 0.1;
    }
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            HXChangeInformationViewController * information = [[HXChangeInformationViewController alloc] init];
            information.delegate = self;
            [self.navigationController pushViewController:information animated:YES];
        }else {
            HXPartnerBankViewController * bank = [[HXPartnerBankViewController alloc] init];
            [self.navigationController pushViewController:bank animated:YES];
        }
    }
}

-(void)updateStates {
    
    [self request];
    
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
