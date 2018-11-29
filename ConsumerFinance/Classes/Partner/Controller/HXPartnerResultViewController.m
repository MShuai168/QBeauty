//
//  HXPartnerResultViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerResultViewController.h"
#import "JCKeyBoardNum.h"
#import "UITextField+JCTextField.h" // 自定义数字键盘
#import "HXPartnerCenterViewController.h"
@interface HXPartnerResultViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
   NSInteger _second;
}
@property (nonatomic,strong) BaseTableViewCell * nameCell;
@property (nonatomic,strong) BaseTableViewCell * identyCell;
@property (nonatomic,strong) BaseTableViewCell * iphoneCell;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIButton * referButton;
@property (nonatomic,strong) UIView * orderView;
@property (nonatomic,strong)UITextField * numberTextField;
@property (nonatomic,assign)float height;
@property (nonatomic, strong) JCKeyBoardNum *NumKeyBoard;
@property (nonatomic,strong)UILabel * promptLabel;

@property (nonatomic,strong)UIImageView * photoImageView;
@property (nonatomic,strong)UILabel * resultLabel;
@property (nonatomic,strong)UILabel * reasonLabel;
@property (nonatomic,strong)UIButton * cancelBtn;
@property (nonatomic,strong)UIView * resultView;
@property (nonatomic,strong)UIView * submitView;

@property (nonatomic,strong)UILabel * completionLabel;
@property (nonatomic,strong)UILabel * completionTimeLabel;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * applyTimeLabel;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,strong)UILabel * moneyLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@end

