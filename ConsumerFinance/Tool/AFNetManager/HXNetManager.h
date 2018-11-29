//
//  HXNetManager.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFNetworking.h"
#import "ResponseModel.h"
#import "MD5Encryption.h"

typedef void(^sucessResultBlock)(ResponseNewModel *responseNewModel);
typedef void(^failureResultBlock)(NSError *error);

@interface HXNetManager : AFHTTPSessionManager

+ (instancetype)shareManager;


/**
 正常的post请求

 @param urlString 网络连接
 @param body 网络请求body
 @param sucess 成功回调
 @param failure 失败回调
 */
-(void)post:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure;

/**
 post请求，但是不主动显示错误信息，需要调用者自己展示错误信息

 @param urlString 网络连接
 @param body 网络请求body
 @param sucess 成功回调
 @param failure 失败回调
 */
-(void)postNoHandleDisplayMessage:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure;

-(void)get:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure;

-(void)put:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure;

-(void)delete:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure;

-(void)otherPost:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure;

@end
