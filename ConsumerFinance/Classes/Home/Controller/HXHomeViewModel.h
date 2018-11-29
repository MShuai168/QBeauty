//
//  HXHomeViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/2.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "CurrentLocation.h"
#import "HXCreditLimitModel.h"
#import "LetterListModel.h"
@interface HXHomeViewModel : HXBaseViewModel

@property (nonatomic, assign) BOOL isHiddenActivateView; // 是否隐藏激活页面
@property (nonatomic, assign) BOOL canActivate; // 是否可以激活
@property (nonatomic, assign) BOOL isCheckIn; // 是否签到
@property (nonatomic, strong) AddressModelInfo *addressModelInfo; // 定位信息
@property (nonatomic, strong) NSString *locationCity;

@property (nonatomic,strong) NSMutableArray * bannarArr;
@property (nonatomic,assign)BOOL scoreBool; //是否打开过积分
@property (nonatomic,strong)NSString * score; //新人礼盒打开的积分

@property (nonatomic,strong)HXCreditLimitModel * creditModel; //信用分
@property (nonatomic, strong) LetterListModel * letterModel;

@property (nonatomic,strong)NSMutableArray * recomendArr;//推荐商品
@property (nonatomic,strong) NSMutableArray * enjoyArr;
@property (nonatomic,strong)NSString * adUrlStr;//广告链接

/**
 是否需要显示激活页面，并且是否可以激活
 */
- (void)needShowActivateView;

/**
 获取首页广告

 @param returnBlock 回调
 */
-(void)archiveAd:(ReturnValueBlock)returnBlock;

/**
 获取推荐商家

 @param returnBlock 回调
 */
-(void)archiveRecommend:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail;
/**
 获取特惠项目
 
 @param returnBlock 回调
 */
-(void)archiveProject:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail;

/**
 获取本地商户信息

 @param companyArr 商户数组
 */
-(void)archiveLoaclCompany:(NSMutableArray *)companyArr dispatch:(dispatch_queue_t)dispatch;

/**
 获取本地项目信息

 @param projectArr 项目数组
 */
-(void)archiveLoaclProjectArr:(NSMutableArray *)projectArr dispatch:(dispatch_queue_t)dispatch;

/**
 获取是否获取新人礼包

 @param returnBlock 回调
 */
-(void)archiveGetPacksBoolWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock;

/**
 打开新人礼盒

 @param returnBlock 回调
 @param failBlock 错误回调
 */
-(void)openScoreWithWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock;

/**
 修改会员等级
 */
-(void)changeMemBer;

/**
 获取推荐商品

 @param returnBlock 回调
 @param failBlock 回调
 */
-(void)archivewRecommendProduceWithSuccessBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 获取猜你喜欢数据

 @param returnBlock 回调
 */
-(void)archiveRecently:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock ;

-(void)whetherSign;

@end
