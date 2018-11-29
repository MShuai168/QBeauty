//
//  HXMessageViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMessageViewController.h"
#import "HXMessageCell.h"
#import "HSystemNotificationXViewController.h"

@interface HXMessageViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
}

@end

@implementation HXMessageViewController

- (instancetype)init {
    if (self == [super init]) {
        _viewModel = [[HXMessageViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:NO];
    [self request];
}
-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}
/**
*  导航栏
*/
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"消息";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = HXRGB(255, 255, 255);
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
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
}

- (void)request {
    NSDictionary *head = @{@"tradeCode" : @"0203",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"userUuid":[AppManager manager].userInfo.userId};
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         //最新订单提醒
                                                         NSDictionary *firstOrder = [object.body objectForKey:@"firstOrder"];
                                                         self.viewModel.firstOrderModel = [MessageModel mj_objectWithKeyValues:firstOrder];
                                                         self.viewModel.firstOrderModel.readNumber = [object.body objectForKey:@"orderNotReadCount"]?[object.body objectForKey:@"orderNotReadCount"]:@"";
                                                         //最新还款提醒
                                                         NSDictionary *firstRefund = [object.body objectForKey:@"firstRefund"];
                                                         self.viewModel.firstRefundModel = [MessageModel mj_objectWithKeyValues:firstRefund];
                                                         self.viewModel.firstRefundModel.readNumber = [object.body objectForKey:@"refundNotReadCount"]?[object.body objectForKey:@"refundNotReadCount"]:@"";
                                                         //最新系统信息
                                                         NSDictionary *firstSysNotice = [object.body objectForKey:@"firstSysNotice"];
                                                         self.viewModel.firstSysNoticeModel = [MessageModel mj_objectWithKeyValues:firstSysNotice];
                                                         self.viewModel.firstSysNoticeModel.readNumber = [object.body objectForKey:@"sysNoticeCount"]?[object.body objectForKey:@"sysNoticeCount"]:@"";
                                                         
                                                         [_tableView reloadData];
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                 }];
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    HXMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[HXMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    if (indexPath.row==0) {
        cell.photoImage.image = [UIImage imageNamed:@"inform"];
        cell.nameLabel.text = @"系统通知";
        cell.contentLabel.text = self.viewModel.firstSysNoticeModel.noticeDetail.length?self.viewModel.firstSysNoticeModel.noticeDetail:@"暂无";
        if (self.viewModel.firstSysNoticeModel.readNumber.length > 0 && [self.viewModel.firstSysNoticeModel.readNumber intValue]>0) {
            cell.numberView.hidden = NO;
            cell.numberLabel.text = self.viewModel.firstSysNoticeModel.readNumber;
        } else {
            cell.numberView.hidden = YES;
        }
        [cell creatLine:15 hidden:NO];
    }else if(indexPath.row==1) {
        cell.photoImage.image = [UIImage imageNamed:@"messOrder"];
        cell.nameLabel.text = @"订单通知";
        cell.contentLabel.text = @"暂无";
        if (self.viewModel.firstOrderModel.noticeDetail.length > 0) {
            cell.contentLabel.text = self.viewModel.firstOrderModel.noticeDetail;
            cell.timeLabel.text =self.viewModel.firstOrderModel.createdTime.length!=0?self.viewModel.firstOrderModel.createdTime:@"";
        }
        if (self.viewModel.firstOrderModel.readNumber.length > 0 && [self.viewModel.firstOrderModel.readNumber intValue]>0) {
            cell.numberView.hidden = NO;
            cell.numberLabel.text = self.viewModel.firstOrderModel.readNumber;
        } else {
            cell.numberView.hidden = YES;
        }
        [cell creatLine:15 hidden:NO];
    }else {
        cell.photoImage.image = [UIImage imageNamed:@"messrepayment"];
        cell.contentLabel.text = @"暂无";
        if (self.viewModel.firstRefundModel.noticeDetail.length > 0) {
            cell.contentLabel.text = self.viewModel.firstRefundModel.noticeDetail;
        }
        if (self.viewModel.firstRefundModel.readNumber.length > 0 && [self.viewModel.firstRefundModel.readNumber intValue]>0) {
            cell.numberView.hidden = NO;
            cell.numberLabel.text = self.viewModel.firstRefundModel.readNumber;
        } else {
            cell.numberView.hidden = YES;
        }
        cell.nameLabel.text = @"还款提醒";
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 73;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HSystemNotificationXViewController * notifi = [[HSystemNotificationXViewController alloc] init];
    if (indexPath.row==0) {
        notifi.viewModel.type = MessageSystem;
    }else if(indexPath.row == 1) {
        notifi.viewModel.type = MessageOrder;
    }else {
        notifi.viewModel.type = MessageRepayment;
    }
    [self.navigationController pushViewController:notifi animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
