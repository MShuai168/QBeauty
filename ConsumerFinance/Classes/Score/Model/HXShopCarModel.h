//
//  HXShopCarModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXShopCarModel : NSObject
@property (nonatomic,assign)BOOL selectedBool ;//是否选择
@property (nonatomic,strong)NSString * proNum;//商品数量
@property (nonatomic,strong)NSString * specOne;//规格一
@property (nonatomic,strong)NSString * shippingExpense;//快递费用
@property (nonatomic,strong)NSString * score;//商品SKU需要的积分
@property (nonatomic,strong)NSString * markPrice;//市场价格
@property (nonatomic,strong)NSString * specThree;//规格三
@property (nonatomic,strong)NSString * price;//价格
@property (nonatomic,strong)NSString * imgUrl;//商品图片地址
@property (nonatomic,strong)NSString * proName;//商品名称
@property (nonatomic,strong)NSString * specTwo;//规格二
@property (nonatomic,strong)NSString * id;//购物车商品信息主键id
@property (nonatomic,strong)NSString * stock;//商品sku库存
@property (nonatomic,strong)NSString * proOnshelfStatus;//上架状态(1上架 2下架 3 售罄）
@property (nonatomic,strong)NSString * skuId;//本条商品的skuId

@end
