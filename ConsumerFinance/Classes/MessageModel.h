//
//  messageModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/6/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *orderParam;
@property (nonatomic, strong) NSString *noticeType;
@property (nonatomic, strong) NSString *isRead;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *noticeDetail;
@property (nonatomic, strong) NSString *createdTime;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *readNumber;

@end
