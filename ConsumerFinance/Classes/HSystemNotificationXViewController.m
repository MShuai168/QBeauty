//
//  HSystemNotificationXViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HSystemNotificationXViewController.h"
#import "HXSystemNotificationCell.h"
#import "MessageModel.h"
#import "HXMessageDetailsViewController.h"
#import "HXOrderViewController.h"
#import "HXBillViewController.h"

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface HSystemNotificationXViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
}
@end

@implementation HSystemNotificationXViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXSystmNotificationViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    [self archiveDetails];

}
-(void)archiveDetails {
    [self.viewModel getNotification:^{
        [_tableView reloadData];
    } withFailureBlock:^{
        
    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:NO];
}
-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self.viewModel.type == MessageSystem) {
        
        self.title = @"系统通知";
    }else if(self.viewModel.type == MessageRepayment){
        self.title =@"还款提醒";
    }else {
        self.title = @"订单提醒";
    }
    
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = COLOR_BACKGROUND;
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
    [_tableView registerClass:[HXSystemNotificationCell class] forCellReuseIdentifier:@"IdentityInfoCell"];
    [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"IdentityInfoCell1"];
    //IdentityInfoCell1
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.notificationContents.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    static NSString *cellIdentity1 = @"IdentityInfoCell1";
    if (indexPath.row==0) {
        HXSystemNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[HXSystemNotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        return [self configCell:cell tableView:tableView indexPath:indexPath];
    }
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
    }
    
    [cell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell).offset(15);
        make.right.equalTo(cell).offset(-15);
        make.top.bottom.equalTo(cell);
    }];
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.rightButton setImage:[UIImage imageNamed:@"NextButton"] forState:UIControlStateNormal];
    [cell.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView).offset(-15);
    }];
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.nameLabel.text =@"查看详情";
    
    return cell;
    
}

- (HXSystemNotificationCell *)configCell:(HXSystemNotificationCell *)cell tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        MessageModel *messageModel = [[MessageModel alloc] init];
        messageModel = self.viewModel.notificationContents[indexPath.section];
        if (messageModel.typeName.length==0) {
            if (self.viewModel.type == MessageSystem) {
                
                cell.nameLabel.text = @"系统通知";
            }else if(self.viewModel.type == MessageRepayment){
                cell.nameLabel.text =@"还款提醒";
            }else {
                cell.nameLabel.text = @"订单提醒";
            }
        }else {
           
            cell.nameLabel.text = messageModel.typeName;
        }
        
        
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:messageModel.noticeDetail];
        NSMutableParagraphStyle   *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
        //行间距
        [paragraphStyle setLineSpacing:5.0];
        [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [messageModel.noticeDetail length])];
        cell.contentLabel.attributedText = att;
        
        if (self.viewModel.type != MessageSystem) {
            [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView).offset(41);
            }];
        }
        
        [cell.contentView layoutIfNeeded];
        
        return cell;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        if (self.viewModel.type == MessageSystem) {
            return 74;
        }else {
            CGFloat height = [tableView fd_heightForCellWithIdentifier:@"IdentityInfoCell" cacheByIndexPath:indexPath configuration:^(HXSystemNotificationCell *cell) {
                [self configCell:cell tableView:tableView indexPath:indexPath];
            }];
            return height;
        }
        
    } else {
        return 43;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 46;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.viewModel.type) {
        case MessageSystem:{
            HXMessageDetailsViewController *controller = [[HXMessageDetailsViewController alloc] init];
            MessageModel *messageModel = [[MessageModel alloc] init];
            messageModel = self.viewModel.notificationContents[indexPath.section];
            controller.noticeId = messageModel.id;
            
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case MessageOrder:{
//            HXOrderViewController *controller = [[HXOrderViewController alloc] init];
//
//            [self.navigationController pushViewController:controller animated:YES];
        }
            
            break;
        case MessageRepayment: {
//            HXBillViewController *controller = [[HXBillViewController alloc] init];
//            
//            [self.navigationController pushViewController:controller animated:YES];
        }
            
            break;
            
        default:
            break;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 46)];
    
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = kUIColorFromRGB(0xcccccc);
    [view addSubview:backView];
    backView.layer.cornerRadius = 12;
    backView.layer.masksToBounds = YES;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.centerY.equalTo(view);
        make.height.mas_offset(25);
        make.width.mas_offset(98);
    }];
    
    UILabel * timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kUIColorFromRGB(0xffffff);
    timeLabel.font = [UIFont systemFontOfSize:11];
    
    MessageModel *messageModel = [[MessageModel alloc] init];
    messageModel = self.viewModel.notificationContents[section];
    
    timeLabel.text = messageModel.createdAt;
    [backView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.centerX.equalTo(backView);
    }];
    
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