@implementation HXPartnerResultViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel  =[[HXPartnerResultViewModel alloc] initWithController:self];
        _second = 3;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    self.view.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notifierKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notifierKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    if (!(self.viewModel.orderStates == PartnerOrderStatesFail || self.viewModel.orderStates == PartnerOrderStatesSuccess)) {
        
        [self request];
    }
    if (self.viewModel.orderStates == PartnerOrderStatesFail) {
        [self archivefail];
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)viewWillAppear:(BOOL)animated {
    [self hiddenNavgationBarLine:YES];
}
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"结果";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
}
-(void)createUI {
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView  = scrollView;
    self.scrollView.delegate = self;
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = COLOR_BACKGROUND;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    UIView * resultView = [[UIView alloc] init];
    self.resultView = resultView;
    resultView.hidden = YES;
    resultView.backgroundColor = CommonBackViewColor;
    [scrollView addSubview:resultView];
    [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView);
        make.left.equalTo(scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(188);
    }];
    
    UIButton * cancelBtn = [[UIButton alloc] init];
    self.cancelBtn = cancelBtn;
    cancelBtn.hidden = YES;
    [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:ComonCharColor forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [resultView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resultView).offset(16);
        make.right.equalTo(resultView).offset(-15);
    }];
    
    UIImageView * photoImageView = [[UIImageView alloc] init];
    self.photoImageView = photoImageView;
    [resultView addSubview:photoImageView];
    [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resultView).offset(32);
        make.centerX.equalTo(resultView);
    }];
    
    UILabel * resultLabel = [[UILabel alloc] init];
    self.resultLabel = resultLabel;
    resultLabel.font = [UIFont systemFontOfSize:18];
    resultLabel.textColor = ComonTextColor;
    [resultView addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resultView).offset(112);
        make.centerX.equalTo(resultView);
    }];
    
    UILabel * reasonLabel = [[UILabel alloc] init];
    self.reasonLabel = reasonLabel;
    reasonLabel.font = [UIFont systemFontOfSize:14];
    reasonLabel.textAlignment = NSTextAlignmentCenter;
    reasonLabel.textColor = ComonCharColor;
    [resultView addSubview:reasonLabel];
    [reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resultView).offset(142);
        make.left.equalTo(resultView).offset(15);
        make.right.equalTo(resultView).offset(-15);
    }];
    if (self.viewModel.orderStates == PartnerOrderStatesFail) {
        self.resultView.hidden = NO;
        resultLabel.text = @"提现失败";
        photoImageView.image = [UIImage imageNamed:@"hyrshibai"];
        self.reasonLabel.numberOfLines = 0;
        [resultView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(210);
        }];
        return;
    }
    
    if (self.viewModel.orderStates == PartnerOrderStatesSuccess) {
        self.resultView.hidden = NO;
        resultLabel.text = @"提交成功";
        reasonLabel.text = @"工作人员将尽快为您处理";
        photoImageView.image = [UIImage imageNamed:@"hyrchenggong"];
        UILabel * timeLabel = [[UILabel alloc] init];
        self.timeLabel = timeLabel;
        timeLabel.text = @"3s后返回合伙人中心";
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.textColor = ComonCharColor;
        [scrollView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(resultView.mas_bottom).offset(75);
            make.centerX.equalTo(resultView);
        }];
        
       self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(delayMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//        int64_t delayInSeconds = 3;      // 延迟的时间
//        /*
//         *@parameter 1,时间参照，从此刻开始计时
//         *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
//         */
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            for (UIViewController *vc in self.navigationController.viewControllers) {
//
//                if ([vc isKindOfClass:[HXPartnerCenterViewController class]]) {
//                    [self.navigationController popToViewController:vc animated:YES];
//                    break;
//                }
//            }
//        });

        return;
    }
    
    UIView * orderView = [[UIView alloc] init];
    self.orderView = orderView;
    self.orderView.hidden = YES;
    orderView.backgroundColor = CommonBackViewColor;
    [scrollView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resultView.mas_bottom).offset(0);
        make.left.equalTo(scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(100);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    [orderView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(orderView).offset(15);
        make.right.equalTo(orderView).offset(-15);
    }];
    
    NSArray * nameArr = @[@"购买套餐",@"提交时间",@"完成时间"];
    for (int i =0; i<3; i++) {
        UILabel * nameLabel = [[UILabel alloc] init];
        nameLabel.text = [nameArr objectAtIndex:i];
        nameLabel.textColor = ComonCharColor;
        nameLabel.font = [UIFont systemFontOfSize:14];
        [orderView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderView).offset(15);
            make.top.equalTo(orderView).offset(18+i*26);
        }];
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = ComonTextColor;
        [orderView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderView).offset(90);
            make.centerY.equalTo(nameLabel);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-105);
            make.height.mas_equalTo(14);
        }];
        if(i==0) {
            self.nameLabel = titleLabel;
            UILabel * moneyLabel = [[UILabel alloc] init];
            self.moneyLabel = moneyLabel;
            moneyLabel.font = [UIFont systemFontOfSize:14];
            moneyLabel.textColor = ComonTextColor;
            [orderView addSubview:moneyLabel];
            [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.nameLabel.mas_right).offset(2);
                make.centerY.equalTo(nameLabel);
                make.height.mas_equalTo(14);
            }];
        }else if (i==1) {
            self.applyTimeLabel = titleLabel;
        }else {
            self.completionTimeLabel = titleLabel;
            self.completionLabel = nameLabel;
        }
        
    }
    
    [self creatTabelView];
}
-(void)delayMethod {
    //倒计时-1
    _second--;
    self.timeLabel.text = [NSString stringWithFormat:@"%lds后返回合伙人中心",_second];
    if(_second==0||_second<0){
        [_timer invalidate];
        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:[HXPartnerCenterViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}
-(void)request {
    
    [self.viewModel archiveResultWithReturnBlock:^{
        self.resultView.hidden = NO;
        self.nameLabel.text = [NSString stringWithFormat:@"%@",self.viewModel.resultModel.packageName.length!=0?self.viewModel.resultModel.packageName:@""];
        self.moneyLabel.text = [NSString stringWithFormat:@"(¥%@)",self.viewModel.resultModel.orderPrice.length!=0?[NumAgent roundDown:self.viewModel.resultModel.orderPrice ifKeep:YES]:@""];
        CGFloat  nameWidth =  [Helper widthOfString:self.nameLabel.text font:[UIFont systemFontOfSize:14] height:14];
        CGFloat  moneyWidth =  [Helper widthOfString:self.moneyLabel.text font:[UIFont systemFontOfSize:14] height:14];
        if (nameWidth+moneyWidth >SCREEN_WIDTH-107) {
            [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-107-moneyWidth);
            }];
        }else {
            [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-107);
            }];
        }
        
        
        self.applyTimeLabel.text = self.viewModel.resultModel.createTime.length!=0?self.viewModel.resultModel.createTime:@"";
        self.completionTimeLabel.text = self.viewModel.resultModel.overTime.length!=0?self.viewModel.resultModel.overTime:@"";
        [self changeButtonStates];
        [_tableView reloadData];
        switch (self.viewModel.orderStates) {
            case PartnerOrderStatesCommen:
            {
                
            }
                break;
            case PartnerOrderStatesUnpaid:
            {
                self.photoImageView.image = [UIImage imageNamed:@"hyrdaizhifu"];
                self.resultLabel.text = @"待支付";
                self.reasonLabel.text = @"工作人员将尽快为您处理";
                _orderView.hidden = NO;
                self.cancelBtn.hidden = NO;
                self.completionTimeLabel.hidden = YES;
                self.completionLabel.hidden = YES;
                [self.orderView mas_updateConstraints:^(MASConstraintMaker *make){
                    make.height.mas_equalTo(72);
                }];
                if ([self.viewModel.isPartner boolValue]) {
                    _promptLabel.hidden = YES;
                    _tableView.hidden = YES;
                     [self.scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT-64)];
                }else {
                [self.scrollView setContentSize:CGSizeMake(0, _tableView.origin.y+_tableView.size.height+30)];
                _promptLabel.hidden = NO;
                _tableView.hidden = NO;
                }
            }
                break;
            case PartnerOrderStatesPaid:
            {
                self.cancelBtn.hidden = YES;
                self.photoImageView.image = [UIImage imageNamed:@"hyrchenggong"];
                self.resultLabel.text = @"已支付";
                self.reasonLabel.text = @"您的套餐已购买成功";
                self.orderView.hidden = NO;
                self.completionLabel.hidden = NO;
                self.completionLabel.text =@"完成时间";
                self.completionTimeLabel.hidden = NO;
                [self.orderView mas_updateConstraints:^(MASConstraintMaker *make){
                    make.height.mas_equalTo(100);
                }];
                if ([self.viewModel.isPartner boolValue]) {
                    _promptLabel.hidden = YES;
                    _tableView.hidden = YES;
                    [self.scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT-64)];
                }else {
                _promptLabel.hidden = NO;
                _tableView.hidden = NO;
                [self.scrollView setContentSize:CGSizeMake(0, _tableView.origin.y+_tableView.size.height+30)];
                }
                
            }
                break;
            case PartnerOrderStatesCancel:
            {
                self.cancelBtn.hidden = YES;;
                self.photoImageView.image = [UIImage imageNamed:@"hyrshibai"];
                self.resultLabel.text = @"已取消";
                self.reasonLabel.text = @"您的套餐已取消";
                self.orderView.hidden = NO;
                self.completionLabel.hidden = NO;
                self.completionLabel.text =@"取消时间";
                self.completionTimeLabel.hidden = NO;
                _tableView.hidden = YES;
                _promptLabel.hidden = YES;
                [self.orderView mas_updateConstraints:^(MASConstraintMaker *make){
                    make.height.mas_equalTo(100);
                }];
                [self.scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT-64)];
            }
                break;
            case PartnerOrderStatesFail:
            {
                
            }
                break;
            case PartnerOrderStatesSuccess:
            {
                
                
            }
                break;
                
                
            default:
                break;
        }
        
    } failBlock:^{
        
        
    }];
}
-(void)archivefail {
    
    [self.viewModel archiveFailWithReturnBlock:^{
        self.reasonLabel.text = [NSString stringWithFormat:@"原因: %@",self.viewModel.refuseReason.length!=0?self.viewModel.refuseReason:@""];
    } failBlock:^{
        
    }];
    
}

