//
//  UserDataModel.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/21.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataModel : NSObject
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *session;
@end
