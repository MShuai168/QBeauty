//
//  SchoolInfoModel.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/8.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolInfoModel : NSObject
/*
 {
 admissionAt = "2009-08-08";
 cityId = 370600;
 concurrentPost = 1;
 concurrentPostEarnings = "2000\U4ee5\U4e0a";
 createdAt = "2016-08-08";
 discipline = "\U8ba1\U7b97\U673a\U79d1\U5b66";
 dormAddress = "\U70df\U53f0\U5927\U5b66\U7537\U751f\U5bbf\U820d";
 educationalBackground = 1;
 id = 8;
 livingExpenses = "500-1000";
 provinceId = 370000;
 schoolName = "\U70df\U53f0\U5927\U5b66";
 updatedAt = "2016-08-08";
 userUuid = d7bc01b26f1f4cb1b02e18c43e782b23;
 }
 */
@property (nonatomic, strong) NSString *admissionAt;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, assign) NSString *concurrentPost;
@property (nonatomic, strong) NSString *concurrentPostEarnings;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *discipline;
@property (nonatomic, strong) NSString *dormAddress;
@property (nonatomic, strong) NSString *educationalBackground;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *livingExpenses;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *userId;
@end
