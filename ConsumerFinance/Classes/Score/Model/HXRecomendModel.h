//
//  HXRecomendModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/18.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXRecomendModel : NSObject
@property (nonatomic,strong)NSString * score;//积分
@property (nonatomic,strong)NSString * specOne;//规格-
@property (nonatomic,strong)NSString * specThree;//规格三
@property (nonatomic,strong)NSString * price;//价格
@property (nonatomic,strong)NSString * imgUrl;
@property (nonatomic,strong)NSString * markPrice;//市场价格
@property (nonatomic,strong)NSString * proName;//商品名称
@property (nonatomic,strong)NSString * specTwo;//规格二
@property (nonatomic,strong)NSString * stock;//库存
@property (nonatomic,strong)NSString * skuId;//商品skuId

@end
