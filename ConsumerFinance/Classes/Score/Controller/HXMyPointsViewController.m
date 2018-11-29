//
//  HXMyPointsViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyPointsViewController.h"
#import "ComButton.h"
#import "HXSelctArrowView.h"
#import "HXArrowSelectView.h"
#import "HXMyPointsCell.h"
#import "HXMyPointsModel.h"
#import "HXEarnScoreViewController.h"
#import "HXWKWebViewViewController.h"
#import "HXRecordViewController.h"
#define BtnTag 500
@interface HXMyPointsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic,strong)ComButton * selectKindBtn;//筛选
@property (nonatomic,strong)UILabel * pointLabel;
@end

@implementation HXMyPointsViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXMyPointsViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    [self hiddeKeyBoard];
    [self request];
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"我的趣贝";
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
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
    //上拉刷新
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [self creatHeadView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"兑换记录" forState:UIControlStateNormal];
    [button setTitleColor:ComonTitleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    // 设置尺寸
    CGSize fontSize = [@"兑换记录" sizeWithConstrainedSize:CGSizeMake(MAXFLOAT, 44)
                                                font:[UIFont systemFontOfSize:14]
                                         lineSpacing:0];
    button.bounds   = (CGRect){CGPointZero, fontSize};
    
    [button addTarget:self action:@selector(seachAction)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}
-(void)request {
    
    [self.viewModel archiveMyPointsWithReturnBlock:^{
        self.pointLabel.text = self.viewModel.score.length!=0?self.viewModel.score:@"0";
        [_tableView reloadData];
        [self stopRefresh];
    } fail:^{
        [self stopRefresh];
    }];
    
}
-(void)creatHeadView {
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 292)];
    headView.backgroundColor = CommonBackViewColor;
    _tableView.tableHeaderView = headView;
    
    UIImageView * pointBackView = [[UIImageView alloc] init];
    pointBackView.image = [UIImage imageNamed:@"jifenbg"];
    [headView addSubview:pointBackView];
    [pointBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.text = @"可用趣贝";
    titleLabel.textColor = CommonBackViewColor;
    [pointBackView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(42);
        make.centerX.equalTo(pointBackView);
    }];
    
    UILabel * pointLabel = [[UILabel alloc] init];
    self.pointLabel = pointLabel;
    pointLabel.textColor = CommonBackViewColor;
    pointLabel.text = @"0";
    pointLabel.font = [UIFont systemFontOfSize:24];
    [pointBackView addSubview:pointLabel];
    [pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pointBackView);
        make.top.equalTo(headView).offset(54);
        make.width.mas_lessThanOrEqualTo(80);
    }];
    
    UIImageView * botImageView = [[UIImageView alloc] init];
    botImageView.image = [UIImage imageNamed:@"jifenbgshadow"];
    [headView addSubview:botImageView];
    [botImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pointBackView);
        make.top.equalTo(pointBackView.mas_bottom).offset(5);
    }];
    
    
    UILabel * promptLabel = [[UILabel alloc] init];
    promptLabel.font = [UIFont systemFontOfSize:14];
    promptLabel.textColor = kUIColorFromRGB(0xcccccc);
    promptLabel.text = @"信用点滴积累  生活美丽绽放";
    [pointBackView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(153);
        make.centerX.equalTo(headView);
    }];
    
    
    UIView * convertBackView = [[UIView alloc] init];
    convertBackView.userInteractionEnabled = YES;
    pointBackView.userInteractionEnabled = YES;
    headView.userInteractionEnabled = YES;
    convertBackView.backgroundColor = kUIColorFromRGB(0xfafafa);
    convertBackView.layer.cornerRadius = 25;
    [headView addSubview:convertBackView];
    [convertBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.top.equalTo(promptLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    
    for (int i = 0; i < 2; i++) {
        ComButton * btn = [[ComButton alloc] init];
        [btn addTarget:self action:@selector(zjfBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [convertBackView addSubview:btn];
        btn.tag = i+BtnTag;
        btn.photoImage.image = [UIImage imageNamed:i==0?@"zhuanjifen":@"jifenduihuan"];
        [btn.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn.mas_centerX).offset(-15);
            make.centerY.equalTo(btn);
        }];
        btn.nameLabel.text = i==0?@"赚趣贝":@"趣贝兑换";
        btn.nameLabel.textColor = kUIColorFromRGB(0xFF8730);
        btn.nameLabel.font = [UIFont systemFontOfSize:15];
        [btn.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn);
            make.left.equalTo(btn.mas_centerX).offset(-10);
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(convertBackView).offset((SCREEN_WIDTH-30)/2*i);
            make.top.and.bottom.equalTo(convertBackView);
            make.width.mas_equalTo((SCREEN_WIDTH-30)/2);
        }];
        
    }
    
    UIView * linView = [[UIView alloc] init];
    linView.backgroundColor = kUIColorFromRGB(0xcccccc);
    [convertBackView addSubview:linView];
    [linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.top.equalTo(convertBackView).offset(15);
        make.bottom.equalTo(convertBackView).offset(-15);
        make.width.mas_equalTo(0.5);
    }];
    
    
    UILabel * integrationDetailsLabel = [[UILabel alloc] init];
    integrationDetailsLabel.text = @"趣贝明细";
    integrationDetailsLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    integrationDetailsLabel.textColor = ComonTextColor;
    [headView addSubview:integrationDetailsLabel];
    [integrationDetailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(15);
        make.bottom.equalTo(headView).offset(-15);
    }];
    
    
    ComButton * selectKindBtn = [[ComButton alloc] init];
    self.selectKindBtn = selectKindBtn;
    selectKindBtn.nameLabel.text = @"全部";
    [selectKindBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    selectKindBtn.nameLabel.font = [UIFont systemFontOfSize:15];
    selectKindBtn.nameLabel.textColor = kUIColorFromRGB(0x555555);
    [headView addSubview:selectKindBtn];
    [selectKindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headView);
        make.bottom.equalTo(headView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [selectKindBtn.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(selectKindBtn).offset(-32);
        make.top.equalTo(selectKindBtn);
    }];
    
    selectKindBtn.photoImage.image = [UIImage imageNamed:@"minimaldown"];
    [selectKindBtn.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(selectKindBtn.nameLabel);
        make.right.equalTo(selectKindBtn).offset(-15);
    }];
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kUIColorFromRGB(0xE5E5E5);
    [headView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headView);
        make.left.equalTo(headView).offset(15);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
    }];
    
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HXMyPointsModel * model = [self.viewModel.dataArr objectAtIndex:section];
    return model.scoreRecords.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    HXMyPointsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[HXMyPointsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        [cell creatLine:30 hidden:NO];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH-45);
        }];
    }
    HXMyPointsModel * model = [self.viewModel.dataArr objectAtIndex:indexPath.section];
    cell.model = [model.scoreRecords objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 73;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 54;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HXMyPointsModel * model = [self.viewModel.dataArr objectAtIndex:section];
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,54)];
    headView.backgroundColor = CommonBackViewColor;
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = ComonTextColor;
    [headView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(30);
        make.width.mas_equalTo(2);
        make.centerY.equalTo(headView);
        make.height.mas_equalTo(14);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    titleLabel.textColor = ComonTextColor;
    titleLabel.text = model.monthDate.length!=0?model.monthDate:@"";
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.left.equalTo(headView).offset(37);
    }];
    
    UILabel * usePoints = [[UILabel alloc] init];
    usePoints.text = model.monthSpendScore.length!=0?model.monthSpendScore:@"";
    usePoints.textColor = kUIColorFromRGB(0x101010);
    usePoints.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    [headView addSubview:usePoints];
    [usePoints mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headView).offset(-35/2);
        make.centerY.equalTo(headView);
        make.width.mas_lessThanOrEqualTo(80);
    }];
    
    UILabel * syLabel = [[UILabel alloc] init];
    syLabel.textColor = ComonTextColor;
    syLabel.text = @"使用:";
    syLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:syLabel];
    [syLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(usePoints.mas_left).offset(-5);
        make.centerY.equalTo(headView);
    }];

    UILabel * archivePointLabel = [[UILabel alloc] init];
    archivePointLabel.text = model.monthGetScore.length!=0?model.monthGetScore:@"";
    archivePointLabel.textColor = kUIColorFromRGB(0xFF8730);
    archivePointLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [headView addSubview:archivePointLabel];
    [archivePointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(syLabel.mas_left).offset(-15);
        make.centerY.equalTo(headView);
        make.width.mas_lessThanOrEqualTo(80);
    }];
    
    UILabel * hqLabel = [[UILabel alloc] init];
    hqLabel.textColor = ComonTextColor;
    hqLabel.text = @"获取:";
    hqLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:hqLabel];
    [hqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(archivePointLabel.mas_left).offset(-5);
        make.centerY.equalTo(headView);
    }];
    
    if (SCREEN_WIDTH<=320) {
        usePoints.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
        syLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.font = [UIFont systemFontOfSize:13];
        hqLabel.font = [UIFont systemFontOfSize:13];
        archivePointLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [usePoints mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headView).offset(-35/2);
            make.centerY.equalTo(headView);
            make.width.mas_lessThanOrEqualTo(55);
        }];
        
        [archivePointLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(syLabel.mas_left).offset(-5);
            make.centerY.equalTo(headView);
            make.width.mas_lessThanOrEqualTo(55);
        }];
    }
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kUIColorFromRGB(0xE5E5E5);
    [headView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headView);
        make.left.equalTo(headView).offset(30);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-45);
    }];
    
    return headView;
}

