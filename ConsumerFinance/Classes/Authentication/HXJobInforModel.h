//
//  HXJobInforModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/18.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"
@interface HXJobInforModel : NSObject
@property (nonatomic,strong)NSString * nature;//公司性质
@property (nonatomic,strong)NSString * address;//公司地址
@property (nonatomic,strong)NSString * unitAddress;//单位 城市
@property (nonatomic,strong)NSString * alimony;//生活费
@property (nonatomic,strong)NSString * revenue; //收入
@property (nonatomic,strong)NSString * unitStr; //就职单位
@property (nonatomic,strong)NSString * name;      //学校名称
@property (nonatomic,strong)NSString * unitcommenAddress; //就职单位详细地址
@property (nonatomic,strong)NSString * iphoneNumber;//单位电话
@property (nonatomic,strong)NSString * areaNumber;//单位电话
@property (nonatomic,strong)NSString * entryTime; //入职时间


//student
@property (nonatomic,strong)NSString * majorIn; //主修专业
@property (nonatomic,strong)NSString * switchOn;


@property (nonatomic,strong)AddressModel *provinceModel;
@property (nonatomic,strong)AddressModel *cityModel;
@end
