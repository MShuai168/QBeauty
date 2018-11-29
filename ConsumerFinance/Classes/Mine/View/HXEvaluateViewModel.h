//
//  HXEvaluateViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXEvaluateViewModel : HXBaseViewModel
@property (nonatomic,strong)NSMutableArray * evaluationArr;//待评价数据
@property (nonatomic,strong)NSMutableArray * haveEvaluationArr;//已评价数据
@property (nonatomic,assign)NSInteger evaluaIndex;
@property (nonatomic,assign)NSInteger haveEvaluaIndex;

@property (nonatomic,strong)HXStateView * projectStateView;
@property (nonatomic,strong)HXStateView * itemStateView;

@property (nonatomic,assign)NSInteger contNumber;
/**
获取待评价列表

 @param returnBlock 回调
 @param fail 失败回调
 */
-(void)archivePendingEvaluationWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail;

/**
 获取已评价列表

 @param returnBlock 回调
 @param fail 失败回调
 */
-(void)archiveHaveEvaluationWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail;
-(void)showProjectView:(UIView *)view type:(NSInteger)type;
-(void)showItemView:(UIView *)view type:(NSInteger)type;
@end
