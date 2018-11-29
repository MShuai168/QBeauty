//
//  HXTenantsModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/3.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXTenantsModel : NSObject
@property (nonatomic,strong)NSString * id; //id
@property (nonatomic,strong)NSString * name; //商户名
@property (nonatomic,strong)NSString * typeTwoId; //该商户的二级分类id
@property (nonatomic,strong)NSString * companyAddress; //公司地址
@property (nonatomic,strong)NSString * starRating; //星级
@property (nonatomic,strong)NSString * icon; //头像
@property (nonatomic,strong)NSString * longitude; //经度
@property (nonatomic,strong)NSString * latitude; //维度
@property (nonatomic,strong)NSString * caseNum; //案例数
@property (nonatomic,strong)NSString * reservationNum; //预约数
@property (nonatomic,strong)NSString * introduction; //商家介绍
//商户顶部高度
@property (nonatomic,assign)float titleHeight;
//简介高度
@property (nonatomic,assign)float  cellHeight;
@property (nonatomic,assign)float introduceHeight;
@end