-(void)removeReuest {
    [self.viewModel submitCanceltWithReturnBlock:^{
        if ([self.delegate respondsToSelector:@selector(update)]) {
            [self.delegate update];
        }
        self.cancelBtn.hidden = YES;;
        self.photoImageView.image = [UIImage imageNamed:@"hyrshibai"];
        self.resultLabel.text = @"已取消";
        self.reasonLabel.text = @"您的套餐已取消";
        self.orderView.hidden = NO;
        self.completionLabel.hidden = NO;
        self.completionLabel.text =@"取消时间";
        self.completionTimeLabel.hidden = NO;
        self.completionTimeLabel.text = self.viewModel.resultModel.overTime.length!=0?self.viewModel.resultModel.overTime:@"";
        _tableView.hidden = YES;
        _promptLabel.hidden = YES;
        [self.orderView mas_updateConstraints:^(MASConstraintMaker *make){
            make.height.mas_equalTo(100);
        }];
        [self.scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT-64)];
    } failBlock:^{
        
    }];
    
    
}

-(void)creatTabelView {
    
    UIView * submitView = [[UIView alloc] init];
    self.submitView = submitView;
    submitView.hidden = YES;
    submitView.layer.cornerRadius = 10;
    submitView.layer.masksToBounds = YES;
    submitView.backgroundColor = CommonBackViewColor;
    [self.scrollView addSubview:submitView];
    
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(322);
        make.left.equalTo(self.scrollView).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_equalTo(88);
    }];
    
    UIImageView * submitImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hyrxinxi"]];
    [submitView addSubview:submitImage];
    [submitImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(submitView).offset(20);
        make.centerY.equalTo(submitView);
    }];
    
    UILabel * submitLabel = [[UILabel alloc] init];
    submitLabel.text = @"提交成功";
    submitLabel.textColor = ComonTextColor;
    submitLabel.font = [UIFont systemFontOfSize:18];
    [submitView addSubview:submitLabel];
    [submitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(submitView).offset(24);
        make.left.equalTo(submitView).offset(76);
    }];
    
    UILabel * inforLabel = [[UILabel alloc] init];
    inforLabel.text = @"您的信息已提交";
    inforLabel.textColor = ComonCharColor;
    inforLabel.font = [UIFont systemFontOfSize:14];
    [submitView addSubview:inforLabel];
    [inforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(submitView).offset(50);
        make.left.equalTo(submitView).offset(76);
    }];
        
    UILabel * promptLabel = [[UILabel alloc] init];
    self.promptLabel = promptLabel;
    promptLabel.hidden = YES;
    promptLabel.text = @"温馨提示：请准确填写核实本人信息";
    promptLabel.font = [UIFont systemFontOfSize:14];
    promptLabel.textColor = kUIColorFromRGB(0xF5AE35);
    [self.scrollView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_bottom).offset(40);
        make.left.equalTo(self.scrollView).offset(15);
    }];
    
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.hidden = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.layer.cornerRadius = 20;
    _tableView.layer.masksToBounds = YES;
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = CommonBackViewColor;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.scrollView addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_bottom).offset(70);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.left.equalTo(self.scrollView).offset(15);
        make.height.mas_equalTo(336);
    }];
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 65)];
    headView.backgroundColor = CommonBackViewColor;
    _tableView.tableHeaderView = headView;

    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请填写本人信息";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = ComonTextColor;
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.centerX.equalTo(headView);
    }];
    /**
     *  footView
     */
    
    UIView * footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 105)];
    footView.backgroundColor = CommonBackViewColor;
    [_tableView setTableFooterView:footView];
    
    
    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-60, 50)];
    self.referButton = referButton;
    referButton.layer.cornerRadius = 25;
    referButton.layer.masksToBounds = YES;
    [referButton setTitle:@"提交" forState:UIControlStateNormal];
    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:referButton style:UIControlStateNormal];
    [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
    [footView addSubview:referButton];

}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity1 = @"IdentityInfoCell1";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = HXRGB(221, 221, 221);
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.contentView);
            make.height.mas_equalTo(0.5);
            make.left.equalTo(cell.contentView).mas_offset(15);
            make.right.equalTo(cell.contentView).offset(-15);
        }];
        
        cell.nameLabel.text = @"姓名";
        cell.writeTextfield.delegate = self;
        cell.writeTextfield.textAlignment = NSTextAlignmentLeft;
        cell.writeTextfield.font = [UIFont systemFontOfSize:14];
        cell.writeTextfield.tag = indexPath.row+indexPath.section*10;
        [cell.writeTextfield mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(90);
            make.right.equalTo(cell.contentView).offset(-15);
            make.centerY.equalTo(cell.contentView);
            make.top.and.bottom.equalTo(cell.contentView);
        }];
        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    cell.writeTextfield.keyboardType = UIKeyboardTypeDefault;
    
    if (indexPath.row==0) {
        cell.nameLabel.text = @"电话";
        self.iphoneCell = cell;
        cell.writeTextfield.placeholder = @"请输入电话";
        cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
        cell.writeTextfield.text = self.viewModel.iphoneStr.length!=0?self.viewModel.iphoneStr:@"";
    }else if (indexPath.row==1) {
        cell.nameLabel.text = @"姓名";
        self.nameCell = cell;
        cell.writeTextfield.placeholder = @"请输入姓名";
        cell.writeTextfield.text = self.viewModel.nameStr.length!=0?self.viewModel.nameStr:@"";
    }else  {
        cell.nameLabel.text = @"身份证";
        cell.writeTextfield.placeholder = @"请输入身份证号";
        self.identyCell = cell;
        cell.writeTextfield.text = self.viewModel.identyStr.length!=0?self.viewModel.identyStr:@"";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}
