//
//  AppManager.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/21.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataModel.h"
#import "UserInfoModel.h"
#import "HXUserInfoModel.h"

UIKIT_EXTERN NSString* const kStorageKeyChainUserInfo;
UIKIT_EXTERN NSString* const kStorageKeyChainMyStatus;
UIKIT_EXTERN NSString* const kStorageKeyChainMyAuthBool;
typedef void(^apiAddress)(void);

@interface AppManager : NSObject

+ (AppManager *)manager;


/** 用户相关 */
- (void) getUserData:(void(^)(UserDataModel* dataModel))block;
- (void) clearUserData:(void(^)(BOOL completed))block;
- (void) saveUserData:(NSDictionary *)userInfo completed:(void(^)(BOOL completed))block;
- (BOOL) isOnline;
- (UserDataModel *)userData;

- (void) getUserInfo:(void(^)(UserInfoModel* infoModel))block;
- (void) clearUserInfo:(void(^)(BOOL completed))block;
- (void) saveUserInfo:(NSDictionary *)userInfo completed:(void(^)(BOOL completed))block;
- (UserInfoModel *)userInfo;
//- (NSString *)apiAddress;
//- (void)getApiAddress:(apiAddress)block;

// 新的
- (void) handleLoginWithPhone:(NSString *)phone pwd:(NSString *)pwd userInfo:(NSDictionary *)userInfo;
- (void) saveHXUserInfo:(NSDictionary *)userInfo completed:(void(^)(BOOL completed))block;
- (void) getHXUserInfo:(void(^)(HXUserInfoModel* infoModel))block;
- (void) clearHXUserInfo:(void(^)(BOOL completed))block;
- (HXUserInfoModel *)hxUserInfo;


/** 保存用户身份 */
- (void) saveMyStatus:(NSString *)status;
- (NSString *) getMyStatus;
- (void) clearMyStatus:(void(^)(BOOL completed))block ;

/** 登录登出处理 */
- (void) signInProgressHandler:(UIViewController *)controller userInfo:(NSDictionary *)info;
- (void) signOutProgressHandler:(UIViewController *)controller userInfo:(NSDictionary *)info;


/** 保存用户手机号 */
- (void) savePhoneNumber:(NSString *)phone;
- (void) clearPhoneNumber:(void(^)(BOOL completed))block;
- (void) clearAuthBool:(void(^)(BOOL completed))block;
- (NSString*) getMyPhone;

/** 检查App更新 */
- (void) checkAppUpdate;
@end



@interface UpdateModel : NSObject
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *versionNumber;
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, strong) NSString *publishAt;
@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, strong) NSString *forceUpdate;
@property (nonatomic, strong) NSString *versionName;

@end
