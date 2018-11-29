////
////  HXBillingdetailsViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/16.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXBillingdetailsViewController.h"
//#import "HXBillingdetailsCell.h"
//#import "HXPayConfirmViewController.h"
//#import "HXIdCardVerificationViewController.h"
//#import "HXAddBankViewController.h"
//#import "CertificationViewController.h"
//#import "HXBillViewController.h"
//#import "HXBillDetailsModel.h"
//
//#import <RZDataBinding/RZDataBinding.h>
//
//@interface HXBillingdetailsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,forgotPassWordDelegate,billdetailDelegate>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong)UILabel * moneyLabel;//金额
//@property (nonatomic,strong)UILabel * punishLabel;//罚息
//@property (nonatomic,strong)UILabel * orderLabel;//订单号
//@property (nonatomic,strong)UILabel * dateLabel;
//@property (nonatomic,strong)UILabel * totalLabel;
//
//@property (nonatomic,strong)UILabel * titleLabel;//文本提示
//@property (nonatomic,strong)UIButton * referButton;
//@property (nonatomic,strong)UILabel * bottomLabel;
//@end
//
//@implementation HXBillingdetailsViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXBillingdetailsViewModel alloc] initWithController:self];
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
//    [self request];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(archiviewBank) name:Notification_BankCard  object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePassStates) name:Notification_BankPassWord  object:nil];
//}
//-(void)viewWillAppear:(BOOL)animated {
//    
//    [self hiddenNavgationBarLine:YES];
//    [self setNavigationBarBackgroundColor:kUIColorFromRGB(0xE6BF73)];
//
//}
//-(void)viewWillDisappear:(BOOL)animated {
//    [self hiddenNavgationBarLine:NO];
//    [self setNavigationBarBackgroundColor:HXRGB(255, 255, 255)];
//    
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:@"backButtonW"];
//    self.view.backgroundColor = HXRGB(255, 255, 255);
//    [self setNavigationBarBackgroundColor:kUIColorFromRGB(0xE6BF73)];
//    [self setControllerTitle:@"账单详情" titleColor:HXRGB(255, 255, 255)];
//}
//
//-(void) hiddeKeyBoard{
//    [self.view endEditing:YES];
//}
//
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
//    _tableView.backgroundColor = HXRGB(255, 255, 255);
//    [self.view addSubview:_tableView];
//    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top);
//        make.right.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-75);
//    }];
//    
//    /**
//     *  headView
//     */
//    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 195)];
//    headView.backgroundColor = kUIColorFromRGB(0xE6BF73);
//    _tableView.tableHeaderView = headView;
//    
//    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
//    topView.backgroundColor  = [kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.5];
//    [headView addSubview:topView];
//    
//    UIImageView * image = [[UIImageView alloc] init];
//    image.image = [UIImage imageNamed:@"orderfail"];
//    [topView addSubview:image];
//    [image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(topView).offset(15);
//        make.centerY.equalTo(topView);
//        make.height.and.width.mas_equalTo(15);
//        
//    }];
//    
//    UILabel * topLabel = [[UILabel alloc] init];
//    topLabel.text = @"每天22:00到凌晨3:00无法还款";
//    topLabel.font = [UIFont systemFontOfSize:13];
//    topLabel.textColor = ComonBackColor;
//    [topView addSubview:topLabel];
//    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(topView);
//        make.left.equalTo(topView).mas_equalTo(40);
//    }];
//    
//    UILabel * titleLabel = [[UILabel alloc] init];
//    self.titleLabel = titleLabel;
////    self.titleLabel.text = @"还款总额(元)";
//    titleLabel.font = [UIFont systemFontOfSize:13];
//    titleLabel.textColor = kUIColorFromRGB(0xffffff);
//    [headView addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(headView);
//        make.top.equalTo(headView).offset(55);
//    }];
//    /**
//     *  金额
//     */
//    UILabel * moneyLabel = [[UILabel alloc] init];
//    self.moneyLabel = moneyLabel;
////    moneyLabel.text  = @"100";
//    moneyLabel.font = [UIFont systemFontOfSize:20];
//    moneyLabel.textColor = kUIColorFromRGB(0xffffff);
//    [headView addSubview:moneyLabel];
//    [headView addSubview:moneyLabel];
//    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleLabel.mas_bottom).offset(15);
//        make.centerX.equalTo(headView);
//    }];
//    
//    /**
//     *  罚息
//     */
//    UILabel * punishLabel = [[UILabel alloc] init];
//    self.punishLabel = punishLabel;
//    punishLabel.font = [UIFont systemFontOfSize:11];
//    punishLabel.textColor = kUIColorFromRGB(0xffffff);
//    [headView addSubview:punishLabel];
//    [headView addSubview:punishLabel];
//    [punishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(moneyLabel.mas_bottom).offset(10);
//        make.centerX.equalTo(headView);
//    }];
//    /**
//     *  底部视图
//     */
//    UIView * botView = [[UIView alloc] init];
//    botView.backgroundColor = [kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.1];
//    [headView addSubview:botView];
//    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(headView);
//        make.bottom.equalTo(headView.mas_bottom).offset(0);
//        make.height.mas_equalTo(35);
//    }];
//    /**
//     *  订单号
//     */
//    UILabel * orderLabel = [[UILabel alloc] init];
//    self.orderLabel = orderLabel;
//    orderLabel.font = [UIFont systemFontOfSize:11];
//    orderLabel.textColor = kUIColorFromRGB(0xffffff);
//    [botView addSubview:orderLabel];
//    [headView addSubview:orderLabel];
//    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(botView);
//        make.left.equalTo(botView).offset(15);
//    }];
//    
//    /**
//     *  日期
//     */
//    UILabel * dateLabel = [[UILabel alloc] init];
//    self.dateLabel = dateLabel;
//    dateLabel.font = [UIFont systemFontOfSize:11];
//    dateLabel.textColor = kUIColorFromRGB(0xffffff);
//    [botView addSubview:dateLabel];
//    [headView addSubview:dateLabel];
//    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(botView);
//        make.right.equalTo(botView.mas_right).offset(-15);
//    }];
////    /**
////     *  切换
////     */
////    UIButton * switchButton = [[UIButton alloc] init];
////    [switchButton setImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
////    [botView addSubview:switchButton];
////    [switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerY.equalTo(botView);
////        make.right.equalTo(botView.mas_right).offset(-15);
////    }];
//    
//    UILabel * bottomLabel = [[UILabel alloc] init];
//    self.bottomLabel = bottomLabel;
//    bottomLabel.hidden = YES;
////    bottomLabel.backgroundColor = CommonBackViewColor;
//    bottomLabel.font = [UIFont systemFontOfSize:16];
//    bottomLabel.textAlignment = NSTextAlignmentCenter;
//    bottomLabel.textColor = ComonCharColor;
//    [self.view addSubview:bottomLabel];
//    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view);
//        make.height.mas_equalTo(80);
//        make.left.and.right.mas_equalTo(self.view);
//    }];
//    
//    UIView * lineView = [[UIView alloc] init];
//    lineView.backgroundColor = kUIColorFromRGB(0xeeeeee);
//    [bottomLabel addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(bottomLabel);
//        make.left.equalTo(bottomLabel);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(0.5);
//    }];
//    
//    /**
//     *  footView
//     */
//
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT-129, SCREEN_WIDTH-30, 50)];
//    self.referButton = referButton;
//    [referButton setTitle:@"立即还款" forState:UIControlStateNormal];
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [self.view addSubview:referButton];
//    
//    [self.referButton rz_bindKey:RZDB_KP(UIButton, hidden) toKeyPath:RZDB_KP(HXBillingdetailsViewModel, isGreen) ofObject:self.viewModel];
//}
//
//-(void)request {
//     [MBProgressHUD showMessage:nil toView:self.view];
//    
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    //获取支付密码
//    [self.viewModel archivePassWordHaveBoolWithReturnBlock:^{
//        
//        dispatch_semaphore_signal(semaphore);
//    }];
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    });
//    
//    
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    
//    [self.viewModel archiveDetailWithReturnBlock:^{
//        dispatch_semaphore_signal(semaphore);
//        if (self.viewModel.squareBool) {
//            
//            self.titleLabel.text = @"本账单已结清";
//            self.titleLabel.font = [UIFont systemFontOfSize:24];
//            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(_tableView.tableHeaderView).offset(-18);
//            }];
//            
//            self.referButton.hidden = YES;
//            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(self.view.mas_bottom).offset(0);
//            }];
//            
//        }else {
//            [self isBetweenHour];
//            self.titleLabel.text = @"还款总额(元)";
//            for (HXBillDetailsModel * model in self.viewModel.voListArr) {
//                if ([model.isDefault boolValue] && [model.canChoose boolValue]) {
//                    model.haveSelect = YES;
//                    self.viewModel.selectMoney = model.payamt;
//                   self.viewModel.interest = [NSString stringWithFormat:@"%.2f",[model.interest floatValue]];
//                   self.viewModel.selctDate = model.currentPeriods;
//                    if ([self.viewModel.interest floatValue]>0) {
//                        
//                        self.punishLabel.text = [NSString stringWithFormat:@"(含罚息: %@)",self.viewModel.interest];
//                        self.punishLabel.hidden = NO;
//                    }else {
//                        self.punishLabel.hidden = YES;
//                    }
//                    
//                }
//            }
//            self.moneyLabel.text = self.viewModel.selectMoney?self.viewModel.selectMoney:@"0.00";
//            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.moneyLabel.text]];
//            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:35] range:NSMakeRange(1, self.moneyLabel.text.length)];
//            self.moneyLabel.attributedText = attributedString;
//        }
//        self.orderLabel.text = self.viewModel.orderNo?[NSString stringWithFormat:@"订单号: %@",self.viewModel.orderNo] :@"";
//        self.dateLabel.text = self.viewModel.createDate?self.viewModel.createDate:@"";
//        [_tableView reloadData];
//        if (self.viewModel.isGreen) {
//            self.referButton.hidden = YES;
//            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(self.view.mas_bottom).offset(-80);
//            }];
//            self.bottomLabel.hidden = NO;
//            [self.bottomLabel setText:self.viewModel.repayMoneStr.length!=0?self.viewModel.repayMoneStr:@"暂不支持主动还款，仅支持自动划扣"];
//        }
//
//    } failBlock:^{
//        dispatch_semaphore_signal(semaphore);
//    }];
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    });
//    
//    
//    
//    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//           [MBProgressHUD hideHUDForView:self.view];
//        });
//        
//        
//    });
//    
//}
//
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.viewModel.voListArr.count;
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    HXBillingdetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[HXBillingdetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//    }
//    cell.topLine.hidden = NO;
//    cell.botLine.hidden = NO;
//    if (indexPath.row==0) {
//        [cell.photoImage setBackgroundImage:nil forState:UIControlStateNormal];
//        cell.topLine.hidden = YES;
//    }
//    if ((self.viewModel.voListArr.count -  indexPath.row)==1) {
//        cell.botLine.hidden = YES;
//    }
//    cell.delegate = self;
//    cell.index = indexPath;
//
//    cell.model = [self.viewModel.voListArr objectAtIndex:indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 60;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 46;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    HXBillDetailsModel * model = [self.viewModel.voListArr objectAtIndex:indexPath.row];
//    if ([model.canChoose boolValue] && model.firstSelect) {
//        
//        [self selectAction:indexPath];
//    }
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
//    view.backgroundColor = HXRGB(255, 255, 255);
//    
//    
//    UILabel * nameLabel = [[UILabel alloc] init];
//    nameLabel.font = [UIFont systemFontOfSize:13];
//    nameLabel.textColor = ComonCharColor;
//    [view addSubview:nameLabel];
//    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(view.mas_left).offset(15);
//        make.centerY.equalTo(view);
//    }];
//    nameLabel.text = @"全部账期";
//    
//    UILabel * totalLabel = [[UILabel alloc] init];
//    totalLabel.font = [UIFont systemFontOfSize:13];
//    totalLabel.textColor = ComonCharColor;
//    [view addSubview:totalLabel];
//    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(view.mas_right).offset(-15);
//        make.centerY.equalTo(view);
//    }];
//    self.totalLabel = totalLabel;
//  self.totalLabel.text = [NSString stringWithFormat:@"账单本金: %@",self.viewModel.orderMoney?self.viewModel.orderMoney:@"0.00"];
//    
//    UIView * linView = [[UIView alloc] init];
//    linView.backgroundColor = kUIColorFromRGB(0xE6E6E6);
//    [view addSubview:linView];
//    [linView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(0.5);
//        make.left.equalTo(view.mas_left).offset(15);
//        make.right.equalTo(view.mas_right).offset(-15);
//        make.bottom.equalTo(view.mas_bottom).offset(0);
//    }];
//    
//    
//    return view;
//}
//
//#pragma mark -- 立即还款
//-(void)registerAction {
//    if (self.viewModel.betweenTimeBool) {
//        [KeyWindow displayMessage:@"太晚了，我们打烊了~"];
//        return;
//    }
//    if ([self.viewModel.selectMoney doubleValue] >0.00) {
//        if (self.viewModel.bankArr.count!=0) {
//            [self presentRepayment];
//            return;
//        }
//        [self.viewModel archiveBankListWithReturnBlock:^{
//            if (self.viewModel.bankArr.count==0) {
//                [[UIAlertTool alloc] showAlertView:self :@"" :@"添加银行卡" :@"取消" :@"确认" :^{
//                    [self addBankAction];
//                } :^{
//                    
//                }];
//                
//            }else {
//                [self presentRepayment];
//            }
//        }];
//    }else {
//        
//        [KeyWindow displayMessage:@"请选择还款金额"];
//    }
//    
//    
//}
//
//-(void)addBankAction {
//    if ([Helper authBool:self.viewModel.authBool]) {
//        HXAddBankViewController * bank = [[HXAddBankViewController alloc] init];
//        bank.viewModel.orderNo = self.viewModel.orderNo;
//        bank.viewModel.nameStr = self.viewModel.nameStr;
//        bank.viewModel.idCardStr = self.viewModel.idCardNumber;
//        [self.navigationController pushViewController:bank animated:YES];
//        
//    }else {
//        [self.viewModel archiveBaseInformationWithReturnBlock:^{
//            
//            if (![Helper authBool:self.viewModel.authBool]) {
//                [[UIAlertTool alloc] showAlertView:self :@"" :@"请先进行实名认证" :@"取消" :@"去设置" :^{
//                    CertificationViewController * certification = [[CertificationViewController alloc] init];
//                    [self.navigationController pushViewController:certification animated:YES];
//                    
//                } :^{
//                    
//                    
//                }];
//                return;
//            }
//            HXAddBankViewController * bank = [[HXAddBankViewController alloc] init];
//            bank.viewModel.orderNo = self.viewModel.orderNo;
//            bank.viewModel.nameStr = self.viewModel.nameStr;
//            bank.viewModel.idCardStr = self.viewModel.idCardNumber;
//            [self.navigationController pushViewController:bank animated:YES];
//        }];
//    }
//}
//
//
//-(void)presentRepayment {
//    
//    HXPayConfirmViewController *controller = [[HXPayConfirmViewController alloc] initWithOrderStates:orderStatuesCommon];
//    controller.viewModel.hasPassWordBool = self.viewModel.hasPassWordBool;
//    controller.viewModel.bankArr = self.viewModel.bankArr;
//    controller.viewModel.totalMoney =self.viewModel.selectMoney?self.viewModel.selectMoney:@"0";
//    controller.viewModel.orderNumber = self.viewModel.orderNo;
//    controller.viewModel.selectDate = self.viewModel.selctDate;
//    if (self.viewModel.bankArr.count>0) {
//        
//        controller.viewModel.selectBank = [self.viewModel.bankArr firstObject];
//    }
//    controller.delegate = self;
//    
//    controller.payConfirmBlcok = ^(void){
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//    
//    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:controller animated:YES completion:nil];
//    
//}
//#pragma mark -- billDelegate;
//-(void)selectAction:(NSIndexPath *)index{
//
//    HXBillDetailsModel * model = [self.viewModel.voListArr objectAtIndex:index.row];
//    if ([model.canChoose boolValue]) {
//        if (!model.haveSelect) {
//            model.haveSelect = YES;
//            if (model.interest && [model.interest floatValue]!=0) {
//                
//                self.viewModel.interest = [NSString stringWithFormat:@"%.2f",[self.viewModel.interest floatValue] + [model.interest floatValue]];
//            }
//            self.viewModel.selctDate = model.currentPeriods;
//            self.viewModel.selectMoney = model.payamt;
//            
//        }else {
//            model.haveSelect = NO;
//            self.viewModel.selectMoney = @"";
//            self.viewModel.selctDate = @"";
//            if (model.interest && [model.interest floatValue]!=0) {
//                
//                self.viewModel.interest = [NSString stringWithFormat:@"%.2f",[self.viewModel.interest floatValue] - [model.interest floatValue]];
//            }
//            
//        }
//            //显示计算后金额
//            self.moneyLabel.text = self.viewModel.selectMoney.length?self.viewModel.selectMoney:@"0.00";
//            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.moneyLabel.text]];
//            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:35] range:NSMakeRange(1, self.moneyLabel.text.length)];
//            self.moneyLabel.attributedText = attributedString;
//            
//            if ([self.viewModel.interest floatValue]>0) {
//                
//                self.punishLabel.text = [NSString stringWithFormat:@"(含罚息: %@)",self.viewModel.interest];
//                self.punishLabel.hidden = NO;
//            }else {
//                self.punishLabel.hidden = YES;
//            }
//        [_tableView reloadData];
//    }
//
//    
//}
//
//#pragma mark -- bankRemove
//-(void)archiviewBank {
//    [self.viewModel.bankArr removeAllObjects];
//}
//
//#pragma mark -- forgotPassWordDelegate
//-(void)forgot {
//    HXIdCardVerificationViewController * idcard = [[HXIdCardVerificationViewController alloc] init];
//    [self.navigationController pushViewController:idcard animated:YES];
//}
//-(void)changePassStates {
//    
//  self.viewModel.hasPassWordBool = @"1";
//    
//}
//-(void)addBank {
//    [self addBankAction];
//    
//}
//
//- (void)onBack {
//    for (UIViewController *temp in self.navigationController.viewControllers) {
//        if ([temp isKindOfClass:[HXBillViewController class]]) {
//            [self.navigationController popToViewController:temp animated:YES];
//            return ;
//        }
//    }
//    HXBillViewController *controller = [[HXBillViewController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//
///**
// 判断系统时间间隔
// */
//- (void)isBetweenHour
//
//{
//    if (self.viewModel.responseTime.length==0) {
//        return;
//    }
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSDate *date = [dateFormatter dateFromString:self.viewModel.responseTime];
//    
//    [dateFormatter setDateFormat:@"HH"];
//    NSString *strHour = [dateFormatter stringFromDate:date];
//    
//    if (( [strHour intValue]>=22 && [strHour intValue]<=24)) {
//        self.viewModel.betweenTimeBool = YES;
//    }
//    if ([strHour intValue]>=0 && [strHour intValue]<3) {
//        self.viewModel.betweenTimeBool = YES;
//    }
//}
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
