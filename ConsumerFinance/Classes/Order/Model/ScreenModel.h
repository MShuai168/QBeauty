//
//  ScreenModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/28.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenModel : NSObject
/**
 * 筛选种类
 */
@property (nonatomic,strong)NSString * cityName ;
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * jianpin;
@property (nonatomic,strong)NSString * quanpin;
@property (nonatomic,strong)NSArray * distList;

@property (nonatomic,strong)NSString * name;//排序名称
@end
