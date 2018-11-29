//
//  BaseSuccessViewController.m
//  creditor
//
//  Created by Jney on 16/9/6.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import "BaseSuccessViewController.h"
#import "AppDelegate.h"

@interface BaseSuccessViewController ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger seconds;

@end

@implementation BaseSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}


- (void) editNavi{
    [self.view setBackgroundColor:ColorWithRGB(242, 242, 242)];
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
}

- (void) createUI{
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 100*showScale, 100, 70)];
    self.iconImg = imgView;
    [self.view addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom+25, SCREEN_WIDTH, 20)];
    label.textColor = ColorWithRGB(51, 51, 51);
    label.font = FONT_SYSTEM_SIZE(24);
    self.titleLabel = label;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom + 10, SCREEN_WIDTH, 38)];
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    
    /*
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    self.showLabel.userInteractionEnabled = YES;
    [self.showLabel addGestureRecognizer:tap];
     */
    
    self.showLabel.font = NormalFontWithSize(16);
    self.seconds = 5;
    self.showLabel.textColor = HXRGB(60, 155, 255);
    [self.view addSubview:_showLabel];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeLabelStr) userInfo:nil repeats:YES];
    
    
}

/*
-(void)click{
    
    [self.navigationController popViewControllerAnimated:YES];

}
*/
- (void) changeLabelStr{
    self.seconds--;
    if (self.seconds == 0) {
        [self jumpVC];
        [self.timer invalidate];
        self.timer = nil;
        
    }
    
    
}


- (void) jumpVC{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self editNavi];
}


@end
