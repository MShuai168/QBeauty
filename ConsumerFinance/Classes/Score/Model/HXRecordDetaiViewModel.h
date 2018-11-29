//
//  HXRecordDetaiViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/21.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXRecordModel.h"
#import "HXRecordDetailModel.h"
@interface HXRecordDetaiViewModel : HXBaseViewModel
@property (nonatomic,assign)ShopStatuesKind states;
@property (nonatomic,assign)BOOL undercarriage;//判断是否下架
@property (nonatomic,strong)NSString * headTitle;//标题
@property (nonatomic,strong)NSMutableArray * inforArr;
@property (nonatomic,strong)NSMutableArray * shopArr;
@property (nonatomic,strong)HXRecordModel * model;
@property (nonatomic,strong)HXRecordDetailModel * detailModel;
@property (nonatomic,strong)NSMutableArray * shopInforArr;
@property (nonatomic,strong)NSMutableArray * shopHeightArr;
@property (nonatomic,assign)BOOL queryBool;//查询支付结果  YES查询
-(void)archiveOrderInformation;
-(void)changeRecordStateWithType:(NSString *)type returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
-(void)archiveRecordStatesWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
-(void)querypaymentWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
-(void)changeShopClearWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
@end
