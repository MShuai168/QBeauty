//
//  HXAllEvaluationViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXEvaluateModel.h"
#import "HXCommentModel.h"
@interface HXAllEvaluationViewModel : HXBaseViewModel
@property (nonatomic,assign)BOOL detailBool;
@property (nonatomic,strong)HXEvaluateModel *model;
@property (nonatomic,strong)NSMutableArray * commentArr;
@property (nonatomic,strong)NSMutableArray * allCommentArr;//全部评论数组
@property (nonatomic,assign)NSInteger commentIndex;
@property (nonatomic,assign) NSInteger commentNumber;//评论数
@property (nonatomic,strong)HXCommentModel * hxcModel;
@property (nonatomic,strong)NSString * merId;

/**
 获取评论详情
 
 @param returnBlock 回调
 */
-(void)archiveEvaluationDetailWithReturnBlock:(ReturnValueBlock)returnBlock;

/**
 获取评论
 
 @param returnBlock 回调
 */
-(void)archiveCommentWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock;
@end
