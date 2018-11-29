//
//  AppManager.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/21.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "AppManager.h"
#import "MainTabBarController.h"
#import "UserInfoModel.h"
#import "MyMaterialModel.h"
#import "HXSmsLoginViewController.h"
#import "PhotoSave.h"
#import "HXUserInfoModel.h"

/** 存储用户信息的key值 */
NSString* const kStorageKeyChainUserInfo    = @"storage.key.chain.user.info";
NSString* const kStorageKeyChainUserData    = @"storage.key.chain.user.data";
NSString* const kStorageKeyChainMyStatus    = @"storage.key.chain.my.status";
NSString* const kStorageKeyChainMyPhone     = @"storage.key.chain.my.phone";
NSString* const kStorageKeyChainMyAuthBool    = @"storage.key.chain.my.AuthBool";
NSString* const kStorageKeyChainHXUserInfo    = @"storage.key.chain.user.info.HX";

@interface AppManager ()<UIAlertViewDelegate>
@property (nonatomic, strong) UserDataModel  *userDataModel;
@property (nonatomic, strong) UserInfoModel  *userInfoModel;
@property (nonatomic, strong) NSString       *downloadUrl;
@property (nonatomic, strong) UpdateModel    *model;
@property (nonatomic, strong) MyMaterialModel*modelInfo;

@property (nonatomic, strong) HXUserInfoModel *hxUserInfoModel;

@property (nonatomic, strong) NSString *apiAd;
@end

@implementation AppManager


