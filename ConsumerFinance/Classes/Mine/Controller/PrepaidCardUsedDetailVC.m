//
//  PrepaidCardUsedDetailVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/23.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "PrepaidCardUsedDetailVC.h"

@interface PrepaidCardUsedDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel; //有效期
@property (weak, nonatomic) IBOutlet UILabel *occasionsLabel;  //购买时间
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;  //卡内余额
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;  //店名

@end

@implementation PrepaidCardUsedDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    self.view.backgroundColor = COLOR_BACKGROUND;
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"储值卡详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadDataPrepaidCardDetail];
}

- (void)loadDataPrepaidCardDetail {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"cardId":self.cardId, @"purchaseTime":self.purchaseTime};
    [[HXNetManager shareManager] get:@"moneyCard/queryMoneyCardByCardId" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            NSDictionary *dic = [responseNewModel.body valueForKey:@"moneyCard"];
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"defaultImg"]];
            if ([dic[@"imgUrl"] length] > 0) {
                [self.imgView setContentScaleFactor:[[UIScreen mainScreen] scale]];
                self.imgView.contentMode =  UIViewContentModeScaleAspectFill;
                self.imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                self.imgView.clipsToBounds  = YES;
            }
            NSString *str = [Helper dateWithTimeStampDate:([dic[@"purchaseTime"] integerValue] / 1000)];
            NSString *strX = [Helper dateWithTimeStampDate:([dic[@"expiredTime"] integerValue] / 1000)];
            self.durationLabel.text = [NSString stringWithFormat:@"%@-%@",str, strX];
            self.occasionsLabel.text = [Helper dateWithTimeStampDate:[dic[@"purchaseTime"] integerValue]/1000];
            self.moneyLabel.text = dic[@"money"];
            self.shopNameLabel.text = dic[@"shopName"];
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
