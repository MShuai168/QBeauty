//
//  PageViewController.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "PageViewController.h"
#import "MLMSegmentManager.h"

#import "CouponUnusedVC.h" //未使用的优惠券
#import "CouponUsedVC.h"  //已使用的优惠券
#import "CouponOverdueVC.h" //已过期的优惠券

#import "OccupiedCardVC.h" //使用中的次卡
#import "InvalidationCardVC.h"  //已失效的次卡

#import "PrepaidCardUsedVC.h" //使用中的储值卡
#import "PrepaidCardInvalidVC.h" //已失效的储值卡

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

@interface PageViewController ()
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    self.view.backgroundColor = COLOR_BACKGROUND;
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.typeFlag isEqualToString:@"youHuiQuan"]) {
        self.title = @"我的优惠券";
        self.list = @[@"未使用",@"已使用",@"已过期"];
    } else if ([self.typeFlag isEqualToString:@"jiCiKa"]) {
        self.title = @"我的次卡";
        self.list = @[@"使用中",@"已失效"];
    } else if ([self.typeFlag isEqualToString:@"chuZhiKa"]) {
        self.title = @"我的储值卡";
        self.list = @[@"使用中",@"已失效"];
    }
    
    [self segmentStyle];
}

#pragma mark - 数据源
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    
    if ([self.typeFlag isEqualToString:@"youHuiQuan"]) {
        CouponUnusedVC *oneViewC = [CouponUnusedVC new];
        [arr addObject:oneViewC];
        CouponUsedVC *twoViewC = [CouponUsedVC new];
        [arr addObject:twoViewC];
        CouponOverdueVC *threeViewC = [CouponOverdueVC new];
        [arr addObject:threeViewC];
    } else if ([self.typeFlag isEqualToString:@"jiCiKa"]) {
        OccupiedCardVC *oneViewC = [OccupiedCardVC new];
        [arr addObject:oneViewC];
        InvalidationCardVC *twoViewC = [InvalidationCardVC new];
        [arr addObject:twoViewC];
    } else if ([self.typeFlag isEqualToString:@"chuZhiKa"]) {
        PrepaidCardUsedVC *oneViewC = [PrepaidCardUsedVC new];
        [arr addObject:oneViewC];
        PrepaidCardInvalidVC *twoViewC = [PrepaidCardInvalidVC new];
        [arr addObject:twoViewC];
    }
    
    return arr;
}

#pragma mark - 均分下划线
- (void)segmentStyle{
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titles:self.list headStyle:SegmentHeadStyleLine layoutStyle:MLMSegmentLayoutDefault];
    //    _segHead.fontScaleX = 1.05;
    _segHead.fontSize = (13);
    /**
     *  导航条的背景颜色
     */
    _segHead.headColor = [UIColor whiteColor];
    
    /*------------滑块风格------------*/
    /**
     *  滑块的颜色
     */
    _segHead.slideColor = [UIColor clearColor];
    
    /*------------下划线风格------------*/
    /**
     *  下划线的颜色
     */
    _segHead.lineColor = kUIColorFromRGB(0xff5f98);
    /**
     *  选中颜色
     */
    _segHead.selectColor = kUIColorFromRGB(0xff5e97);
    /**
     *  未选中颜色
     */
    _segHead.deSelectColor = [UIColor blackColor];
    /**
     *  下划线高度
     */
    //    _segHead.lineHeight = 2;
    /**
     *  下划线相对于正常状态下的百分比，默认为1
     */
    _segHead.lineScale = 0.5;
    
    /**
     *  顶部导航栏下方的边线
     */
    //    _segHead.bottomLineHeight = 0.5;
    //    _segHead.bottomLineColor = [UIColor greenColor];
    /**
     *  设置当前屏幕最多显示的按钮数,只有在默认布局样式 - MLMSegmentLayoutDefault 下使用
     */
    //_segHead.maxTitles = 5;
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:self.list.count]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    @weakify(self)
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        @strongify(self)
        [self.view addSubview:self.segHead];
        [self.view addSubview:self.segScroll];
    } selectEnd:^(NSInteger index) {
        if (index == 2) {
            
        }else{
            
        }
    }];
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
