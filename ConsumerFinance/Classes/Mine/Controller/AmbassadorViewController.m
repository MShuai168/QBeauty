//
//  AmbassadorViewController.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/7/26.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "AmbassadorViewController.h"
#import "RelateView.h"

@interface AmbassadorViewController ()

//无关联时
@property (weak, nonatomic) IBOutlet UILabel *numCodeStr;
@property (weak, nonatomic) IBOutlet UITextField *numCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *relateButton;

@property (nonatomic, strong) RelateView *relateView;

//有关联时
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation AmbassadorViewController

- (RelateView *)relateView {
    if (!_relateView) {
        _relateView = [[RelateView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        __weak typeof (self) weakSelf = self;
        _relateView.selectedButton = ^(UIButton *button) {
            [weakSelf buttonOfRelateViewAction:button];
        };
    }
    return _relateView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"我的美丽大使";
    //第一步,对组件增加监听器
    [self.numCodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self querySuperiorPartner];
}

- (void)querySuperiorPartner {
    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] get:@"prePartner/querySuperiorFriend" parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            int flag = [[responseNewModel.body valueForKey:@"flag"] intValue];  //是否有美丽大使标志 1:有   2:无
            if (flag == 1) {
                NSDictionary *partnerInfo = [responseNewModel.body valueForKey:@"partnerInfo"];
                self.titleLabel1.hidden = false;
                self.infoLabel.hidden = false;
                self.infoLabel.text = [NSString stringWithFormat:@"%@  %@",partnerInfo[@"name"], partnerInfo[@"cellphone"]];
                self.titleLabel2.hidden = false;
                self.dateLabel.hidden = false;
                self.dateLabel.text = [Helper dateWithTimeStampAll:[partnerInfo[@"bindingTime"] integerValue] / 1000];
                
                self.numCodeStr.hidden = YES;
                self.numCodeTF.hidden = YES;
                self.relateButton.hidden = YES;
            } else {
                self.numCodeStr.hidden = false;
                self.numCodeTF.hidden = false;
                self.relateButton.hidden = false;
                self.relateButton.enabled = NO;
                self.relateButton.backgroundColor = [ComonBackColor colorWithAlphaComponent:0.3];
                
                self.titleLabel1.hidden = YES;
                self.infoLabel.hidden = YES;
                self.titleLabel2.hidden = YES;
                self.dateLabel.hidden = YES;
            }
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

//第二步,实现回调函数
-(void)textFieldDidChange:(UITextField *)textField {
    if ([textField isEqual:self.numCodeTF]){
        if(textField.text.length > 12) {
            textField.text = [textField.text substringToIndex:12];
        }
    }
    [self changeButtonStates];
}

-(void)changeButtonStates {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新
            if (self.numCodeTF.text.length > 3) {
                self.relateButton.enabled = YES;
                self.relateButton.backgroundColor = ComonBackColor;
            } else {
                self.relateButton.enabled = NO;
                self.relateButton.backgroundColor = [ComonBackColor colorWithAlphaComponent:0.3];
            }
        });
    });
}


- (IBAction)relateButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [self checkCode];
}

//查询推荐码
- (void)checkCode {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"inviterCode":self.numCodeTF.text};
    [[HXNetManager shareManager] get:@"prePartner/checkCode" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            NSDictionary *dic = [responseNewModel.body valueForKey:@"partnerInfo"];
            self.relateView.infoLabel.text = [NSString stringWithFormat:@"%@ %@",dic[@"name"], dic[@"cellphone"]];
            UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
            [currentWindow addSubview:self.relateView];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (void)buttonOfRelateViewAction:(UIButton *)sender {
    [self.relateView removeFromSuperview];
    if (sender.tag == 110 | sender.tag == 111) {
//        NSLog(@"+++++点击的取消按钮");
        [MBProgressHUD showError:@"您取消了关联美丽大使"];
    } else if (sender.tag == 112) {
//        NSLog(@"XXXXX点击的确定按钮");
        [self bindingUser];
    }
}

//关联美丽大使
- (void)bindingUser {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"inviterCode":self.numCodeTF.text};
    [[HXNetManager shareManager] post:@"prePartner/bindingUser" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [self querySuperiorPartner];
            [MBProgressHUD showSuccess:@"恭喜您,关联成功！！！"];
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
