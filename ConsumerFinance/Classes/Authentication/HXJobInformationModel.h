//
//  HXJobInformationModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXJobInformationModel : NSObject
@property (nonatomic,strong)NSString * provinceId;
@property (nonatomic,strong)NSString * cityId;
@property (nonatomic,strong)NSString * name;//单位名称
@property (nonatomic,strong)NSString * address;//地址
@property (nonatomic,strong)NSString * telephone;//电话号码
@property (nonatomic,strong)NSString * type;//种类
@property (nonatomic,strong)NSString * monthlySalary;//月收入
@property (nonatomic,strong)NSString * realNamel;//真实姓名
@property (nonatomic,strong)NSString * entryTime;//入职时间
@end
