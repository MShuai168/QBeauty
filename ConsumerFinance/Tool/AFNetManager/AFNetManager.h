//
//  AFNetManager.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/26.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ResponseModel.h"
#import "MD5Encryption.h"

typedef NS_ENUM(NSUInteger, NetWorkStatus) {
    NetWorkStatusNone,
    NetWorkStatusWiFi,
    NetWorkStatusWWAN,
};

UIKIT_EXTERN NSString* const access_key;

typedef void (^SuccessResult)(ResponseModel *object);
typedef void (^FailResult)(ErrorModel *error);
typedef void (^HtmlUrl)(NSString *url);

@interface AFNetManager : AFHTTPSessionManager

+ (instancetype)manager;

/**
 *  判断有无网络
 *
 *  @return 有无网络
 */
+ (BOOL)isHaveNet;

/**
 *  获取网络类型
 *
 *  @return (WiFi/3G/NoNet)
 */
+ (NetWorkStatus)getNetworkReachabilityStatus;

/**
 *  实时监听网络状态
 */
+ (void)isConnectionAvailable;

/**
 *  取消所有请求操作
 */
- (void)cancelAllRequests;

/**
 *  post请求
 *
 *  @param head       请求头部分（字典 tradeCode、tradeType 必传参数）
 *  @param body       请求体部分（字典）
 *  @param success    成功结果回调
 *  @param fail       失败结果回调
 */
- (void)postRequestWithHeadParameter:(id)head bodyParameter:(id)body success:(SuccessResult)success fail:(FailResult)fail;

/**
 *  get请求
 *
 *  @param head       请求头部分（字典 tradeCode、tradeType 必传参数）
 *  @param body       请求体部分
 *  @param success    成功结果回调
 *  @param fail       失败结果回调
 */
- (void)getRequestWithHeadParameter:(id)head bodyParameter:(id)body success:(SuccessResult)success fail:(FailResult)fail;

/**
 *  获取webview请求链接
 *
 *  @param head       请求头部分（字典 tradeCode、tradeType 必传参数）
 *  @param body       请求体部分
 *  @param url        webview请求链接
 */
- (void)getHtmlUrlWithHeadParameter:(id)head bodyParameter:(id)body htmlUrl:(HtmlUrl)url;

/**
 注册判断

 @param body 数据字典
 @param url 网址
 @param success 成功回调
 @param fail 失败回调
 */
-(void)getJHYinformationWithBodyParameter:(id)body url:(NSString *)url success:(SuccessResult)success fail:(FailResult)fail;

- (void)getReduceHtmlUrlWithHeadParameter:(id)head bodyParameter:(id)body htmlUrl:(HtmlUrl)url;

- (void)getXyReduceHtmlUrlWithHeadParameter:(id)head bodyParameter:(id)body htmlUrl:(HtmlUrl)url;

/**
 身份证姓名 身份证号码匹配

 @param body 数据字典
 @param url 链接
 @param success 成功回调
 @param fail 失败回调
 */
- (void)postRequestWithBodyParameter:(id)body  url:(NSString *)url success:(SuccessResult)success fail:(FailResult)fail;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/*!
 * @brief url编码
 * @return 过滤后的字符串请求链接
 */
- (NSString *)encodeString:(NSString *)unencodedString;

/*!
 * @brief url解码
 * @return 过滤后的字符串请求链接
 */
- (NSString *)decodeString:(NSString *)encodedString;

@end




