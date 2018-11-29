//
//  HXCitySelectedViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/20.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentLocation.h"

@interface HXCitySelectedViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray *indexArray; // 字母索引
@property (nonatomic, strong, readonly) NSArray *hotCitys; // 热门城市
@property (nonatomic, strong, readonly) NSArray *cities; // 城市
@property (nonatomic, strong, readonly) NSArray *searchCities; // 搜索出来的城市列表
@property (nonatomic, assign) BOOL hiddenTableView;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong)UICollectionView * hotCityCollectionView;
@property (nonatomic, strong) NSString *gpsCity; // 当前定位的城市
@property (nonatomic, strong) AddressModelInfo *addressModelInfo; // 定位信息

-(void)updateCityListReturnBlock:(void(^)())block fail:(FailureBlock)failBlock;

- (void)fillSearchCities:(NSString *)key;

@end