#pragma mark-textField代理
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.identyCell.writeTextfield) {
        self.NumKeyBoard = [JCKeyBoardNum show];
        textField.inputView = self.NumKeyBoard;
        __weak typeof(self) weakSelf = self;
        //点击键盘
        self.NumKeyBoard.completeBlock = ^(NSString *text,NSInteger tag) {
            switch (tag) {
                case 9:
                    if (weakSelf.viewModel.identyStr.length!=0 &&![weakSelf.viewModel.identyStr containsString:@"X"]&&weakSelf.viewModel.identyStr.length==17 ) {
                        
                        [weakSelf.identyCell.writeTextfield changTextWithNSString:@"X"];
                        weakSelf.viewModel.identyStr = weakSelf.identyCell.writeTextfield.text;
                    }
                    
                    break;
                case 11:
                    //点击删除按钮
                    [weakSelf clickDeleteBtn];
                    weakSelf.viewModel.identyStr = weakSelf.identyCell.writeTextfield.text;
                    break;
                default:
                    //点击数字键盘
                    [weakSelf.identyCell.writeTextfield changTextWithNSString:text];
                    weakSelf.viewModel.identyStr = weakSelf.identyCell.writeTextfield.text;
                    break;
            }
            if ([textField isEqual:weakSelf.identyCell.writeTextfield]) {
                if(textField.text.length > 18) {
                    textField.text = [textField.text substringToIndex:18];
                }
                weakSelf.viewModel.identyStr = textField.text;
            }
            [weakSelf changeButtonStates];
        };
    }
    return YES;
}
- (void)clickDeleteBtn
{
    if (self.identyCell.writeTextfield.text.length > 0) {
        self.identyCell.writeTextfield.text = [self.identyCell.writeTextfield.text substringToIndex:self.identyCell.writeTextfield.text.length - 1];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.numberTextField = textField;
    //    [textField keyBoardEvent];
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if ([self.nameCell.writeTextfield isEqual:textField]) {
        [Helper textField:textField length:5];
        self.viewModel.nameStr = textField.text;
    }
    if ([textField isEqual:self.identyCell.writeTextfield]) {
        if(textField.text.length > 18) {
            textField.text = [textField.text substringToIndex:18];
        }
        self.viewModel.identyStr = textField.text;
    }
    if ([textField isEqual:self.iphoneCell.writeTextfield]){
        if(textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        self.viewModel.iphoneStr = textField.text;
    }
    
    
    [self changeButtonStates];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger allowedLength = 100;
    NSString  *astring      = @"";
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    
    if ([NSString isBlankString:astring]) {
        if ([textField.text length] < allowedLength || [string length] == 0) {
            return YES;
        }else {
            [textField shakeAnimation];
            return NO;
        }
    } else {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:astring] invertedSet];
        //按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL canChange     = [string isEqualToString:filtered];
        
        if ((canChange && [textField.text length] < allowedLength) || [string length] == 0) {
            return YES;
        }else {
            [textField shakeAnimation];
            return NO;
        }
    }
    
}
-(void)changeButtonStates {
    
    if (self.viewModel.nameStr.length!=0&&self.viewModel.identyStr.length!=0&&self.viewModel.iphoneStr.length!=0) {
        self.referButton.enabled = YES;
        [Helper createImageWithColor:ComonBackColor button:self.referButton style:UIControlStateNormal];
    }else {
//        self.referButton.enabled = NO;
        [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:self.referButton style:UIControlStateNormal];
    }
}

