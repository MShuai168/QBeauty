//
//  HXPreDtoModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/3.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXPreDtoModel : NSObject
@property (nonatomic,strong) NSString * caseNum; //案例数
@property (nonatomic,strong) NSString * createTime; //创建时间
//depositRate = "10.0";
@property (nonatomic,strong) NSString * detail ;//商品详情
@property (nonatomic,strong) NSString * icon;
@property (nonatomic,strong) NSString * id ;//项目id
//intelligentSort = 0;
//isEnabled = 1;
@property (nonatomic,strong) NSString * merId;//商户id
//merSort = 1;
@property (nonatomic,strong) NSString * name;//项目名
@property (nonatomic,strong) NSString * notice;//预约须知
//price = "1200.00";
//reservationNum = 223;
//score = 0;
//scoreBase = 35;
@property (nonatomic,strong) NSString *  stagePeriod;//分期期数
@property (nonatomic,strong) NSString *  stagePrice ;//分期价格
//typeTwoId = A001;
@property (nonatomic,strong) NSString * updateTime;//更新时间
@property (nonatomic,assign) float titleHeight;

@end