-(void)selectBtnAction {
    CGRect oldframe = [_selectKindBtn convertRect:_selectKindBtn.bounds toView:[UIApplication sharedApplication].keyWindow];
    CGPoint point = CGPointMake(self.selectKindBtn.origin.x,oldframe.origin.y+17);
    HXArrowSelectView *view1 = [[HXArrowSelectView alloc] initWithOrigin:point selectBlock:^(NSInteger tag){
        if (tag == 0) {
            self.selectKindBtn.nameLabel.text = @"全部";
            self.viewModel.archiveType = 2;
        }else if (tag==1) {
            self.selectKindBtn.nameLabel.text = @"获取";
            self.viewModel.archiveType = 1;
        }else {
            self.selectKindBtn.nameLabel.text = @"使用";
            self.viewModel.archiveType = 0;
        }
        self.viewModel.pageIndex = 1;
        [self request];
    }];
    [view1 popView];
}
-(void)zjfBtnAction:(ComButton *)btn {
    if (btn.tag == BtnTag) {
        HXEarnScoreViewController *controller = [[HXEarnScoreViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else {
        HXWKWebViewViewController *controller = [[HXWKWebViewViewController alloc] init];
        controller.title = @"趣贝兑换";
        NSString * url  = [NSString stringWithFormat:@"%@scorelist/0/%@",kScoreUrl, K_CURRENT_TIMESTAMP];
        controller.url = url;
        controller.isTransparente = NO;
        [self.navigationController pushViewController:controller animated:YES];
        
    }
}
-(void)loadNewTopic:(UITableView *)tableView  {
    self.viewModel.pageIndex = 1;
    [self request];
}
-(void)loadMoreTopic:(UITableView *)tableView {
    self.viewModel.pageIndex ++;
    [self request];
}
-(void)stopRefresh {
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}
-(void)seachAction {
    HXRecordViewController * record = [[HXRecordViewController alloc] init];
    [self.navigationController pushViewController:record animated:YES];
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
