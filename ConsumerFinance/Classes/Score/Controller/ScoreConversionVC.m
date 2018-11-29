//
//  ScoreConversionVC.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/11.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "ScoreConversionVC.h"

@interface ScoreConversionVC ()

@property (nonatomic, assign) int type; //1:SAAS兑换QB   2:QB兑换SAAS
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratioLabel;   //兑换比例
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@end

@implementation ScoreConversionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.title = @"积分转换";
    self.view.backgroundColor = ColorWithHex(0xF5F7F8);
    
    self.type = 1;
    UIButton *find_button = (UIButton *)[self.view viewWithTag:101];
    [find_button setImage:[UIImage imageNamed:@"btn_choice_selected"] forState:UIControlStateNormal];
    
    [self queryExchangeScoreWithType:1];
}

//选择兑换类别
- (IBAction)selectedButtonAction:(UIButton *)sender {
    if (sender.tag == 101) {
        [sender setImage:[UIImage imageNamed:@"btn_choice_selected"] forState:UIControlStateNormal];
        UIButton *find_button = (UIButton *)[self.view viewWithTag:102];
        [find_button setImage:[UIImage imageNamed:@"btn_choice_nor"] forState:UIControlStateNormal];
        self.type = 1;
    } else if (sender.tag == 102) {
        [sender setImage:[UIImage imageNamed:@"btn_choice_selected"] forState:UIControlStateNormal];
        UIButton *find_button = (UIButton *)[self.view viewWithTag:101];
        [find_button setImage:[UIImage imageNamed:@"btn_choice_nor"] forState:UIControlStateNormal];
        self.type = 2;
    }
    [self queryExchangeScoreWithType:self.type];
}

- (void)queryExchangeScoreWithType:(int)type {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"type":[NSString stringWithFormat:@"%d",type]};
    [[HXNetManager shareManager] get:@"exchange/queryExchange" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            NSDictionary *dic = [responseNewModel.body valueForKey:@"data"];
            self.scoreLabel.text = [NSString stringWithFormat:@"%d", [dic[@"score"] intValue]];
            self.ratioLabel.text = dic[@"exchange"];
            NSArray *array = [self.ratioLabel.text componentsSeparatedByString:@":"];
            int num = [array.firstObject intValue];
            self.warningLabel.text = [NSString stringWithFormat:@"兑换积分值需要为%d的倍数",num];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

//确认兑换
- (IBAction)doneButton:(UIButton *)sender {
    if ([self.numTF.text intValue] < 1) {
        [MBProgressHUD showError:@"请输入您要兑换的积分"];
        return;
    }
    if ([self.numTF.text intValue] > [self.scoreLabel.text intValue]) {
        [MBProgressHUD showError:@"您输入的积分不能大于当前可用积分"];
        return;
    }
    NSArray *array = [self.ratioLabel.text componentsSeparatedByString:@":"];
    int num = [array.firstObject intValue];
    if ([self.numTF.text intValue] % num != 0) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"兑换积分值需要为%d的整数倍",num]];
        return;
    }
    
    [self.view endEditing:YES];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"type":[NSString stringWithFormat:@"%d",self.type], @"score":self.numTF.text};
    [[HXNetManager shareManager] post:@"exchange/exchangeScore" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [self queryExchangeScoreWithType:self.type];
            [MBProgressHUD showSuccess:@"恭喜您,兑换成功！！！"];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
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
