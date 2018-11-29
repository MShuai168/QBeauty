//
//  HXDetailsViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/31.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXTenantsModel.h"
#import "HXCommentModel.h"
@interface HXDetailsViewModel : HXBaseViewModel
@property (nonatomic,strong) HXTenantsModel * tenantModel; //商户详情
@property (nonatomic,strong) NSMutableArray * imgDocArr;
@property (nonatomic,strong) NSMutableArray * imgListArr;
@property (nonatomic,strong) NSMutableArray * dtoListArr; //推荐商户数组
@property (nonatomic,strong) HXCommentModel * hxcModel;
@property (nonatomic,strong) NSString * merId; //商户id
@property (nonatomic,assign) NSInteger recomNumber; //推荐商户
@property (nonatomic,assign) NSInteger commentNumber;//评论数
@property (nonatomic,strong)NSMutableArray * commentArr;//评论数组

@property (nonatomic,assign)BOOL shopAllBool;

@property (nonatomic,strong)HXStateView * statesView;
/**
 获取商户详情
 */
-(void)archiveDetailDataWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock;

/**
 获取推荐商户
 
 @param returnBlock 回调
 */
-(void)archiveRecommendShopReturnBlock:(ReturnValueBlock)returnBlock;

/**
 获取评论列表
 
 @param returnBlock 返回
 */
-(void)archiveCommentWithReturnBlock:(ReturnValueBlock)returnBlock;

-(void)paddingData;
@end
