//
//  HXAllEvaluationViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/14.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXAllEvaluationViewController.h"
#import "HXCommentCell.h"

@interface HXAllEvaluationViewController ()<hxcommentDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}
@property (nonatomic,strong)NSMutableArray * evaluationArr;
@end

@implementation HXAllEvaluationViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXAllEvaluationViewModel alloc] initWithController:self];
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

-(void)request {
    if (self.viewModel.detailBool) {
         [MBProgressHUD showMessage:nil toView:self.view];
        [self.viewModel archiveEvaluationDetailWithReturnBlock:^{
            [_tableView reloadData];
        }];
    }

}
-(void)archivewCommetn {
    [self.viewModel archiveCommentWithReturnBlock:^{
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    } fail:^{
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = self.viewModel.detailBool?@"评价详情":@"全部评论";
    [self setNavigationBarBackgroundImage];
    [self hiddenNavgationBarLine:NO];
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    if (!self.viewModel.detailBool && self.viewModel.commentNumber>10) {
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic:)];
        //上拉刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic:)];
    }
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.viewModel.detailBool) {
        return self.viewModel.hxcModel?1:0;
    }
    return self.viewModel.allCommentArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell3";
    HXCommentCell *cell = (HXCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[HXCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    cell.delegate = self;
    if (self.viewModel.detailBool) {
        cell.hxcModel = self.viewModel.hxcModel;
    }else {
        
        cell.hxcModel = [self.viewModel.allCommentArr objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell creatLine:15 hidden:NO];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.viewModel.detailBool) {
        return self.viewModel.hxcModel.cellHeight;
    }
    HXCommentModel * model = [self.viewModel.allCommentArr objectAtIndex:indexPath.row];
    return model.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
#pragma mark -- hxcomdelegate
-(void)updateTableViewHeight {
    
    [_tableView beginUpdates];
    [_tableView endUpdates];
    [CATransaction commit];
    
}
-(void)loadNewTopic:(UITableView*)tableView {
    [MBProgressHUD showMessage:nil toView:self.view];
    self.viewModel.commentIndex = 1;
    [self archivewCommetn];
    
}
-(void)loadMoreTopic:(UITableView*)tableView {
    [MBProgressHUD showMessage:nil toView:self.view];
    self.viewModel.commentIndex ++;
    [self archivewCommetn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    [mgr.imageCache clearMemory];
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
