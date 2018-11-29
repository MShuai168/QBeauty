//
//  HXFriendViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/10.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXFriendViewController.h"
#import "HXShareViewController.h"
#import "FreezeHintView.h"

@interface HXFriendViewController ()

@property (nonatomic, strong) UIButton *friendButton;
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;

@end

@implementation HXFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"邀请好友";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"ArtboardF"];
    imageView.image = image;
    [scrollView addSubview:imageView];
    
    CGFloat persent= SCREEN_WIDTH/image.size.width;
    CGFloat height = image.size.height *persent;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(height);
        make.bottom.equalTo(scrollView.mas_bottom);
    }];
    
    _friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_friendButton setBackgroundColor:ColorWithHex(0xd75a79)];
    [_friendButton setTitle:@"马上邀请好友 拿10趣贝奖励" forState:UIControlStateNormal];
    [_friendButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_friendButton addTarget:self action:@selector(shareFriend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_friendButton];
    [self.friendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(75);
        make.right.equalTo(self.view).offset(-75);
        make.height.mas_equalTo(36);
        make.bottom.equalTo(imageView).offset(-140);
    }];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"shareFriend"] forState:UIControlStateNormal];
    _rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    _friendButton.userInteractionEnabled = false;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)rightButtonClick:(UIButton *)button {
    [self share];
}

- (void)shareFriend:(UIButton *)sender {
    [self share];
}

- (void)share {
    if (![self isSign]) {
        return;
    }
    HXShareViewController *shareController = [[HXShareViewController alloc] init];
    shareController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [shareController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.navigationController presentViewController:shareController animated:YES completion:nil];
}

- (BOOL)isSign {
    if (![[AppManager manager] isOnline]) {
        [Helper pushLogin:self];
        return NO;
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self appService];
}

- (void)appService{
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameter = @{@"version":[NSString stringWithFormat:@"%@",SHORT_VERSION]};
//    NSLog(@"当前版本号:%@", parameter);
    [[HXNetManager shareManager] get:@"appService/IsTrue" parameters:parameter sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            int value = [responseNewModel.body[@"value"] intValue];  //1:隐藏  2:显示
            if (value == 2) {
                self.navigationItem.rightBarButtonItem = self.rightButtonItem;
                self.friendButton.userInteractionEnabled = YES;
            } else if (value == 1) {
                self.navigationItem.rightBarButtonItem = nil;
                self.friendButton.userInteractionEnabled = false;
            }
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
    
// i理理：1088130499   DCT：1186103320
//    NSString *urlString = @"https://itunes.apple.com/cn/lookup?id=1419980790";  //id=1197227551
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//
//    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
//    //    解析json数据
//    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
////    NSArray *array = json[@"results"];
////    for (NSDictionary *dic in array) {
////        NSString *appStoreVersion = [dic valueForKey:@"version"];
////    }
//
//    NSArray *resultArr = json[@"results"];
//    NSDictionary *resultDic = resultArr.firstObject;
//    NSString *appStoreVersion = resultDic[@"version"];  //appStore的版本号
//    NSString *appCurrentVersion = SHORT_VERSION;  //当前版本号
//    NSLog(@"当前版本%@   AppStore版本%@", appCurrentVersion, appStoreVersion);
////    NSOrderedAscending = -1,    // < 升序
////    NSOrderedSame,             // = 等于
////    NSOrderedDescending       // > 降序
//    if ([appCurrentVersion compare:appStoreVersion options:NSNumericSearch] == NSOrderedDescending) {
//        NSLog(@"+++++++++++++");
//        self.navigationItem.rightBarButtonItem = nil;
//        self.friendButton.userInteractionEnabled = NO;
//    } else {
//        NSLog(@"XXXXXXXXXXXXX");
//        self.navigationItem.rightBarButtonItem = self.rightButtonItem;
//        self.friendButton.userInteractionEnabled = YES;
//    }
//    NSLog(@"当前比较值%ld",[appCurrentVersion compare:appStoreVersion options:NSNumericSearch]);
//    NSLog(@"Ascending:%ld   Descending:%ld   Same:%ld",(long)NSOrderedAscending, NSOrderedDescending, NSOrderedSame);
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
