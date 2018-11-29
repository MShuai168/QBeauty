//
//  BeautyClinicModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/13.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, HeightStyle) {     //cell行高
    HeightNormal,                            //正常高度
    HeightLastest,                    //名称或地址扩展
    HeightBigest,                     //名称 地址都扩展
};
@interface BeautyClinicModel : NSObject
@property (nonatomic,strong) NSString * title; //标题
@property (nonatomic,strong) NSString * address; //地址
@property (nonatomic,assign) NSUInteger cellHeight; //cell行高样式


/**
 * 商户model
 */
@property (nonatomic,strong)NSString * cityId;//城市ID
@property (nonatomic,strong)NSString * count;//总数据数
@property (nonatomic,strong)NSString * keyWord;//关键词
@property (nonatomic,strong)NSString * page;//当前页数
@property (nonatomic,strong)NSString * pageSize;//单页数量
@property (nonatomic,strong)NSString * sortFlg;//总量
@property (nonatomic,strong)NSArray * dtoList;//列表数组


/**
 判断行间距
 
 @param model
 */
+(void)dealTitleHeightStateWithModl:(BeautyClinicModel *)model;
@end
