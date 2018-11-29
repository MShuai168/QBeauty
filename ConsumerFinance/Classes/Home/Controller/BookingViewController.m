//
//  BookingViewController.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/9/5.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "BookingViewController.h"
#import "PickerChoiceView.h"
#import "DatePickerView.h"

@interface BookingViewController ()<PickerDelegate,DatePickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, strong) DatePickerView *dateView;
@property (strong, nonatomic) UIButton *btn; //作为dateView弹出来时的阴影
@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.navigationItem.title = @"门店预约";
    self.nameLabel.text = self.nameStr;
    self.addressLabel.text = self.address;
    if ([[AppManager manager] getMyPhone].length != 0) {
        self.phoneLabel.text = [[AppManager manager] getMyPhone];
    }else {
        self.phoneLabel.text = @"";
    }
    // 设置边框：
    self.textView.layer.borderColor = [UIColor colorWithHex:0xF5F7F7].CGColor;
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.cornerRadius = 5.0;
    
    self.selectedButton.layer.borderColor = [UIColor colorWithHex:0xF5F7F7].CGColor;
    self.selectedButton.layer.borderWidth = 1.0;
    self.selectedButton.layer.cornerRadius = 5.0;
    self.selectedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.selectedButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    if (SCREEN_HEIGHT < 481) { //5S  320X480
        self.heightConstraint.constant = 135;
    } else if (SCREEN_HEIGHT < 668) { //6、7、8  375X667
        self.heightConstraint.constant = 160;
    } else if (SCREEN_HEIGHT < 737) { //6Plus/7Plus/8Plus  414X736
        self.heightConstraint.constant = 180;
    } else { //iPhoneX 375X812
        self.heightConstraint.constant = 180;
    }
    
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.btn.backgroundColor = [UIColor blackColor];
    self.btn.hidden = YES;
    self.btn.alpha = 0.3;
    [self.view addSubview:self.btn];
    
    DatePickerView *dateView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 280)];
    dateView.delegate = self;
    dateView.title = @"请选择预约时间";
    [self.view addSubview:dateView];
    self.dateView = dateView;
}

-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
    if (self.block) { // 如果在上一个页面调用了这个block，就执行下面的方法
        self.block(@"returnBack");
    }
}

- (void)PickerSelectorIndixString:(NSString *)str {
    NSLog(@"%@",str);
    [self.selectedButton setTitle:str forState:UIControlStateNormal];
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

//选择预约时间
- (IBAction)selectedButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
//    PickerChoiceView *picker = [[PickerChoiceView alloc] initWithFrame:self.view.bounds];
//    picker.delegate = self;
//    picker.selectLb.text = @"选择预约时间";
//    picker.arrayType = 2;
//    picker.selectStr  = sender.titleLabel.text;
//    [self.view addSubview:picker];
    
    self.btn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, SCREEN_HEIGHT - 280 - (iphone_X?88:64), SCREEN_WIDTH, 280);
        [self.dateView show];
    }];
}


#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    self.flag = true;
    [self.selectedButton setTitle:timer forState:UIControlStateNormal];
    
    self.btn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, SCREEN_HEIGHT - (iphone_X?88:64), SCREEN_WIDTH, 280);
    }];
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    self.btn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, SCREEN_HEIGHT - (iphone_X?88:64), SCREEN_WIDTH, 280);
    }];
}

- (IBAction)bookingButtonAction:(UIButton *)sender {
    if (self.flag == false) {
        [MBProgressHUD showError:@"请选择预约时间"];
        return;
    }
    NSString *dateStr = [self.selectedButton.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *str = [Helper getTimeStrWithString:dateStr];
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"reserveStartTime":str, @"tenantId":self.tenantId, @"remark":self.textView.text?self.textView.text:@""};
    
    [[HXNetManager shareManager] post:@"mtReserve/add" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            [MBProgressHUD showSuccess:@"恭喜您,预约成功！！！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
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
