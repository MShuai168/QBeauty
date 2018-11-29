//
//  HXBeautyClinicViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/26.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXMallModel.h"
#import "LetterListModel.h"
#import "ScreenView.h"
#import "CurrentLocation.h"
@interface HXBeautyClinicViewModel : HXBaseViewModel
@property (nonatomic,strong)HXMallModel * hxmallModel;
@property (nonatomic,strong)LetterListModel * letterModel;
@property (nonatomic,strong)NSMutableArray * projectArr; //项目数组
@property (nonatomic,strong)NSMutableArray * shopArr; //商户数组
@property (nonatomic,strong) ScreenView * screen ;//项目视图
@property (nonatomic,strong) ScreenView * dockScreen;//医院视图

@property (nonatomic,assign) NSInteger projectIndex;
@property (nonatomic,assign) NSInteger shopIndex;
@property (nonatomic,strong) AddressModelInfo * addressModel;

@property (nonatomic,strong)HXStateView * projectStateView;
@property (nonatomic,strong)HXStateView * itemStateView;

/**
  获取地区筛选数据

  @return 成功后的回调
  */
-(void)archiveAreaWithReturnValueBlock:(ReturnValueBlock)returnBlock;

/**
 获取项目分类 子分类

 @param returnBlock 回调数据
 */
-(void)archiveProjectWithReturnValueBlock:(ReturnValueBlock)returnBlock;
/**
 获取排序分类
 
 @param returnBlock 回调数据
 */
-(void)archiveSoreListWithReturnValueBlock:(ReturnValueBlock)returnBlock ;

/**
 项目数据加载

 @param block 回调
 */
-(void)archiveProjectDataWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

/**
 商户数据

 @param returnBlock 回调
 */
-(void)archiveTenantDataWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

-(void)showProjectView:(UIView *)view type:(NSInteger)type;
-(void)showItemView:(UIView *)view type:(NSInteger)type;
@end
