//
//  AFNetManager.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/26.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "AFNetManager.h"

static AFNetManager *manager;

@implementation AFNetManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFNetManager alloc] init];
        manager.requestSerializer.timeoutInterval = 40;
        
    });
    return manager;
    
}

- (instancetype)init {
    if (self == [super initWithBaseURL:[NSURL URLWithString:kNewAPIHost]]) {
        
//        #ifdef DEBUG
//            NSLog(@"kAPIHost地址:%@", kNewAPIHost);
//        #endif
//
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                             @"text/plain",
                                                             @"text/html",
                                                             @"application/json",
                                                             @"text/json",
                                                             @"text/javascript", nil];
        self.securityPolicy.allowInvalidCertificates   = NO;
        self.requestSerializer                         = [AFJSONRequestSerializer serializer];
        self.requestSerializer.timeoutInterval         = 5;
    }
    return self;
}

#pragma mark - 网络状态相关

+ (BOOL)isHaveNet {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (NetWorkStatus)getNetworkReachabilityStatus {
    
    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusNotReachable:     return NetWorkStatusNone; break;
        case AFNetworkReachabilityStatusReachableViaWiFi: return NetWorkStatusWiFi; break;
        case AFNetworkReachabilityStatusReachableViaWWAN: return NetWorkStatusWWAN; break;
        default: return NetWorkStatusNone; break;
    }
    
}

+ (void)isConnectionAvailable {
    
    __block BOOL launchFirst = YES;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != AFNetworkReachabilityStatusNotReachable) {
            if (!launchFirst) [KeyWindow displayMessage:DefineText_NetRestore];
        } else {
            [KeyWindow displayMessage:DefineText_NotNet];
        }
        launchFirst = NO;
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - 网络请求相关

- (void)cancelAllRequests{
    [self.operationQueue cancelAllOperations];
}


- (void)postRequestWithHeadParameter:(id)head bodyParameter:(id)body success:(SuccessResult)success fail:(FailResult)fail {
    
    [self POST:@"" parameters:[self parseUploadWithHeadParameter:head bodyParameter:body] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id response = [self parseResponseObject:responseObject];
        
        if (response) {
            
            if ([response isKindOfClass:[ResponseModel class]]) {
                success((ResponseModel *)response);
            } else if ([response isKindOfClass:[ErrorModel class]]){
                fail((ErrorModel *)response);
            }
        } else {
            ErrorModel *obj = [[ErrorModel alloc] init];
            obj.errorCode   = nil;
            obj.errorMsg    = @"网络异常";
            
            fail(obj);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            ErrorModel *obj = [[ErrorModel alloc] init];
            obj.errorCode   = @"3840";
            obj.errorMsg    = [error.localizedDescription isHaveChinese] ? error.localizedDescription : @"网络繁忙，请稍后重试";
            
            if (error.code == 3840) {
//                [KeyWindow displayMessage:@"网络异常,请稍后再试"];
            } else{
               
            }
            
            fail(obj);
        }
    }];
}

- (void)getRequestWithHeadParameter:(id)head bodyParameter:(id)body success:(SuccessResult)success fail:(FailResult)fail {
    
    [self GET:@"" parameters:[self parseUploadWithHeadParameter:head bodyParameter:body] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id response = [self parseResponseObject:responseObject];
        if (!response) fail(nil);
        
        if (response) {
            
            if ([response isKindOfClass:[ResponseModel class]]) {
                success((ResponseModel *)response);
            } else if ([response isKindOfClass:[ErrorModel class]]){
                fail((ErrorModel *)response);
            }
        } else {
            ErrorModel *obj = [[ErrorModel alloc] init];
            obj.errorCode   = nil;
            obj.errorMsg    = @"网络异常";
            
            [KeyWindow displayMessage:obj.errorMsg];
            
            fail(obj);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            ErrorModel *obj = [[ErrorModel alloc] init];
            obj.errorCode   = @"3840";
            
            obj.errorMsg    = [error.localizedDescription isHaveChinese] ? error.localizedDescription : @"网络繁忙，请稍后重试";
            
            if (error.code == 3840) {
                //[KeyWindow displayMessage:@"网络异常,请稍后再试"];
            } else{
                [KeyWindow displayMessage:obj.errorMsg];
            }
            
            fail(obj);
        }
    }];
}

