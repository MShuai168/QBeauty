//
//  VerifyCodeModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2018/1/10.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyCodeModel : NSObject

@property (nonatomic, assign) BOOL flag;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *token;

@end
