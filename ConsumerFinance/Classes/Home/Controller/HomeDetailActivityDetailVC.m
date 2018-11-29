//
//  HomeDetailActivityVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HomeDetailActivityDetailVC.h"
#import "HomeActivityDetaiCell.h"
#import "ActivityDetailHeaderView.h"
#import <ZYBannerView/ZYBannerView.h>
#import "AvatarBrowser.h"

@interface HomeDetailActivityDetailVC ()<UITableViewDelegate, UITableViewDataSource, ZYBannerViewDataSource, ZYBannerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imgArray;  //服务内容icon
@property (nonatomic, copy) NSString *contentStr; //使用说明
@property (nonatomic, strong) ActivityDetailHeaderView *headerView;
@property (nonatomic, strong) UIImageView *imageView; //显示轮播图的imageView

@end

@implementation HomeDetailActivityDetailVC

- (NSMutableArray *)imgArray {
    if (!_imgArray) {
        _imgArray = [NSMutableArray array];
    }
    return _imgArray;
}

- (ActivityDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ActivityDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *4/3 + 60)];
        _headerView.bannerView.dataSource = self;
        _headerView.bannerView.delegate = self;
        _headerView.bannerView.autoScroll = YES;
        _headerView.bannerView.scrollInterval = 5.0; //自动滑动时间间隔
        _headerView.bannerView.shouldLoop = YES;
        _headerView.bannerView.backgroundColor = ColorWithHex(0xFFFFFF);
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (iphone_X?88:64))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = COLOR_BACKGROUND;
        _tableView.tableHeaderView = self.headerView;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
//        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

#pragma mark ZYBannerViewDataSource
// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {
    return self.imgArray.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的view, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    // 取出数据
    HomeActivityDetailModel * model = self.imgArray[index];
    
    // 创建将要显示控件
    _imageView = [[UIImageView alloc] init];
    _imageView.tag = index + 100;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:SCREEN_WIDTH height:CGRectGetHeight(self.headerView.bannerView.frame)]] placeholderImage:[UIImage imageNamed:@"banner3"]];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    return _imageView;
}

#pragma mark ZYBannerViewDelegate
// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"%ld", (long)index);
    if (self.imgArray.count == 1) {
        [AvatarBrowser showImage:self.imageView];
    } else {
        //允许交互
        _imageView.userInteractionEnabled = YES;
        //添加手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        [_imageView addGestureRecognizer:tap];
        
        NSDictionary *dict = @{@"tagX": [NSString stringWithFormat:@"%ld", index+100]};
        //添加tap手势发生冲突，所以使用通知
        [[NSNotificationCenter  defaultCenter] postNotificationName:@"didClickedImgView" object:nil userInfo:dict];
    }
}

//tap手势
//-(void)tapAction:(UITapGestureRecognizer *)tap {
//    [AvatarBrowser showImage:(UIImageView *)tap.view];
//}

//通知
- (void)clickedImgView:(NSNotification *)noti {
    NSString *tag = noti.userInfo[@"tagX"];
    [AvatarBrowser showImage:(UIImageView *)[self.view viewWithTag:[tag integerValue]]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didClickedImgView" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    self.view.backgroundColor = COLOR_BACKGROUND;
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"活动详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeActivityDetaiCell" bundle:nil] forCellReuseIdentifier:@"HomeActivityDetaiCell"];
    [self.view addSubview:self.tableView];
    
    [self loadActivityDetaiData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickedImgView:) name:@"didClickedImgView" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.block) { // 如果在上一个页面调用了这个block，就执行下面的方法
        self.block(@"returnBack");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadActivityDetaiData {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%d",self.id]};
    [[HXNetManager shareManager] get:@"tenant/activityDetail" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [self.imgArray removeAllObjects];
            NSArray *arrayList = [responseNewModel.body valueForKey:@"imgList"];
            for (NSDictionary *dict in arrayList) {
                HomeActivityDetailModel *model = [HomeActivityDetailModel initWithDictionary:dict];
                if (model.imgUrl.length > 0) {
                    [self.imgArray addObject:model];
                }
            }
            
            NSDictionary *dic = responseNewModel.body[@"activity"];
            self.contentStr = [dic[@"instructions"] length]?dic[@"instructions"]:@"";
//            NSLog(@"%@",self.contentStr);
            
            NSString *str1 = [Helper dateWithTimeStampDate:[dic[@"beginTime"] integerValue]/1000];
            NSString *str2 = [Helper dateWithTimeStampDate:[dic[@"overTime"] integerValue]/1000];
            self.headerView.titleLabel.text = [NSString stringWithFormat:@"%@—%@",str1,str2];
            
            [self.tableView reloadData];
            [self.headerView.bannerView reloadData];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
        //停止刷新
        [self.tableView endRefreshHeaderAndFooter];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeActivityDetaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeActivityDetaiCell"];
    cell.titleLabel.text = self.contentStr;
    
    return cell;
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
