//
//  GuideViewController.m
//  iLiLi
//
//  Created by ywf on 15/12/10.
//  Copyright © 2015年 tomcat. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"

#define numOfPages 3  //页面数量

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //scrollView的初始化
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * numOfPages, SCREEN_HEIGHT);
    scrollView.pagingEnabled = true;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.bounces = false;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < numOfPages; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_img0%d.png",i+1]];
        [scrollView addSubview:imgView];
        // 最后一页
        if (i == numOfPages - 1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(25, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 50, 48);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:[UIImage imageNamed:@"guide_img_pre"] forState:UIControlStateNormal];
            [imgView addSubview:button];
            imgView.userInteractionEnabled = true;
        }
    }
}

//立即进入APP
- (void) buttonClick:(UIButton *)sender {
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MainTabBarController *mainController = [[MainTabBarController alloc] init];
    app.window.rootViewController = mainController.tabBarController;
}

/*
 
 9180 + 2283 = 11463 (6月份)
 9263 + 2444 = 11707 (7月份)
 11707 - 11463 = 244
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
