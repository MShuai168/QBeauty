////
////  HXImageViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/19.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXImageViewController.h"
//#import "HXCarPeriodViewController.h"
//#import "HXJobPhotoViewController.h"
//#import "PhotoSave.h"
//@interface HXImageViewController ()<UITableViewDelegate,UITableViewDataSource,jobPhotoDelegate>
//{
//    UITableView * _tableView;
//}
//
//@property (nonatomic,strong)NSArray * photoArr;
//@end
//
//@implementation HXImageViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        
//        self.viewModel = [[HXImageViewModel alloc] initWithController:self];
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
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updaStates) name:Notification_PhotoInformation object:nil];
//}
//-(void)request {
//    
//    [self.viewModel archivePhotoStatesWithReturnBlock:^{
//        [_tableView reloadData];
//    }];
//    
//}
//-(void)viewWillAppear:(BOOL)animated {
//    
//    
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"影像信息";
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
//        make.top.equalTo(self.view.mas_top);
//        make.right.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//    }];
//    
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
//        NSArray * arr = [self.viewModel.nameArr objectAtIndex:section];
//        return arr.count;
//    }
//    return 3;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//        if (indexPath.row==0) {
//            [cell creatLine:15 hidden:NO];
//        }else if(indexPath.row==1){
//            [cell creatLine:15 hidden:NO];
//        }else {
//            [cell creatLine:15 hidden:NO];
//        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        //        cell.titleLabel.text = @"待上传";
//        [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(cell.contentView.mas_right).offset(0);
//        }];
//    }
//    cell.nameLabel.text = [[self.viewModel.nameArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    [self.viewModel archiveUploadStates:cell];
//    cell.titleLabel.textColor = [cell.titleLabel.text isEqualToString:@"已上传"] ?kUIColorFromRGB(0x4990E2):ComonCharColor
//    ;
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 50;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.1;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 38;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
//    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    //影像
//    HXJobPhotoViewController * jopPhoto = [[HXJobPhotoViewController alloc] init];
//    jopPhoto.orderPhoto = YES;
//    jopPhoto.work = YES;
//    jopPhoto.delegate = self;
//    jopPhoto.viewModel.orderId = self.viewModel.orderId;
//    jopPhoto.viewModel.orderNumber = self.viewModel.orderNumber;
//    if (indexPath.section == 0) {
//        if ([cell.nameLabel.text isEqualToString:@"首付凭证"]) {
//            jopPhoto.viewModel.catory = CertificatePayment;
//        }else if ([cell.nameLabel.text isEqualToString:@"销售凭证"]) {
//            jopPhoto.viewModel.catory = CertificateSales;
//        }else if ([cell.nameLabel.text isEqualToString:@"身份证明"]) {
//            jopPhoto.viewModel.catory = CertificateIdentify;
//        }else if ([cell.nameLabel.text isEqualToString:@"学籍证明"]) {
//            jopPhoto.viewModel.catory = CertificateStudent;
//        }else if ([cell.nameLabel.text isEqualToString:@"工作证明"]) {
//            jopPhoto.viewModel.catory = CertificateWork;
//            jopPhoto.orderPhoto = NO;
//        }else {
//            
//        }
//    }else {
//        if (indexPath.row==0) {
//            jopPhoto.viewModel.catory = CertificateWork;
//            
//        }else if (indexPath.row == 1) {
//            jopPhoto.viewModel.catory = CertificateFinancial;
//        }else {
//            jopPhoto.viewModel.catory = CertificateStream;
//            
//        }
//        
//    }
//    
//    
//    [self.navigationController pushViewController:jopPhoto animated:YES];
//    
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
//    view.backgroundColor = [UIColor clearColor];
//    
//    UILabel * titleLabel = [[UILabel alloc] init];
//    titleLabel.font = [UIFont systemFontOfSize:13];
//    titleLabel.textColor = kUIColorFromRGB(0x666666);
//    if (section == 0) {
//        titleLabel.text = @"必要影像";
//    }else {
//        titleLabel.text = @"补充影像";
//    }
//    [view addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(view).offset(15);
//        make.centerY.equalTo(view);
//    }];
//    return view;
//}
//-(void)updaStates {
//    
//    [self request];
//    
//    
//}
//#pragma mark -- jobPhotoDelegate
//-(void)archivePhoto:(NSMutableArray *)photoArr {
//    //    NSMutableArray * arr = [[NSMutableArray alloc] init];
//    //    [arr addObjectsFromArray:photoArr];
//    //
//    //    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:7 inSection:0];
//    //    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//}
//-(void)dealloc {
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//@end
