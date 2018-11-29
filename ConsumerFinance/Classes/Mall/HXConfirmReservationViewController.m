//
//  HXConfirmReservationViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/17.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXConfirmReservationViewController.h"
#import "HXConfirmCell.h"
#import "HXBookingViewController.h"

@interface HXConfirmReservationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView * _tableView;
}
@property (nonatomic,strong)BaseTableViewCell * nameCell;
@property (nonatomic,strong)BaseTableViewCell * iphoneCell;
@property (nonatomic,strong)BaseTableViewCell * remarkCell;
@property (nonatomic,strong)UIButton * sureButton;
@end

@implementation HXConfirmReservationViewController
-(id)init {
    self = [super init];
    if (self) {
        self.viewModel = [[HXConfirmReservationViewModel alloc] initWithController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createUI];
    [self hiddeKeyBoard];
    
}
/**
 *  导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"确认预约";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = HXRGB(255, 255, 255);
}
-(void) hiddeKeyBoard{
    
    [self.view endEditing:YES];
    
}
-(void)createUI {
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    UIButton * sureButton = [[UIButton alloc] init];
    self.sureButton = sureButton;
    sureButton.hidden = NO;
    [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:sureButton style:UIControlStateNormal];
    [Helper createImageWithColor:[ComonBackColor colorWithAlphaComponent:0.7] button:sureButton style:UIControlStateHighlighted];
    [sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确认预约" forState:UIControlStateNormal];
    [sureButton setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [sureButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.view addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 3;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    static NSString *cellIdentity1 = @"IdentityInfoCell1";
    if (indexPath.section == 0) {
        HXConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.nameLabel.text = self.viewModel.name?self.viewModel.name:@"";
            cell.addressLabel.text = self.viewModel.address?self.viewModel.address:@"";
            [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:self.viewModel.imageUrl] placeholderImage:[UIImage imageNamed:@"listLogo"]];
            [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView).offset(26);
            }];
        }
        return cell;
    }else {
        
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity1];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity1];
            if (indexPath.row !=2) {
                [cell creatLine:15 hidden:NO];
            
            }
            cell.writeTextfield.textAlignment = NSTextAlignmentLeft ;
            [cell.writeTextfield mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(100);
                make.top.and.bottom.equalTo(cell.contentView);
                make.width.mas_equalTo(SCREEN_WIDTH-115);
            }];
            cell.writeTextfield.delegate =self;
        }
        cell.writeTextfield.tag = indexPath.row+indexPath.section*10+100;
        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if (indexPath.row==0) {
            cell.nameLabel.text = @"预约人";
            cell.writeTextfield.placeholder = @"请输入姓名";
            self.nameCell =cell;
        }else if(indexPath.row==1) {
            cell.nameLabel.text = @"预约手机";
            if ([[AppManager manager] getMyPhone].length!=0) {
                
                cell.writeTextfield.text = [[AppManager manager] getMyPhone];
            }
            cell.writeTextfield.placeholder = @"请填写预约手机号";
            self.iphoneCell = cell;
            cell.writeTextfield.keyboardType = UIKeyboardTypeNumberPad;
        }else {
            cell.nameLabel.text = @"备注";
            cell.writeTextfield.placeholder = @"请填写您的其他需求";
            cell.writeTextfield.enabled = YES;
            self.remarkCell = cell;
        }
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section!=0?50:90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
}

#pragma mark -- request
-(void)submitInformation {
    
    [self.viewModel submitCertificationWithName:_nameCell.writeTextfield.text phone:_iphoneCell.writeTextfield.text remark:_remarkCell.writeTextfield.text returnBlock:^{
        [KeyWindow displayMessage:@"预约成功"];
        
        HXBookingViewController *controller = [[HXBookingViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        
        NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        for (UIViewController *vc in marr) {
            if ([vc isKindOfClass:[HXConfirmReservationViewController class]]) {
                [marr removeObject:vc];
                break;
            }
        }
        self.navigationController.viewControllers = marr;
        
//        [self removeFromParentViewController];
    }];
    
}
-(void)sureButtonAction {
    if (![Helper justMobile:_iphoneCell.writeTextfield.text]) {
        [KeyWindow displayMessage:@"请输入正确的手机号"];
        return;
    }
    [self submitInformation];
}
#pragma mark-textField代理
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //    [textField keyBoardEvent];
}
-(void)textFieldDidChange:(UITextField *)textField
{
    switch (textField.tag) {
        case 110: {
            if(textField.text.length > 15) {
                textField.text = [textField.text substringToIndex:15];
            }
        }
            break;
        case 112: {
            if(textField.text.length > 20) {
                textField.text = [textField.text substringToIndex:20];
            }
            
        }
        default:
            break;
    }
   
    [self changeButtnStates];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger allowedLength = 100;
    NSString  *astring      = @"";
    
    
    switch (textField.tag) {
        case 110: {
            allowedLength = 15;
        }
            break;
        case 111: {
            allowedLength = 11;
            astring       = LIMIT_NUMBERS;
        }
            break;
        case 112: {
            allowedLength = 20;
            
        }
            break;
        case 7: {
            allowedLength = 8;
            astring       = LIMIT_NUMBERS;
        }
            break;
            
        default:
            break;
    }
    
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
-(void)changeButtnStates {
    if (self.nameCell.writeTextfield.text.length!=0 && self.iphoneCell.writeTextfield.text.length!=0) {
        [Helper createImageWithColor:ComonBackColor button:self.sureButton style:UIControlStateNormal];
        self.sureButton.enabled = YES;
        
    }else {
        
         self.sureButton.enabled = NO;
        [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:self.sureButton style:UIControlStateNormal];
    }
    
    
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