-(void)getJHYinformationWithBodyParameter:(id)body url:(NSString *)url success:(SuccessResult)success fail:(FailResult)fail {
    [self GET:url parameters:body progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            ErrorModel *obj = [[ErrorModel alloc] init];
            obj.errorCode   = @"3840";
            
            obj.errorMsg    = [error.localizedDescription isHaveChinese] ? error.localizedDescription : @"网络繁忙，请稍后重试";
            
            fail(obj);
        }
    }];
}
#pragma mark -- 身份姓名 身份证号码验证
- (void)postRequestWithBodyParameter:(id)body  url:(NSString *)url success:(SuccessResult)success fail:(FailResult)fail {
    
    [self POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            ErrorModel *obj = [[ErrorModel alloc] init];
            obj.errorCode   = @"3840";
            
            obj.errorMsg    = [error.localizedDescription isHaveChinese] ? error.localizedDescription : @"网络繁忙，请稍后重试";
            
            if (error.code == 3840) {
                //[KeyWindow displayMessage:@"网络异常,请稍后再试"];
            } else{
                [KeyWindow displayMessage:obj.errorMsg];
            }
            
            fail(obj);
        }
    }];
}
#pragma mark - private Method

/*!
 * @brief 解析返回的数据
 * @param responseObject 字典
 * @return 正确返回ResponseModel对象，错误返回ErrorModel对象
 */
- (id)parseResponseObject:(id)responseObject {
    
    if (!responseObject) {
        return nil;
    }
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSString *json         = responseObject[@"JSON"];
        NSDictionary *dic      = [self dictionaryWithJsonString:json];
        
//        NSLog(@"respones = %@",dic);
        
        ResponseModel *success = [ResponseModel mj_objectWithKeyValues:dic];
        
        if (![NSString isBlankString:success.head.token] &&
            ![NSString isBlankString:success.head.session]) {
            NSDictionary *userInfo = @{@"token" : success.head.token ? success.head.token : @"",
                                       @"session" : success.head.session ? success.head.session : @""};
            [[AppManager manager] saveUserData:userInfo completed:nil];
        }
        
        if ([success.head.responseCode integerValue] == 9999) {
            
            ErrorModel *error  = [[ErrorModel alloc] init];
            error.errorCode    = success.head.responseCode;
            error.errorMsg     = @"网络繁忙，请稍后重试";
            
            [KeyWindow displayMessage:error.errorMsg];
            
            return error;
        }
        
        if ([success.head.responseCode integerValue] == 6666) {
            ErrorModel *error  = [[ErrorModel alloc] init];
            error.errorCode    = success.head.responseCode;
            error.errorMsg     = @"登录已失效，请重新登录";
            
            [KeyWindow displayMessage:error.errorMsg];
            
            [[AppManager manager] signOutProgressHandler:[self activityViewController]
                                                userInfo:nil];
            
            return error;
        }
        
        if (![success.head.responseCode isEqualToString:@"0000"]) {
            if (success.head.responseMsg.length!=0) {
                
                [KeyWindow displayMessage:success.head.responseMsg];
            }
        }
        
        return success;
    }
    
    return nil;
}


/*!
 * @brief 解析上传的数据
 * @param head 字典
 * @param body 字典
 * @return 返回特殊JSON格式的字符串
 */
