//
//  VoListModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/26.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "Tool_FMDBModel.h"
#import "LetterListModel.h"

@interface VoListModel : Tool_FMDBModel
@property (nonatomic,strong)NSString * firstLetter;
@property (nonatomic,strong)NSArray * letterList;


/**
 重组城市列表城市数据

 @param dataArr 数据库查询数据
 @return 重组完数据
 */
+(NSMutableArray *)changeHotList;

+(NSMutableArray *)changeHotList:(NSArray *)list;


/**
 筛选数据

 @param dataArr 数据库查询数据
 @return 重组完数据
 */
+(NSMutableArray *)changeScreenList;

+(NSMutableArray *)changeScreenList:(NSArray *)list;


/**
 查询城市名称属于的model

 @param cityName 城市名
 @return 返回对应的Model
 */
+(LetterListModel *)inquiryLetterModelWithName:(NSString *)cityName;
@end
