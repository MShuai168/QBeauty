//
//  CouponDetailViewController.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/21.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "CouponDetailViewController.h"

@interface CouponDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *couponNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *sytjNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *kysdNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *sycjNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *benefitNameLabel;


@end

@implementation CouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    self.view.backgroundColor = COLOR_BACKGROUND;
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"优惠券详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadCouponDetailData];
}

- (void)loadCouponDetailData {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%d", self.id]};
    [[HXNetManager shareManager] get:@"coupon/queryCouponDetail" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            NSDictionary *dic = [responseNewModel.body valueForKey:@"data"];
            self.couponNameLabel.text = dic[@"couponName"];
            self.durationLabel.text = dic[@"effectiveTime"];
            self.sytjNameLabel.text = dic[@"sytjName"];
            self.kysdNameLabel.text = dic[@"kysdName"];
//            self.sycjNameLabel.text = dic[@"sycjName"];
            self.benefitNameLabel.text = dic[@"benefitName"];
//            self.syfwNameLabel.text = dic[@"syfwName"];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
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
