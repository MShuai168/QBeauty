//
//  ScreenView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ScreenView : UIView
@property (nonatomic,assign)BOOL travel; //判断是否为旅游

@property (nonatomic,strong)NSString * projectLeftid;//标记项目左侧列表id
@property (nonatomic,strong)NSString * projectRightid;//标记项目右侧列表id
@property (nonatomic,strong)NSString * areaId; //地区id
@property (nonatomic,strong)NSString * distId;//商圈id
@property (nonatomic,strong)NSString * sortFlg;//排序id
@property (nonatomic,strong)NSString * distance; //米
/**
 初始化筛选视图
 
 @param screenNumber 筛选按钮个数
 @param index 项目/医院
 @param content 筛选按钮回调
 @return
 */
-(id)initWithScreenNumber:(NSInteger)screenNumber segSelectIndex:(NSInteger)index selectContent:(void(^)())content;


/**
 地区筛选数据
 
 @param dataArr 数组
 */
-(void)areaData:(NSMutableArray *)dataArr;
/**
 排序数据
 
 @param dataArr 数组
 */
-(void)sortListData:(NSMutableArray *)dataArr;


/**
 项目筛选数据

 @param dataArr 数组
 */
-(void)projectData:(NSMutableArray *)dataArr;
/**
 获取旅游详情

 @param dataArr 数组
 */
-(void)travelData:(NSMutableArray *)dataArr;
@end