+ (AppManager *)manager {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


#pragma mark - 用户相关
- (BOOL) isOnline {
    if ([NSString isBlankString:self.hxUserInfoModel.token]) {
        return NO;
    }
    return YES;
}

- (UserDataModel *)userData {
    return self.userDataModel;
}

- (UserDataModel *)userDataModel{
    if (_userDataModel == nil) {
        [self getUserData:^(UserDataModel *dataModel) {
            _userDataModel = dataModel;
        }];
    }
    return _userDataModel;
}

- (void) getUserData:(void(^)(UserDataModel* dataModel))block {
    if (_userDataModel != nil) {
        if (block) {
            block(_userDataModel);
        }
    } else {
        NSDictionary *userInfo = (NSDictionary *)[[NSUserDefaults standardUserDefaults]
                                                  objectForKey:kStorageKeyChainUserData];
        
        _userDataModel = [UserDataModel mj_objectWithKeyValues:userInfo];
        if (block) {
            block(_userDataModel);
        }
    }
}

- (void) clearUserData:(void(^)(BOOL completed))block {
    
    _userDataModel = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStorageKeyChainUserData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (block) {
        block(YES);
    }
}

- (void) saveUserData:(NSDictionary *)userInfo completed:(void(^)(BOOL completed))block {
    
    _userDataModel = [UserDataModel mj_objectWithKeyValues:userInfo];
    
    [[NSUserDefaults standardUserDefaults] setObject:userInfo ? userInfo : @""
                                              forKey:kStorageKeyChainUserData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (block) {
        block(YES);
    }
}

#pragma mark- 存储用户状态
- (void) saveMyStatus:(NSString *)status{
    
    [[NSUserDefaults standardUserDefaults] setObject:status
                                              forKey:kStorageKeyChainMyStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) clearMyStatus:(void(^)(BOOL completed))block {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStorageKeyChainMyStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (block) {
        block(YES);
    }

}

- (NSString *) getMyStatus{
    
    NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:kStorageKeyChainMyStatus];
    
    return status;
    
}


#pragma mark - 存储手机号码
- (void) savePhoneNumber:(NSString *)phone{
    
    [[NSUserDefaults standardUserDefaults] setObject:phone
                                              forKey:kStorageKeyChainMyPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) clearPhoneNumber:(void(^)(BOOL completed))block {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStorageKeyChainMyPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (block) {
        block(YES);
    }
    
}
- (void) clearAuthBool:(void(^)(BOOL completed))block {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStorageKeyChainMyAuthBool];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (block) {
        block(YES);
    }
    
}

- (NSString*) getMyPhone{
    
    NSString* phone = [[NSUserDefaults standardUserDefaults] objectForKey:kStorageKeyChainMyPhone];
    
    return phone;
    
}


#pragma mark - 登录登出处理
- (void) signInProgressHandler:(UIViewController *)controller userInfo:(NSDictionary *)info{
    
    MainTabBarController *main = [[MainTabBarController alloc] init];
    [main.tabBarController setSelectedIndex:0];
    Nav *nav = (Nav*)main.tabBarController.viewControllers[0];
    [nav popToRootViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_CYLPlusButton_SelectIndex
                                                        object:nil
                                                      userInfo:@{@"plusButton" : @(YES)}];
    
    if (!controller) {
        return;
    }
    
    if ([controller isKindOfClass:[HXSmsLoginViewController class]]) {
      
        [controller.navigationController popViewControllerAnimated:YES];
        
    }else{
        [MBProgressHUD hideHUDForView:controller.view];
        [controller.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) signOutProgressHandler:(UIViewController *)controller userInfo:(NSDictionary *)info{
    [self clearMyStatus:nil];
    //[self clearPhoneNumber:nil];
    [self clearAuthBool:nil];
    [self clearUserInfo:nil];
    [self clearHXUserInfo:nil];
    [self clearUserData:^(BOOL completed) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_OpenScore object:nil userInfo:nil];
        if (controller) {
            [controller.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    [PhotoSave clearTable];
    
}

- (UIViewController *)getDismissViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.childViewControllers.lastObject) {
        topVC = topVC.childViewControllers.lastObject;
    }
    return topVC;
}

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

#pragma mark 获取API地址

- (NSString *)apiAddress {
    return self.apiAd;
}

#pragma mark 用户详情

- (UserInfoModel *)userInfo {
    return self.userInfoModel;
}

- (UserInfoModel *)userInfoModel{
    if (_userInfoModel == nil) {
        [self getUserInfo:^(UserInfoModel *dataModel) {
            _userInfoModel = dataModel;
        }];
    }
    return _userInfoModel;
}

- (void) getUserInfo:(void(^)(UserInfoModel* infoModel))block {
    if (_userInfoModel != nil) {
        if (block) {
            block(_userInfoModel);
        }
    } else {
        NSDictionary *userInfo = (NSDictionary *)[[NSUserDefaults standardUserDefaults]
                                                  objectForKey:kStorageKeyChainUserInfo];
        
        _userInfoModel = [UserInfoModel mj_objectWithKeyValues:userInfo];
        if (block) {
            block(_userInfoModel);
        }
    }
}

- (void) clearUserInfo:(void(^)(BOOL completed))block {
    
    _userInfoModel = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStorageKeyChainUserInfo];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPassword];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (block) {
        block(YES);
    }
}

- (void) saveUserInfo:(NSDictionary *)userInfo completed:(void(^)(BOOL completed))block {
    
    _userInfoModel = [UserInfoModel mj_objectWithKeyValues:userInfo];
    
    [[NSUserDefaults standardUserDefaults] setObject:userInfo ? userInfo : @""
                                              forKey:kStorageKeyChainUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (block) {
        block(YES);
    }
}

- (void)handleLoginWithPhone:(NSString *)phone pwd:(NSString *)pwd userInfo:(NSDictionary *)userInfo {
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:kPassword];
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:kUserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[AppManager manager] saveHXUserInfo:userInfo completed:^(BOOL completed) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_GetMyStatus object:self userInfo:nil];
        [self changeMemBer];
    }];
    [[AppManager manager] signInProgressHandler:nil userInfo:nil];
    [[AppManager manager] savePhoneNumber:phone];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_OpenScore object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_HeadPHoto object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_UserSign object:nil userInfo:nil];
    
    // TODO: 极光推送壹纷趣暂时去掉
//    NSString *alias = [[MD5Encryption md5by32:userUuid] lowercaseString];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [JPUSHService setTags:nil alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
//            NSLog(@"%da-------------%@,a-------------%@",iResCode,iTags,iAlias);
//        }];
//        [self setAlias:alias];
//    });
}

- (void)saveHXUserInfo:(NSDictionary *)userInfo completed:(void (^)(BOOL))block {
    self.hxUserInfoModel = [HXUserInfoModel mj_objectWithKeyValues:userInfo];
    
    [[NSUserDefaults standardUserDefaults] setObject:userInfo ? userInfo : @""
                                              forKey:kStorageKeyChainHXUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (block) {
        block(YES);
    }
}

- (void)getHXUserInfo:(void (^)(HXUserInfoModel *))block {
    if (self.hxUserInfoModel != nil) {
        if (block) {
            block(self.hxUserInfoModel);
        }
    } else {
        NSDictionary *userInfo = (NSDictionary *)[[NSUserDefaults standardUserDefaults]
                                                  objectForKey:kStorageKeyChainHXUserInfo];
        
        self.hxUserInfoModel = [HXUserInfoModel mj_objectWithKeyValues:userInfo];
        if (block) {
            block(self.hxUserInfoModel);
        }
    }
}

- (void)clearHXUserInfo:(void (^)(BOOL))block {
    self.hxUserInfoModel = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStorageKeyChainHXUserInfo];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPassword];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (block) {
        block(YES);
    }
}