- (void) notifierKeyboardWillShow:(NSNotification*)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect oldframe = [self.numberTextField convertRect:self.numberTextField.bounds toView:[UIApplication sharedApplication].keyWindow];
    self.height = SCREEN_HEIGHT-oldframe.size.height-oldframe.origin.y-keyboardRect.size.height-15;
    if (self.height<0) {
        CGPoint scrollPoint = CGPointMake(0.0,_scrollView.contentOffset.y+ -self.height);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}
- (void) notifierKeyboardWillHide:(NSNotification*)notification {
    if (self.height<0) {
        CGPoint scrollPoint = CGPointMake(0.0,_scrollView.contentOffset.y- -self.height);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}

-(void)cancelBtnAction {
    HXScorePromptView* promptView = [[HXScorePromptView alloc] initWithName:@"" TitleArr:@[@"您确定要取消？"] selectNameArr:@[@"取消",@"确定"] comBool:YES sureBlock:^{
        
        self.viewModel.orderStates = PartnerOrderStatesCancel;
        [self removeReuest];
    } cancelBlock:^{
        
    }];
    [promptView showAlert];
}

#pragma mark -- 提交资料
-(void)registerAction {
    [self.view endEditing:YES];
    if (self.viewModel.nameStr.length==0) {
        [KeyWindow displayMessage:@"请填写姓名"];
        return;
    }
    if (self.viewModel.identyStr.length==0) {
        [KeyWindow displayMessage:@"请填写身份证号码"];
        return;
    }
    if (self.viewModel.iphoneStr.length==0) {
        [KeyWindow displayMessage:@"请填写电话号码"];
        return;
    }
    if (self.viewModel.identyStr.length<15) {
        [KeyWindow displayMessage:@"请填写正确的身份证号码"];
        return;
    }
    //    if (![Helper justIdentityCard:self.viewModel.identyStr]) {
    //        [KeyWindow displayMessage:@"请填写正确的身份证号码"];
    //        return;
    //    }
    [self submit];

    
}
-(void)submit {
    [self.viewModel submitInformationWithReturnBlock:^{
        self.submitView.hidden = NO;
        self.promptLabel.hidden = YES;
        _tableView.hidden = YES;
        [self.scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT-64)];
        
    } failBlock:^{
        
    }];
}
-(void)onBack {
    if (self.viewModel.orderStates == PartnerOrderStatesSuccess) {
        [self.timer invalidate];
        self.timer = nil;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:[HXPartnerCenterViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
