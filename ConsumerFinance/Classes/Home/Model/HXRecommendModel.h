//
//  HXRecommendModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/2.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "Tool_FMDBModel.h"

@interface HXRecommendModel : Tool_FMDBModel
@property (nonatomic,strong) NSString * id;
@property (nonatomic,strong) NSString * name; //商户名称
@property (nonatomic,strong) NSString * starRating; //商户星级
@property (nonatomic,strong) NSString * icon; //商户头像
@property (nonatomic,strong) NSString * city_id;//城市id
@end