- (HXUserInfoModel *)hxUserInfo {
    if (!_hxUserInfoModel) {
        [self getHXUserInfo:^(HXUserInfoModel *infoModel) {
            _hxUserInfoModel = infoModel;
        }];
    }
    return _hxUserInfoModel;
}

- (void)setHxUserInfoModel:(HXUserInfoModel *)hxUserInfoModel {
    _hxUserInfoModel = hxUserInfoModel;
}

//- (void)setAlias:(NSString *)alias {
//    if (userUuid.length==0) {
//        return;
//    }
//    NSDictionary *head = @{@"tradeCode" : @"0208",
//                           @"tradeType" : @"appService"};
//    NSDictionary *body = @{};
//    body = @{@"jpushPlatform" : @"1",
//             @"jpushAlias" :alias,
//             @"userUuid": userUuid
//             };
//    
//    [[AFNetManager manager] postRequestWithHeadParameter:head
//                                           bodyParameter:body
//                                                 success:^(ResponseModel *object) {
//                                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                                         
//                                                     }
//                                                     
//                                                 } fail:^(ErrorModel *error) {
//                                                     [MBProgressHUD hideHUDForView:nil];
//                                                 }];
//}

-(void)changeMemBer {
    NSDictionary * body = @{@"version":SHORT_VERSION,
                            @"device":@"iOS"
                            };
    [[HXNetManager shareManager] post:UpdateMemberUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)getApiAddress:(apiAddress)block {
    // TODO: 需要和服务端联调
//    _apiAd = kAPIAddress;
//    NSDictionary *head = @{@"tradeCode"         : @"0220",
//                           @"tradeType"         : @"appService"};
//    
//    NSDictionary *body = @{@"build"     : BUILD_VERSION};
//    
//    AFNetManager *manger = [[AFNetManager alloc] init];
//    [manger postRequestWithHeadParameter:head
//                           bodyParameter:body
//                                 success:^(ResponseModel *object) {
//                                     if (IsEqualToSuccess(object.head.responseCode)) {
//                                         NSDictionary *buildAddress = [object.body objectForKey:@"buildAddress"];
//                                         _apiAd = [buildAddress objectForKey:@"apiAddress"];
//                                         if (_apiAd.length == 0) {
//                                             _apiAd = kAPIAddress;
//                                         }
//                                         if (block) {
//                                             block();
//                                         }
//                                     }else {
//                                         _apiAd = kAPIAddress;
//                                         if (block) {
//                                             block();
//                                         }
//                                         
//                                     }
//                                     
//                                 } fail:^(ErrorModel *error) {
//                                     _apiAd = kAPIAddress;
//                                     if (block) {
//                                         block();
//                                     }
//                                 }];
}

/** 检查App更新 */
- (void) checkAppUpdate {
    
    NSDictionary *body = @{@"type"              : @"ios",
                           @"versionNumber"     : BUILD_VERSION};
    
    [[HXNetManager shareManager] get:@"appService/version" parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            
            self.model = [UpdateModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"userVersion"]];
            if ([self.model.forceUpdate isEqualToString:@"10"]) {
                //不强制
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"升级提示"
                                                                message:self.model.contents
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定",nil];
                alert.tag = 10;
                [alert show];
            }else if ([self.model.forceUpdate isEqualToString:@"20"]) {
                
                NSString *showStr = self.model.contents;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"升级提示"
                                                                message:[showStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"]
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                
                alert.tag = 20;
                [alert show];
                
            }
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 20) {
        //NSLog(@"强制更新");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.downloadUrl]];
        exit(0);
    } else {
        if (buttonIndex == 1) {
            //NSLog(@"点击更新按钮");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.downloadUrl]];
        }else{
            //NSLog(@"点击取消按钮");
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end


@implementation UpdateModel

@end
