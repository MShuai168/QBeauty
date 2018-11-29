////
////  HXUploadCertificateViewController.m
////  ConsumerFinance
////
////  Created by 刘勇强 on 2017/5/8.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXUploadCertificateViewController.h"
//#import "HXOrderStatusTagView.h"
//#import "HXUploadCertificateTableViewCell.h"
//
//@interface HXUploadCertificateViewController ()<UITableViewDataSource, UITableViewDelegate>
//
//@property (nonatomic, strong) UITableView *tableView;
//
//@property (nonatomic, strong) UIButton *nextButton; // 下一步
//@property (nonatomic, strong) UIView *footerView;
//
//@end
//
//@implementation HXUploadCertificateViewController
//
//- (instancetype)init {
//    if (self == [super init]) {
//        _viewModel = [[HXUploadCertificateViewControllerViewModel alloc] init];
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.title = @"上传凭证";
//
//    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
//
//    [self setUpNavigation];
//    [self setUpTagView];
//    [self setUpTableView];
//    [self setUpNextButton];
//
//    self.nextButton.hidden = ![self.viewModel.orderInfo.yfqStatus isEqualToString:@"95"];
//}
//
//- (void)setUpNavigation {
//    [self setNavigationBarBackgroundImage];
//
//    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
//
//}
//
//- (void)setUpTagView {
//    HXOrderStatusTagView *statusTagView = [[HXOrderStatusTagView alloc] initWithTags:@[@"认证资料",@"签署合同",@"上传凭证",@"订单成功"] selectedIndex:2 isFirst:NO];
//    [self.view addSubview:statusTagView];
//    [statusTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(35);
//    }];
//}
//
//- (void)setUpTableView {
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.right.left.equalTo(self.view);
//        make.top.equalTo(self.view).offset(35);
//    }];
//}
//
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] init];
//        _tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
//    }
//    return _tableView;
//}
//
//
//- (void)setUpNextButton {
//    self.nextButton = [[UIButton alloc] init];
//    [self.nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
//    self.nextButton.backgroundColor = ColorWithHex(0x4990E2);
//    [self.nextButton setTitleColor:ColorWithHex(0xffffff) forState:UIControlStateNormal];
//    self.nextButton.layer.cornerRadius = 2;
//    [self.view addSubview:self.nextButton];
//    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(15);
//        make.right.bottom.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(50);
//    }];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"92"]) {
//        return 1;
//    }
//    if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"93"]||[self.viewModel.orderInfo.yfqStatus isEqualToString:@"94"]) {
//        return 2;
//    }
//    if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"95"]) {
//        return 3;
//    }
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 1) {
//        return 100;
//    } else if(indexPath.row == 2) {
//        return 100;
//    }
//    return 130;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    HXUploadCertificateTableViewCell *cell = [[HXUploadCertificateTableViewCell alloc] init];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    switch (indexPath.row) {
//        case 0:
//            cell.textLabel.text = @"商户上传凭证";
//            if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"92"]) {
//                cell.hiddenVerticalLine = YES;
//            }
////            cell.detailTextLabel.text = @"3月20日 13:12";
//            cell.uploadCertificateStatus = uploadCertificateStatusBefore;
//            break;
//        case 1:
//            cell.textLabel.text = @"审核中";
////            cell.detailTextLabel.text = @"3月20日 13:12";
//            cell.uploadCertificateStatus = uploadCertificateStatusverifying;
//            if ([self.viewModel.orderInfo.yfqStatus isEqualToString:@"93"] || [self.viewModel.orderInfo.yfqStatus isEqualToString:@"94"]) {
//                cell.hiddenVerticalLine = YES;
//            }
//            break;
//        case 2:
//            cell.textLabel.text = @"审核通过";
////            cell.detailTextLabel.text = @"3月20日 13:12";
//            cell.hiddenVerticalLine = YES;
//            cell.uploadCertificateStatus = uploadCertificateStatusSucess;
//            break;
//
//        default:
//            break;
//    }
//
//    return cell;
//}
//
//- (void)nextButtonClick:(UIButton *)button {
//    NSDictionary *head = @{@"tradeCode" : @"0140",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{
//                           @"orderId":self.viewModel.orderInfo.id
//                           };
//
//    [MBProgressHUD showMessage:nil toView:nil];
//
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                     NSString *yfqStatus = [object.body objectForKey:@"yfqStatus"];
//                                                     self.viewModel.orderInfo.yfqStatus = yfqStatus;
//
//                                                     [self.viewModel.orderInfo orderStatusHandleWithBlock:^(UIViewController *controller) {
//                                                         if([self.viewModel.orderInfo.yfqStatus isEqualToString:@"99"]){
//                                                             [[NSNotificationCenter defaultCenter] postNotificationName:Notification_CreditScore object:nil userInfo:nil];
//                                                         }
//                                                         [self.navigationController pushViewController:controller animated:YES];
//                                                     } with:self.viewModel.orderType];
//
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                 }];
//}
//
//- (void)backButtonClick:(UIButton *)button {
//    if ([self.navigationController.viewControllers objectAtIndex:1]) {
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//        return;
//    }
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
