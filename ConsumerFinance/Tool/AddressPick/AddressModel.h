//
//  AddressModel.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/25.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic, strong) NSString *areaCode;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSArray   *zones;

@end
