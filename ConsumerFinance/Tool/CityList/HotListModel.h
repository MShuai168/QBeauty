//
//  HotListModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/26.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "Tool_FMDBModel.h"

@interface HotListModel : Tool_FMDBModel
@property (nonatomic,strong)NSString * cityName;
@property (nonatomic,strong)NSString * distList;
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * jianpin;
@property (nonatomic,strong)NSString * quanpin;

+(NSMutableArray *)changeHotListData:(NSArray *)dataArr;
@end
