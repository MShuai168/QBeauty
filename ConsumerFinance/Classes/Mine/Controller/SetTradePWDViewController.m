////
////  SetTradePWDViewController.m
////  HSMC
////
////  Created by Metro on 16/6/1.
////  Copyright © 2016年 晓哥. All rights reserved.
////
//
//#import "SetTradePWDViewController.h"
//#import "DKSetTradeView.h"
////#import "ForgetTradeCodeViewController.h"
////#import "SecuritySettingViewController.h"
//#import "HXBillingdetailsViewController.h"
//
//@interface SetTradePWDViewController ()
//
//@property (nonatomic,strong) DKSetTradeView *setTradeView;
//@property (nonatomic,copy) NSString *tradePasswordStr;
//@property (nonatomic,strong) DKSetTradeView *setTradeViewAgain;
//@property (nonatomic,copy) NSString *tradePasswordAgainStr;
//
//@end
//
//@implementation SetTradePWDViewController
//-(id)init {
//    self = [super init];
//    if(self) {
//        self.viewModel = [[HXSetTradePWDViewModel alloc] initWithController:self];
//        
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self editNavi];
//    [self createViewForTradePassword:@"设置6位数字支付密码"];
//    
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"设置6位数字支付密码";
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//    self.view.backgroundColor = COLOR_BACKGROUND;
//}
//- (void)viewDidAppear:(BOOL)animated{
//    
//    [super viewDidAppear:animated];
//    [_setTradeView.inputTextFiled becomeFirstResponder];
//    
//}
//
//- (void)createViewForTradePassword:(NSString *)title{
//    
//    
//    NSString *actionType = nil;
//    if (self.isForgetTradeStatus) {
//        actionType = @"2";
//    }else if (self.isUpdateTradeStatus){
//        actionType = @"1";
//    }
//    else{
//        actionType = @"0";
//    }
//    
//    __weak typeof(self) weadSelf = self;
//    self.setTradeView = [[DKSetTradeView alloc] initWithTitle:title completion:^(NSString *password) {
//        
//        weadSelf.tradePasswordStr = password;
//        [weadSelf.setTradeView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        [weadSelf.setTradeView removeFromSuperview];
//        BOOL equalBool =  [self password:password];
//        if (!equalBool) {
//            [KeyWindow displayMessage:@"密码设置过于简单"];
//            [weadSelf createViewForTradePassword:@"请重新设置6位数字支付密码"];
//            return;
//        }
//        weadSelf.setTradeViewAgain = [[DKSetTradeView alloc] initWithTitle:@"确认6位数字支付密码" completion:^(NSString *password) {
//            
//            if ([weadSelf.tradePasswordStr isEqualToString:password]) {
//                
//                NSString *oldPassword = nil;
//                if (weadSelf.isUpdateTradeStatus) {
//                    oldPassword = weadSelf.oldPasswordStr;
//                }else{
//                    oldPassword = weadSelf.tradePasswordStr;
//                }
//                
//                [self.viewModel submitPassWord:password returunBlock:^{
//                    [KeyWindow displayMessage:@"支付密码设置成功"];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_BankPassWord object:nil userInfo:nil];
//                    for (UIViewController *temp in weadSelf.navigationController.viewControllers) {
//                        if ([temp isKindOfClass:[HXBillingdetailsViewController class]]) {
//                            [weadSelf.navigationController popToViewController:temp animated:YES];
//                            return ;
//                        }
//                    }
//                    [weadSelf.navigationController popToRootViewControllerAnimated:YES];
//                }];
//                
//            }else{
//                [KeyWindow displayMessage:@"两次密码不一致"];
//                [weadSelf.setTradeViewAgain.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//                [weadSelf.setTradeViewAgain removeFromSuperview];
//                [weadSelf createViewForTradePassword:@"两次密码不一致，请重新设置"];
//                [_setTradeView.inputTextFiled becomeFirstResponder];
//                
//            }
//        }];
//        
//        [_setTradeViewAgain.inputTextFiled becomeFirstResponder];
//        [weadSelf.view addSubview:weadSelf.setTradeViewAgain];
//        
//        
//    }];
//    [self.view addSubview:self.setTradeView];
//    
//}
//- (BOOL) password:(NSString *)password
//
//{
//    
//    NSString *pattern = @"[a-zA-Z0-9]{6,19}+$";
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    
//    BOOL isMatch = [pred evaluateWithObject:password];
//    
//    if (isMatch) {
//        
//        int count = 0;
//        
//        NSString *newPassword = [password substringToIndex:1];
//        
//        for (int i = 0; i < password.length; i++) {
//            
//            NSString *newPassword1;
//            
//            if (i == 0) {
//                
//                newPassword1 = [password substringToIndex:i + 1]; //当 i 为 0 的时候  取下表为 1 的字符串
//                
//            }else{
//                
//                //当 i 大于 0 时 我们取下标为 i + 1 新的string.length 为 i 个 所有我们再从后面往前面取
//                
//                newPassword1 = [[password substringToIndex:i + 1] substringFromIndex:i];
//                
//            }
//            
//            if ([newPassword1 isEqualToString:newPassword]) {
//                
//                count++;
//                
//            }
//            
//        }
//        
//        if (count == password.length) {
//            
//            return NO; // 这里说明 count个相同的字符串，也就是所有密码输入一样了
//            
//        }
//        
//        
//        
//    }
//    
//    return isMatch;
//    
//}
//
//#pragma mark -- 更新实名信息
//- (void)queryUserRealName{
//    
//    __weak typeof(self) weadSelf = self;
//    //当用户没有实名且没有设置交易密码的情况下 需要请求接口刷新用户信息
////    [DAL queryUserRealWithUserId:[Tool userIdStr] success:^(NSString *errorCode, id result) {
////        
////        if ([errorCode isEqualToString:ErrorCode_Success]) {
////            
////            [UserDefaults setObject:[Tool encodedUserInfo:(NSDictionary *)result] forKey:@"userRealInfo"]; //保存用户基本信息
////            [UserDefaults synchronize];
////            
////            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                
////                if (weadSelf.isForgetTradeStatus || weadSelf.isUpdateTradeStatus) {
////                    
////                    for (UIViewController *vcHome in self.navigationController.viewControllers) {
////                        if ([vcHome isKindOfClass:[SecuritySettingViewController  class]]) {
////                            [weadSelf.navigationController popToViewController:vcHome animated:YES];
////                        }
////                    }
////                }else{
////                    [weadSelf.navigationController popViewControllerAnimated:YES];
////                }
////            });
////            
////        }
////        
////    } failure:nil];
//    
//}
//
//#pragma mark - Actions
//
//- (void)backBtnClicked:(id)sender
//{
//    
//    
////    if (self.isForgetTradeStatus || self.isUpdateTradeStatus) {
////        
////        for (UIViewController *vcHome in self.navigationController.viewControllers) {
////            if ([vcHome isKindOfClass:[SecuritySettingViewController  class]]) {
////                [self.navigationController popToViewController:vcHome animated:YES];
////            }
////        }
////    }else{
////        [self.navigationController popViewControllerAnimated:YES];
////    }
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//
//@end
