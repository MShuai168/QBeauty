//
//  HXRecordViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/25.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXRecordModel.h"

@interface HXRecordViewModel : HXBaseViewModel
@property (nonatomic,strong)NSMutableArray * allDataArr;
@property (nonatomic,strong)NSMutableArray * dfKDataArr;
@property (nonatomic,strong)NSMutableArray * dshDataArr;
@property (nonatomic,strong)NSMutableArray * haveSuccessDataArr;
@property (nonatomic,strong)NSMutableArray *  haveCancelDataArr;
@property (nonatomic,strong)NSString * type;
@property (nonatomic,strong)HXStateView * comStateView;
@property (nonatomic,strong)HXStateView * dfkStateView;
@property (nonatomic,strong)HXStateView * dshStateView;
@property (nonatomic,strong)HXStateView * havSuccessStateView;
@property (nonatomic,strong)HXStateView * cancelStateView;

@property(nonatomic,assign)NSInteger allPage;
@property (nonatomic,assign)NSInteger dfkPage;
@property (nonatomic,assign)NSInteger dshPage;
@property (nonatomic,assign)NSInteger suceessPage;
@property (nonatomic,assign)NSInteger canPage;
@property (nonatomic,assign)NSInteger selectIndex; //跳转到对应的界面

@property (nonatomic,assign)BOOL openHdBool;
@property (nonatomic,assign)BOOL queryBool;//查询支付结果  YES查询
@property (nonatomic,strong)HXRecordModel * model;
-(void)changeRecordStateWithOrderId:(NSString *)orderId returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
-(void)showItemView:(UIView *)view  type:(NSInteger)type kindType:(NSString *)kindType;
-(void)archiveRecodDataType:(NSString *)type returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
-(void)querypaymentWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
-(void)cancelRecordStateWithOrderId:(NSString *)orderId returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 查询商品是否下架

 @param model model
 */
-(void)changeShopClear:(HXRecordModel *)model returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
@end
