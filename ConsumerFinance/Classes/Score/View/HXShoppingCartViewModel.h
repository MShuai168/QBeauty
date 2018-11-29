//
//  HXShoppingCartViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/14.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXShopCarModel.h"
#import "HXShopAddressModel.h"
@interface HXShoppingCartViewModel : HXBaseViewModel
@property (nonatomic,strong)NSMutableArray * shopCartNumberArr;//购物车数量
@property (nonatomic,strong)NSMutableArray * stopShopArr;//下架商品
@property (nonatomic,strong)NSMutableArray * recomendArr;//推荐商品
@property (nonatomic,assign)BOOL selectAllBool;
@property (nonatomic,assign)NSInteger page;//标记翻页
@property (nonatomic,strong)NSString * carriage;//运费
@property (nonatomic,assign)double integration;//积分
@property (nonatomic,strong)NSString * money;
@property (nonatomic,strong)HXShopAddressModel * addressModel;
@property (nonatomic,assign)BOOL queryBool;//查询支付结果  YES查询
@property (nonatomic,strong)NSString * orderId; //下订单后记录的ID
@property (nonatomic,strong)NSString * orderNo;//下订单后的NO

/**
 获取购物车列表

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)archiveShopCarInformationWithSuccessBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 获取推荐商品

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)archivewRecommendProduceWithSuccessBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 修改产品数量

 @param addBool 添加YES 删减 NO
 @param model 数据集
 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)changeShopCarNumberWithAddBool:(BOOL)addBool model:(HXShopCarModel *)model returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
/**
 修改产品数量
 
 @param addBool 添加YES 删减 NO
 @param model 数据集
 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)addShopCarNumberWithModel:(HXShopCarModel *)model returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 更新购物车数量

 @param model 当前变动的model
 @param number 数量
 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)updateShopCarNumberWithModel:(HXShopCarModel *)model number:(NSInteger)number returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
/**
 删除购物车

 @param model 单个产品数据
 @param returnBlock 回调
 */
-(void)removeShopCartInformationWithModel:(HXShopCarModel *)model returnBlock:(ReturnValueBlock)returnBlock;

/**
 下订单

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)placeOrderWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 查询支付结果

 @param returnBlock 回调
 @param failBlock 失败回调
 */
-(void)querypaymentWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
@end
