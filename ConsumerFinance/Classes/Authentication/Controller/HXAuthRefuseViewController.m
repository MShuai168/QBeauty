////
////  HXAuthRefuseViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/25.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXAuthRefuseViewController.h"
//
//@interface HXAuthRefuseViewController ()<UITableViewDelegate,UITableViewDataSource>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong) UIButton * referButton;
//@property (nonatomic,strong)UIView * headView;
//@property (nonatomic,strong)UILabel * promptLabel;//审核状态描述 申请金额
//@property (nonatomic,strong)UILabel * statesLabel;//审核状态
//@property (nonatomic,strong)UIView * backView ; //白色背景
//@end
//
//@implementation HXAuthRefuseViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXAuthRefuseViewModel alloc] initWithController:self];
//        self.viewModel.states = OrderStatuesCancel;
//        self.viewModel.orderType = orderTypeTenancy;
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self.viewModel archiveTypeFormotName];
//    [self createUI];
//    [self hiddeKeyBoard];
//    
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"订单取消";
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//    self.view.backgroundColor = HXRGB(255, 255, 255);
//}
//-(void) hiddeKeyBoard{
//    
//    [self.view endEditing:YES];
//    
//}
//-(void)createUI {
//    /**
//     *  tableView
//     */
//    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
//    _tableView.backgroundColor = COLOR_BACKGROUND;
//    [self.view addSubview:_tableView];
//    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//    }];
//    
//    /**
//     *  headView
//     */
//    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 86+15)];
//    self.headView = headView;
//    headView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableHeaderView:headView];
//    
//    UIView * backView = [[UIView alloc] init];
//    self.backView = backView;
//    backView.layer.cornerRadius = 5;
//    backView.layer.masksToBounds = YES;
//    backView.backgroundColor = kUIColorFromRGB(0xffffff);
//    [headView addSubview:backView];
//    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headView.mas_top).offset(15);
//        make.left.equalTo(headView).offset(15);
//        make.width.mas_equalTo(SCREEN_WIDTH-30);
//        make.height.mas_equalTo(71);
//    }];
//    
//    UILabel * statesLabel = [[UILabel alloc] init];
//    self.statesLabel = statesLabel;
//    statesLabel.font = [UIFont systemFontOfSize:18];
//    statesLabel.textColor = ComonBackColor;
//    [backView addSubview:statesLabel];
//    [statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backView.mas_left).offset(15);
//        make.top.equalTo(backView.mas_top).offset(15);
//    }];
//    
//    UILabel * promptLabel = [[UILabel alloc] init];
//    promptLabel.numberOfLines = 0;
//    self.promptLabel = promptLabel;
//    promptLabel.textColor = ComonCharColor;
//    promptLabel.font = [UIFont systemFontOfSize:13];
//    [backView addSubview:promptLabel];
//    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backView.mas_left).offset(15);
//        make.right.equalTo(backView.mas_right).offset(-15);
//        make.top.equalTo(backView.mas_top).offset(43);
//        make.height.mas_equalTo(13);
//    }];
//    
//    [self.viewModel replaceTitleWithTileBlock:^(NSString *title, NSString *description,float titleHeight) {
//        self.promptLabel.text = description.length?description:@"";
//        self.statesLabel.text = title.length?title:@"";
//        if (titleHeight != 0) {
//            [self.promptLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(titleHeight);
//            }];
//            [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(58+titleHeight);
//            }];
//            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30+58+titleHeight+15);
//            _tableView.tableHeaderView = self.headView;
//            
//            if (self.viewModel.states == OrderStatuesReplenish || self.viewModel.states == OrderStatuesCancel|| self.viewModel.states == OrderStatuesRefuse) {
//                self.statesLabel.textColor = ComonBackColor;
//            }
//        }
//        
//    }];
//    
//    /**
//     *  footView
//     */
//    
//    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
//    footView.backgroundColor = COLOR_BACKGROUND;
//    [_tableView setTableFooterView:footView];
//    
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 50)];
//    self.referButton  = referButton;
//    self.referButton.enabled = YES;
//    [referButton setTitle:@"返回" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0xffffff) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [footView addSubview:referButton];
//    
//}
//
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 4;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
//        return 3;
//    }else {
//        return [[self.viewModel.nameArr objectAtIndex:section-1] count];
//    }
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    static NSString *cellIdentity1 = @"IdentityInfoCell1";
//    if (indexPath.section == 0) {
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//        if (!cell) {
//            
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//            cell.nameLabel.font = [UIFont systemFontOfSize:11];
//            cell.nameLabel.textColor = ComonCharColor;
//            cell.titleLabel.font = [UIFont systemFontOfSize:11];
//            cell.titleLabel.textAlignment = NSTextAlignmentLeft;
//            cell.titleLabel.textColor = kUIColorFromRGB(0x151515);
//            [cell.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(cell.contentView);
//                make.right.equalTo(cell.contentView).offset(-15);
//                make.left.equalTo(cell.contentView).offset(70);
//            }];
//        }
//        if (indexPath.row==0) {
//            cell.nameLabel.text = @"订单编号:";
//        }else if (indexPath.row==1){
//            cell.nameLabel.text = @"创建时间:";
//        }else {
//            cell.nameLabel.text = @"取消时间:";
//
//        }
//        if (self.viewModel.informationArr.count >=indexPath.section+1) {
//            
//            NSArray * dataArr = [self.viewModel.informationArr objectAtIndex:indexPath.section];
//            if (dataArr.count>=indexPath.row+1) {
//                
//                cell.titleLabel.text = [dataArr objectAtIndex:indexPath.row];
//            }
//        }
//        
//
//        return cell;
//        
//
//    }else {
//        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
//        if (!cell) {
//            
//            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
//            cell.nameLabel.font = [UIFont systemFontOfSize:13];
//            cell.nameLabel.textColor = ComonCharColor;
//            cell.titleLabel.textAlignment = NSTextAlignmentRight;
//            cell.titleLabel.textColor = ComonTextColor;
//            [cell.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(cell.contentView);
//                make.right.equalTo(cell.contentView).offset(-15);
//                make.left.equalTo(cell.contentView).offset(100);
//            }];
//        }
//        cell.nameLabel.text = [[self.viewModel.nameArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
//        if (self.viewModel.informationArr.count >=indexPath.section+1) {
//            
//            NSArray * dataArr = [self.viewModel.informationArr objectAtIndex:indexPath.section];
//            if (dataArr.count>=indexPath.row+1) {
//                
//                cell.titleLabel.text = [dataArr objectAtIndex:indexPath.row];
//            }
//        }
//        return cell;
//
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section==0) {
//        return 18.5;
//    }
//    return 23;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section==0) {
//        return 5;
//    }else {
//    return 10;
//    }
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView * footView = [[UIView alloc] init];
//    footView.backgroundColor = kUIColorFromRGB(0xffffff);
//    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, section==0?5:10);
//    if (section==1||section==2) {
//        UIView * lineView = [[UIView alloc] init];
//        lineView.backgroundColor = HXRGB(221, 221, 221);
//        [footView addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(footView.mas_bottom).offset(0);
//            make.height.mas_equalTo(0.5);
//            make.left.equalTo(footView).mas_offset(15);
//            make.width.mas_equalTo(SCREEN_WIDTH-15);
//        }];
//        
//    }
//    return footView;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView * footView = [[UIView alloc] init];
//    footView.backgroundColor = kUIColorFromRGB(0xffffff);
//    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, section==0?5:10);
//    if (section==1) {
//       footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15);
//        UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
//        backView.backgroundColor = COLOR_BACKGROUND;
//        [footView addSubview:backView];
//        
//    }
//    
//    return footView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section==0) {
//        return 5;
//    }else {
//        return 10;
//    }
//}
//-(void)registerAction{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