- (NSDictionary *)parseUploadWithHeadParameter:(id)head bodyParameter:(id)body {
    //- (NSString *)parseUploadWithHeadParameter:(id)head bodyParameter:(id)body
    //return json;
    //原先在AFNetworking里面添加是否为字符串判断 所以传递字符串不会崩溃  现在改动字符串转换成字典传递 这样第三方库不需要变动
    
    
    NSString *session = [AppManager manager].userData.session ? [AppManager manager].userData.session : @"";
    NSString *token   = [AppManager manager].userData.token ? [AppManager manager].userData.token : @"";
    NSString *flowID  = [NSString generateRandomString];
    
    NSMutableDictionary *headDict = [head mutableCopy];
    
    NSDictionary *headDic = @{@"version"       :   SHORT_VERSION,
                              @"channel"       :   @"test",
                              @"device"        :   @"ios",
                              @"tradeTime"     :   @"",
                              @"flowID"        :   flowID,
                              @"msgType"       :   @"json",
                              @"session"       :   session,
                              @"token"         :   token,
                              @"responseTime"  :   @"",
                              @"responseMsg"   :   @"",
                              @"tradeStatus"   :   @"",
                              @"operatorID"    :   @"test",
                              @"tradeCode"     :   @"",
                              @"tradeType"     :   @"appService"};
    
    NSMutableDictionary *headDictionary = [headDic mutableCopy];
    [headDictionary addEntriesFromDictionary:headDict];
    headDic = headDictionary;
    
    NSDictionary *bodyDic = (NSDictionary *)body;
    
    NSString *headString = [self jsonStringWithDictionary:headDic insert:YES];
    NSString *bodyString = [self jsonStringWithDictionary:bodyDic insert:YES];
    
    NSString *headStr    = [NSString stringWithFormat:@"\\\"head\\\":%@",headString];
    NSString *bodyStr    = [NSString stringWithFormat:@"\\\"body\\\":%@",bodyString];
    
    NSString *json       = [NSString stringWithFormat:@"{\"JSON\":\"{%@,%@}\"",headStr,bodyStr];
    json                 = [json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    json                 = [json stringByReplacingOccurrencesOfString:@" " withString:@""];
    json                 = [json stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    
    NSString *A                  = [self jsonStringWithDictionary:headDic insert:NO];
    NSString *B                  = [self jsonStringWithDictionary:bodyDic insert:NO];
    
    NSString *headA              = [NSString stringWithFormat:@"\"head\":%@",A];
    NSString *bodyB              = [NSString stringWithFormat:@"\"body\":%@",B];
    
    NSString *msgJSON            = [NSString stringWithFormat:@"{%@,%@}",headA,bodyB];
    msgJSON                      = [msgJSON stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    msgJSON                      = [msgJSON stringByReplacingOccurrencesOfString:@" " withString:@""];
    msgJSON                      = [msgJSON stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    
    NSString *encryption         = [NSString stringWithFormat:@"%@%@json%@",access_key,headDic[@"tradeCode"],msgJSON];
    NSString *encryption_md5     = [MD5Encryption md5by32:encryption];
    NSString *MAC                = [NSString stringWithFormat:@",\"MAC\":\"%@\"}",encryption_md5];
    
    json                         = [json stringByAppendingString:MAC];
    
    
//    NSLog(@"request = %@",json);
    
    return [self dictionaryWithJsonString:json];
}

/** 删除所有的转译字符 */
- (NSString *)deleteTranslation:(NSString *)string {
    
    NSMutableString *responseString = [NSMutableString stringWithString:string];
    
    NSString *character = nil;
    
    for (NSInteger i = 0; i < responseString.length; i ++) {
        
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        
        if ([character isEqualToString:@"\\"] ||
            [character isEqualToString:@"\a"] ||
            [character isEqualToString:@"\b"] ||
            [character isEqualToString:@"\n"] ||
            [character isEqualToString:@"\r"] ||
            [character isEqualToString:@"\t"] ||
            [character isEqualToString:@"\v"] ||
            [character isEqualToString:@"\""] ||
            [character isEqualToString:@"\'"])
            
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    return responseString;
}

/*!
 * @brief 把字典转换成格式化的JSON格式的字符串
 * @param dic 字典
 * @param insert 是否插入"\"
 * @return 返回JSON格式的字符串
 */
- (NSString *)jsonStringWithDictionary:(NSDictionary *)dic insert:(BOOL)insert{
    
    if (dic == nil) {
        return @"";
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    if(error) {
        NSLog(@"dictionary解析失败：%@",error);
        return @"";
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (!insert) return jsonString;
    
    NSString *json = [jsonString copy];
    
    for (NSInteger i = 0, j = 0; i < [jsonString length]; i++) {
        
        NSString *s = [jsonString substringWithRange:NSMakeRange(i, 1)];
        
        if ([s isEqualToString:@"\""]) {
            
            NSRange range = NSMakeRange(i + j, 1);
            
            json = [json stringByReplacingCharactersInRange:range withString:@"\\\""];
            
            j++;
        }
    }
    return json;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if ([NSString isBlankString:jsonString]) {
        return nil;
    }
    
    NSString *json = [jsonString stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //NSLog(@"json解析失败：%@",err);
        return [self filterDictionaryWithJsonString:jsonString];
    }
    return dic;
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典(不进行\"   --> "的替换)
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)filterDictionaryWithJsonString:(NSString *)jsonString {
    
    if ([NSString isBlankString:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/*!
 * @brief 获取当前所在控制器
 * @return 当前所在控制器
 */
- (UIViewController *)activityViewController {
    
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for(UIWindow *tmpWin in windows) {
            
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    
    if([viewsArray count] > 0) {
        
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            
            activityViewController = nextResponder;
            
        } else {
            
            activityViewController = window.rootViewController;
        }
    }
    return activityViewController;
}

#pragma mark - HTML 相关

- (void)getHtmlUrlWithHeadParameter:(id)head bodyParameter:(id)body htmlUrl:(HtmlUrl)url {
    
    NSString *urlString = [self parseHtmlWithHeadParameter:head bodyParameter:body];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"{\"json\":" withString:@"json="];
    urlString = [urlString substringToIndex:urlString.length - 1];
    urlString = [@"https://ios-yifenqi.huaxiafinance.com/huaxia-front/showContractPage.do?" stringByAppendingString:urlString];
    urlString = [self encodeString:urlString];
    
    if (url){
        url (urlString);
    }
}

- (void)getReduceHtmlUrlWithHeadParameter:(id)head bodyParameter:(id)body htmlUrl:(HtmlUrl)url {
    
    NSString *urlString = [self parseHtmlWithHeadParameter:head bodyParameter:body];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"{\"json\":" withString:@"json="];
    urlString = [urlString substringToIndex:urlString.length - 1];
    urlString = [@"https://ios-yifenqi.huaxiafinance.com/huaxia-front/showContractSupPage?" stringByAppendingString:urlString];
    urlString = [self encodeString:urlString];
    
    if (url){
        url (urlString);
    }
}

- (void)getXyReduceHtmlUrlWithHeadParameter:(id)head bodyParameter:(id)body htmlUrl:(HtmlUrl)url {
    
    NSString *urlString = [self parseHtmlWithHeadParameter:head bodyParameter:body];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"{\"json\":" withString:@"json="];
    urlString = [urlString substringToIndex:urlString.length - 1];
    urlString = [@"https://ios-yifenqi.huaxiafinance.com/huaxia-front/showContractPage?" stringByAppendingString:urlString];
    urlString = [self encodeString:urlString];
    
    if (url){
        url (urlString);
    }
}

/*!
 * @brief url编码
 * @return 过滤后的字符串请求链接
 */
- (NSString *)encodeString:(NSString *)unencodedString{
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"+$\"{}",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

/*!
 * @brief url解码
 * @return 过滤后的字符串请求链接
 */
- (NSString *)decodeString:(NSString *)encodedString {
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (NSString *)parseHtmlWithHeadParameter:(id)head bodyParameter:(id)body {
    
    NSString *flowID  = [NSString generateRandomString];
    
    NSDictionary *headDic = @{@"version"       :   SHORT_VERSION,
                              @"channel"       :   @"test",
                              @"device"        :   @"ios",
                              @"tradeTime"     :   @"",
                              @"flowID"        :   flowID,
                              @"msgType"       :   @"json",
                              @"session"       :   @"",
                              @"token"         :   @"",
                              @"responseTime"  :   @"",
                              @"responseMsg"   :   @"",
                              @"tradeStatus"   :   @"",
                              @"operatorID"    :   @"test",
                              @"tradeCode"     :   @"",
                              @"tradeType"     :   @"appService"};
    
    NSMutableDictionary *headDictionary = [headDic mutableCopy];
    [headDictionary addEntriesFromDictionary:head];
    headDic = headDictionary;
    
    NSDictionary *bodyDic = (NSDictionary *)body;
    
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithObject:@{@"head":headDic, @"body":bodyDic}
                                                                      forKey:@"json"];
    
    NSString *json = [self jsonStringWithDictionary:jsonDic];
    
    return json;
}

- (NSString *)jsonStringWithDictionary:(NSDictionary *)dic {
    
    if (dic == nil) {
        return @"";
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    if(error) {
        NSLog(@"dictionary解析失败：%@",error);
        return @"";
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
}

@end
