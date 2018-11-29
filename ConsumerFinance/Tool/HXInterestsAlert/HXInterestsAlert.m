//
//  HXInterestsAlert.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXInterestsAlert.h"
@interface HXInterestsAlert()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray * contentArr;
@property (nonatomic,strong)NSMutableArray * heightArr;
@end
@implementation HXInterestsAlert
-(id)initWithSureBlock:(void (^)())block {
    
    self = [super init];
    if (self) {
        self.sureBlock= block;
        [self archiveHeight];
        [self creatView];
    }
    return self;
}
-(void)creatView {

    self.backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    UIView * backView = [[UIView alloc] init];
    backView.layer.cornerRadius = 5;
    backView.backgroundColor = kUIColorFromRGB(0xffffff);
    [self  addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(108);
        make.bottom.equalTo(self).offset(-108);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
    }];
    
    
    UIView * headView = [[UIView alloc] init];
    headView.layer.cornerRadius = 15;
    headView.backgroundColor = kUIColorFromRGB(0xE7C18D);
    [backView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(15);
        make.width.mas_equalTo(120);
        make.centerX.equalTo(backView);
        make.height.mas_equalTo(30);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"权益说明";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = kUIColorFromRGB(0xFFFFFF);
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.centerX.equalTo(headView);
    }];
    
    
    UITableView * evaTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    evaTableView.delegate = self;
    evaTableView.dataSource = self;
    evaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    evaTableView.backgroundColor = kUIColorFromRGB(0xffffff);
    evaTableView.separatorStyle = NO;
    [backView addSubview:evaTableView];
    [evaTableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(67);
        make.right.equalTo(backView).offset(0);
        make.left.equalTo(backView).offset(0);
        make.bottom.equalTo(backView.mas_bottom).offset(-50);
    }];
    
    
    
    UIView * botomLine = [[UIView alloc] init];
    botomLine.backgroundColor = kUIColorFromRGB(0xE4E4E4);
    [backView addSubview:botomLine];
    [botomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).offset(-50.5);
        make.left.and.right.equalTo(backView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UIButton * sureBtn = [[UIButton alloc] init];
    [backView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kUIColorFromRGB(0xFB5B5E) forState:UIControlStateNormal];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView);
        make.bottom.equalTo(backView);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
    }];
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
   
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(15);
            make.right.equalTo(cell.contentView).offset(-15);
            make.top.equalTo(cell.contentView);
            CGFloat height = [[self.heightArr objectAtIndex:indexPath.section] floatValue];
            make.height.mas_equalTo(height);
        }];
        cell.nameLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.nameLabel.text = [self.contentArr objectAtIndex:indexPath.section];
    cell.nameLabel.numberOfLines = 0;
    CGFloat height = [[self.heightArr objectAtIndex:indexPath.section] floatValue];
    [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[self.heightArr objectAtIndex:indexPath.section] floatValue]+8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray * nameArr = @[@"趣贝奖励",@"专家面诊",@"美颜微针",@"四肢护理",@"全身护理",@"变美券"];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 32)];
    view.backgroundColor = kUIColorFromRGB(0xffffff);
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, SCREEN_WIDTH-90, 16)];
    nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    nameLabel.textColor = kUIColorFromRGB(0xE7C08B);
    nameLabel.text = [nameArr objectAtIndex:section];
    [view addSubview:nameLabel];
    
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)sureBtnAction {
    if (self.sureBlock) {
        self.sureBlock();
    }
}
-(void)archiveHeight {
    
    for (NSString * str  in self.contentArr) {
        CGFloat titleHeight = [Helper heightOfString:str font:[UIFont systemFontOfSize:13] width:SCREEN_WIDTH-90];
        
        [self.heightArr addObject:[NSString stringWithFormat:@"%f",titleHeight]];
    }
    
    
}

-(NSArray *)contentArr {
    if (_contentArr == nil) {
        _contentArr = @[@"普通会员：无趣贝奖励\n白金会员：可获得1.2倍订单趣贝奖励\n黄金会员：可获得1.5倍订单趣贝奖励\n铂金会员：可获得1.8倍订单趣贝奖励\n钻石会员：可获得2倍订单趣贝奖励",@"专家亲自操作，针对您的面部给出美丽解析方案，每月11日可联系官方客服获取面部诊疗的使用券，当月月底前有效，券不可累计",@"水光针/美白针/肉毒素/玻尿酸四类注射微整，每月11日可联系官方客服获取任意一项的使用券，当月月底前有效，券不可累计",@"包含去角质/保湿美白/理疗活血等项目的四肢养护套装，每月11日可联系官方客服获取使用券，当月月底前有效，券不可累计",@"包含活血按摩/淋巴排毒/全身舒压等项目的全身养护套装，每月11日可联系官方客服获取使用券，当月月底前有效，券不可累计",@"面值100元的变美券（线上线下通用），每月11日可联系官方客服获取变美券，当月月底前有效，每次仅限使用一张，不可累计使用"];
        
    }

    return _contentArr;
}
-(NSMutableArray *)heightArr {
    if (_heightArr == nil) {
        _heightArr = [[NSMutableArray alloc] init];
    }
    
    return _heightArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
