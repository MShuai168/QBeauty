//
//  HXNetManager.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXNetManager.h"

static HXNetManager *shareManager;

@interface HXNetManager()

//@property (nonatomic, assign) BOOL canHandleMessage;

@end

@implementation HXNetManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[HXNetManager alloc] init];
    });
    return shareManager;
}

- (instancetype)init {
    if (self == [super initWithBaseURL:[NSURL URLWithString:kNewAPIHost]]) {
        
    #ifdef DEBUG
        NSLog(@"kNewAPIHost地址:%@", kNewAPIHost);
    #endif
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                          @"text/plain",
                                                          @"text/html",
                                                          @"application/json",
                                                          @"text/json",
                                                          @"text/javascript", nil];
        self.securityPolicy.allowInvalidCertificates   = NO;
//        self.requestSerializer                         = [AFJSONRequestSerializer serializer];
        ((AFJSONResponseSerializer *)self.responseSerializer).removesKeysWithNullValues = YES;
        self.requestSerializer.timeoutInterval         = 25;
    }
    return self;
}

- (void)post:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure {
//    self.canHandleMessage = YES;
    [self changeToken];
    [self POST:urlString parameters:[self renderParameters:body] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponseObject:responseObject task:task sucess:sucess failure:failure type:@"POST"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseErrorWithTask:task error:error failure:failure];
    }];
}

- (void)postNoHandleDisplayMessage:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure {
//    self.canHandleMessage = NO;
    [self changeToken];
    [self POST:urlString parameters:[self renderParameters:body] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponseObject:responseObject task:task sucess:sucess failure:failure type:@"POST"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseErrorWithTask:task error:error failure:failure];
    }];
}

-(void)otherPost:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure {
//    self.canHandleMessage = YES;
    NSString * getUrl = [NSString stringWithFormat:@"%@%@",kNewAPIHost,urlString];
    
    AFNetManager * manager = [[AFNetManager alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"text/plain",
                                                         @"text/html",
                                                         @"application/json",
                                                         @"text/json",
                                                         @"text/javascript", nil];
    manager.securityPolicy.allowInvalidCertificates   = NO;
    if ([AppManager manager].hxUserInfo.token.length!=0) {
        
        [manager.requestSerializer setValue:[AppManager manager].hxUserInfo.token forHTTPHeaderField:@"authorization"];
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval         = 25;
    [manager POST:getUrl parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponseObject:responseObject task:task sucess:sucess failure:failure type:@"POST"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseErrorWithTask:task error:error failure:failure];
    }];
}


- (void)get:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure {
//    self.canHandleMessage = YES;
    [self changeToken];
    [self GET:urlString parameters:[self renderParameters:body] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponseObject:responseObject task:task sucess:sucess failure:failure type:@"GET"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseErrorWithTask:task error:error failure:failure];
    }];
}

-(void)put:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure {
//    self.canHandleMessage = YES;
    [self changeToken];
    [self PUT:urlString parameters:[self renderParameters:body] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponseObject:responseObject task:task sucess:sucess failure:failure type:@"PUT"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseErrorWithTask:task error:error failure:failure];
    }];
}
-(void)delete:(NSString *)urlString parameters:(id)body sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure {
//    self.canHandleMessage = YES;
    [self changeToken];
    [self DELETE:urlString parameters:[self renderParameters:body] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponseObject:responseObject task:task sucess:sucess failure:failure type:@"PUT"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseErrorWithTask:task error:error failure:failure];
    }];
}
- (void)changeToken {
    if ([AppManager manager].hxUserInfo.token.length!=0) {
        [self.requestSerializer setValue:[AppManager manager].hxUserInfo.token forHTTPHeaderField:@"authorization"];
    }
}

- (void)parseErrorWithTask:(NSURLSessionDataTask *)task error:(NSError *)error failure:(failureResultBlock)failure{
    if (error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 401) {
            [KeyWindow displayMessage:@"登录失效，请重新登录"];
            [[AppManager manager] signOutProgressHandler:nil userInfo:nil];
        }
        failure(error);
    }
}

- (void)parseResponseObject:(id)responseObject task:(NSURLSessionDataTask *)task sucess:(sucessResultBlock)sucess failure:(failureResultBlock)failure type:(NSString *)type{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//        NSLog(@"respones = %@, url=%@",responseObject,task.response.URL.absoluteString);
        
        NSString *status = responseObject[@"status"];
        NSString *message = responseObject[@"message"];
        
        ResponseNewModel *responseNewModel = [[ResponseNewModel alloc] init];
        responseNewModel.status = status.length!=0?status:@"";
        responseNewModel.message = message.length!=0?message:@"";
        responseNewModel.body = responseObject;
        if (sucess) {
            sucess(responseNewModel);
        }
        
//        if (self.canHandleMessage) {
//            if ([status isEqualToString:@"9999"]) {
//                [KeyWindow displayMessage:@"网络繁忙，请稍后重试"];
//            } else if(![status isEqualToString:@"0000"] && message.length != 0 && [type isEqualToString:@"POST"]) {
//                [KeyWindow displayMessage:message];
//            }
//        }
        
    }else {
        if (responseObject) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            
            if (dic) {
                NSString *status = dic[@"status"];
                NSString *message = dic[@"message"];
                
//                if (self.canHandleMessage) {
//                    if ([status isEqualToString:@"9999"]) {
//                        [KeyWindow displayMessage:@"网络繁忙，请稍后重试"];
//                    } else if(![status isEqualToString:@"0000"] && message.length != 0 && [type isEqualToString:@"POST"]) {
//                        [KeyWindow displayMessage:message];
//                    }
//                }
                
                ResponseNewModel *responseNewModel = [[ResponseNewModel alloc] init];
                responseNewModel.status = status.length!=0?status:@"";
                responseNewModel.message = message.length!=0?message:@"";
                responseNewModel.body = dic;
                if (sucess) {
                    sucess(responseNewModel);
                }
            }
        }
    }
    
}

- (NSDictionary *)renderParameters:(id)body {
    if (![body isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    if ([body count]==0) {
        return nil;
    }
    NSDictionary *dic = body;
    NSArray *allkeys =  [dic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    __block NSString *sign = @"";
    [allkeys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sign = [sign stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",obj,[dic objectForKey:obj]]];
    }];
    sign = [sign substringToIndex:sign.length - 1];
    
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [newDic setObject:[MD5Encryption md5by32:sign] forKey:@"sign"];
    
//    NSLog(@"request = %@",newDic);
    
    return newDic;
}

@end
