//
//  StoreListModel.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/29.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreListModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *distanceStr;

+ (id)initWithDictionary:(NSDictionary *)dict;

@end
