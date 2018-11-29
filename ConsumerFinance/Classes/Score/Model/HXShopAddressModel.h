//
//  HXShopAddressModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/18.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXShopAddressModel : NSObject
@property (nonatomic,strong)NSString * areaCode;
@property (nonatomic,strong)NSString * address;
@property (nonatomic,strong)NSString * provinceCode;
@property (nonatomic,strong)NSString * cityCode;
@property (nonatomic,strong)NSString * phone;
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * isDefault;
@property (nonatomic,strong)NSString * receiver;
@property (nonatomic,strong)NSString * provinceName;
@property (nonatomic,strong)NSString * areaName;
@property (nonatomic,strong)NSString * cityName;
@end
