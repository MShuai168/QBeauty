////
////  HXSingletonView.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/12/28.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXSingletonView.h"
//#import "HXPartnerBankViewController.h"
//#import "HXBankWebViewController.h"
//
//
//@implementation HXSingletonView
//+ (HXSingletonView *)signletonView {
//    static id manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[self alloc] init];
//    });
//    return manager;
//}
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.failNumber = 0;
//    }
//    return self;
//}
//-(void)creatView {
//    if (_backView==nil) {
//        self.failNumber = 0 ;
//        self.bankSuccessBool = NO;
//        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIApplication sharedApplication].keyWindow.frame.size.width , [UIApplication sharedApplication].keyWindow.frame.size.height)];
//        self.backView .backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.2];
//        self.backView .frame = [UIScreen mainScreen].bounds;
//        
//        UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
//        [rootWindow addSubview:self.backView];
//        UIView * promptView = [[UIView alloc] init];
//        promptView.backgroundColor = kUIColorFromRGB(0xFCFCFC);
//        promptView.layer.cornerRadius = 5;
//        promptView.layer.masksToBounds = YES;
//        [self.backView  addSubview:promptView];
//        [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.backView);
//            make.centerX.equalTo(self.backView);
//            make.height.mas_equalTo(367);
//            make.left.equalTo(self.backView).offset(30);
//            make.right.equalTo(self.backView).offset(-30);
//        }];
//        
//        UIImageView * photoImageView = [[UIImageView alloc] init];
//        photoImageView.image = [UIImage imageNamed:@"msdownload"];
//        [promptView addSubview:photoImageView];
//        [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(promptView);
//            make.top.equalTo(promptView).offset(25);
//        }];
//        
//        UILabel * nameLabel = [[UILabel alloc] init];
//        nameLabel.text = @"温馨提示";
//        nameLabel.font = [UIFont systemFontOfSize:21];
//        nameLabel.textColor = kUIColorFromRGB(0xFF6098);
//        [promptView addSubview:nameLabel];
//        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(promptView).offset(110);
//            make.centerX.equalTo(promptView);
//        }];
//        
//        UILabel * inforLabel = [[UILabel alloc] init];
//        inforLabel.text = @"由于系统升级需要，请知晓以下事宜:";
//        inforLabel.numberOfLines = 0;
//        inforLabel.textColor = ComonTitleColor;
//        inforLabel.font = [UIFont systemFontOfSize:17];
//        [promptView addSubview:inforLabel];
//        [inforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(promptView).offset(155);
//            make.left.equalTo(promptView).offset(45);
//            make.right.equalTo(promptView).offset(-45);
//        }];
//        
//        NSArray * nameArr = @[@"1.账单暂不支持主动还款卡",@"2.自动还款卡需要您再次验证"];
//        for (int i = 0; i<2; i++) {
//            UILabel * titleLabel = [[UILabel alloc] init];
//            titleLabel.font = [UIFont systemFontOfSize:15];
//            titleLabel.textColor = ComonTitleColor;
//            titleLabel.text = [nameArr objectAtIndex:i];
//            [promptView addSubview:titleLabel];
//            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(promptView).offset(45);
//                make.top.equalTo(promptView).offset(217+i*23);
//                make.height.mas_equalTo(15);
//            }];
//        }
//        
//        UIButton * button = [[UIButton alloc] init];
//        button.backgroundColor = kUIColorFromRGB(0xFF6098);
//        [button setTitle:@"前往验证" forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//        button.layer.masksToBounds = YES;
//        button.layer.cornerRadius = 30;
//        [button setTitleColor:CommonBackViewColor forState:UIControlStateNormal];
//        [promptView addSubview:button];
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(promptView).offset(30);
//            make.right.equalTo(promptView).offset(-30);
//            make.top.equalTo(promptView).offset(287);
//            make.height.mas_equalTo(60);
//        }];
//    }else {
//        self.failNumber = 0;
//        self.bankSuccessBool = NO;
//        self.backView.hidden = NO;
//    }
//}
//
//-(void)buttonAction {
//
//    [self archiveToken];
//}
//
//
//-(void)archiveToken {
//    NSString * getUrl = [NSString stringWithFormat:@"%@/%@",self.model.tokenUrl,self.model.rasMes];
//    AFNetManager * manager = [[AFNetManager alloc] init];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
//                                                      @"text/plain",
//                                                      @"text/html",
//                                                      @"application/json",
//                                                      @"text/json",
//                                                      @"text/javascript", nil];
//    manager.securityPolicy.allowInvalidCertificates   = NO;
//    manager.requestSerializer                         = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval         = 40;
//    [MBProgressHUD showMessage:nil toView:nil];
//    [manager GET:getUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers |         NSJSONReadingMutableLeaves error:nil];
//        [self archiveHtmlUrl:[dic1 objectForKey:@"token"]];
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self failResult];
//        [MBProgressHUD hideHUDForView:nil];
//    }];
//    
//}
//
//-(void)archiveHtmlUrl:(NSString *)token {
//    AFNetManager * manager = [[AFNetManager alloc] init];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
//                                                         @"text/plain",
//                                                         @"text/html",
//                                                         @"application/json",
//                                                         @"text/json",
//                                                         @"text/javascript", nil];
//    manager.securityPolicy.allowInvalidCertificates   = NO;
////    manager.requestSerializer                         = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval         = 40;
//    NSDictionary *dic = @{
//                          @"userMobile":[HXSingletonView signletonView].model.userMobile.length!=0?[HXSingletonView signletonView].model.userMobile:@"",
//                          @"token":token.length!=0?token:@"",
//                          @"platformType":[HXSingletonView signletonView].model.platformType.length!=0?[HXSingletonView signletonView].model.platformType:@"",
//                          @"accountType":[HXSingletonView signletonView].model.accountType.length!=0?[HXSingletonView signletonView].model.accountType:@"",
//                          @"name":[HXSingletonView signletonView].model.name.length!=0?[HXSingletonView signletonView].model.name:@"",
//                          @"idCard":[HXSingletonView signletonView].model.idCard.length!=0?[HXSingletonView signletonView].model.idCard:@"",
//                          @"devic":[HXSingletonView signletonView].model.devic.length!=0?[HXSingletonView signletonView].model.devic:@"",
//                          @"appType":[HXSingletonView signletonView].model.appType.length!=0?[HXSingletonView signletonView].model.appType:@"",
//                          @"productType":[HXSingletonView signletonView].model.productType.length!=0?[HXSingletonView signletonView].model.productType:@"",
//                          @"backUrl":[HXSingletonView signletonView].model.backUrl.length!=0?[HXSingletonView signletonView].model.backUrl:@"",
//                          @"bankName":[HXSingletonView signletonView].model.bankName.length!=0?[HXSingletonView signletonView].model.bankName:@"",
//                          @"bankNo":[HXSingletonView signletonView].model.bankNo.length!=0?[HXSingletonView signletonView].model.bankNo:@"",
//                         @"mobilePhone":[HXSingletonView signletonView].model.mobilePhone.length!=0?[HXSingletonView signletonView].model.mobilePhone:@"",
//                         @"userUuid":userUuid,
//                          @"custAcctId":[HXSingletonView signletonView].model.custAcctId.length!=0?[HXSingletonView signletonView].model.custAcctId:@"",
//                          @"updateFlag":[HXSingletonView signletonView].model.updateFlag.length!=0?[HXSingletonView signletonView].model.updateFlag:@"",
//                          @"updateFlag":[HXSingletonView signletonView].model.updateFlag.length!=0?[HXSingletonView signletonView].model.updateFlag:@""
//                          };
//    [manager POST:[HXSingletonView signletonView].model.url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD hideHUDForView:nil];
//        UIViewController *topmostVC = [HXSingletonView getCurrentViewController];
//        self.backView.hidden  = YES;
//        HXBankWebViewController * bank = [[HXBankWebViewController alloc] init];
//        bank.data = responseObject;
//        [topmostVC.navigationController pushViewController:bank animated:YES];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self failResult];
//        [MBProgressHUD hideHUDForView:nil];
//    }];
//}
//
//-(void)failResult {
//    self.failNumber++;
//    if (self.failNumber==3) {
//        [HXSingletonView signletonView].backView.hidden = YES;
//        [HXSingletonView signletonView].bankSuccessBool = YES;
//    }
//    
//    
//}
//
//+ (UIViewController *)getCurrentViewController {
//    UIViewController * result = [[UIViewController alloc] init];
//    UIWindow * window = [UIApplication sharedApplication].keyWindow;
//    if (window.windowLevel != UIWindowLevelNormal) {
//        NSArray * windows = [UIApplication sharedApplication].windows;
//        for (UIWindow * temp in windows) {
//            if (temp.windowLevel == UIWindowLevelNormal) {
//                window = temp;
//                break;
//            }
//        }
//    }
//    
//    UIViewController * rootVC = window.rootViewController;
//    if (rootVC) {
//        UIView * frontView = window.subviews.firstObject;
//        if (frontView) {
//            UIResponder * nextResponder = frontView.nextResponder;
////            if (rootVC.presentedViewController) {
////                nextResponder = rootVC.presentedViewController;
////            }
//            if ([nextResponder isKindOfClass:[UITabBarController class]]) {
//                UITabBarController * tabbar = (UITabBarController *)nextResponder;
//                UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
//                result = nav.childViewControllers.lastObject;
//            }else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
//                UINavigationController * nav = (UINavigationController *)nextResponder;
//                result = nav.childViewControllers.lastObject;
//            }else {
//                if ([nextResponder isKindOfClass:[UIView class]]) {
//                    
//                }else {
//                    result = (UIViewController *)nextResponder;
//                }
//            }
//        }
//    }
//    return result;
//}
//@end
