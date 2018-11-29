//
//  UploadModel.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/28.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HeadModel : NSObject
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSString *flowID;
@property (nonatomic, strong) NSString *msgType;
@property (nonatomic, strong) NSString *operatorID;
@property (nonatomic, strong) NSString *responseCode;
@property (nonatomic, strong) NSString *responseMsg;
@property (nonatomic, strong) NSString *responseTime;
@property (nonatomic, strong) NSString *session;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *tradeCode;
@property (nonatomic, strong) NSString *tradeStatus;
@property (nonatomic, strong) NSString *tradeTime;
@property (nonatomic, strong) NSString *tradeType;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *pageId;

@end


@interface ErrorModel : NSObject
@property (nonatomic, strong) NSString *errorMsg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) HeadModel *head;

@end

@interface ResponseModel : NSObject
@property (nonatomic, strong) HeadModel *head;
@property (nonatomic, strong) NSDictionary *body;
@end

@interface ResponseNewModel : NSObject
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDictionary *body;
@end



