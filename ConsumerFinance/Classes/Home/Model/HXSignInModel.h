//
//  HXSignInModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXSignInRuleModel;
@interface HXSignInModel : NSObject

@property (nonatomic, strong) NSString * signInDay;
@property (nonatomic, strong) NSArray<HXSignInRuleModel *> *signRule;

@end

@interface HXSignInRuleModel : NSObject

@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString * signInDay;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *gmtCreate;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString * id;

@end


