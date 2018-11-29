//
//  HXMallViewControllerViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/17.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LetterListModel.h"
#import "DtoListModel.h"
#import "CurrentLocation.h"
@interface HXMallViewControllerViewModel : NSObject

@property (nonatomic, strong) NSString *locationCity;// 当前城市
@property (nonatomic, strong) AddressModelInfo *addressModelInfo; // 定位信息
@property (nonatomic, strong) NSMutableArray * functionData; // 例如：医美，婚纱摄影，婚宴，月子，蜜月
@property (nonatomic,strong) NSMutableArray * enjoyArr;
@property (nonatomic, strong, readonly) NSArray *banners;
@property (nonatomic, strong) LetterListModel * letterModel;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSMutableArray * bannarArr;

/**
 *  获取标题栏
 */
-(void)achieveAssortment:(void(^)())block;

/**
 获取猜你喜欢

 @param returnBlock 回调
 */
-(void)archiveRecently:(ReturnValueBlock)returnBlock;

/**
 获取首页广告
 
 @param returnBlock 回调
 */
-(void)archiveAd:(ReturnValueBlock)returnBlock;

/**
 查询城市ID
 
 @param cityName 城市名称
 */
-(void)updatLetterListModel:(NSString *)cityName;

-(void)archiveFunctionData;
@end
