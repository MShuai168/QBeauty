//
//  HXProductDetailViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXCommentModel.h"
#import "HXMerDtoModel.h"
#import "HXPreDtoModel.h"
#import "HXImgListModel.h"
@interface HXProductDetailViewModel : HXBaseViewModel
@property (nonatomic,strong)HXCommentModel * hxcModel;

@property (nonatomic,strong) HXPreDtoModel * preDtoModel;
@property (nonatomic,strong) HXMerDtoModel * merDtoModel;
@property (nonatomic,strong) NSMutableArray * bannarArr;
@property (nonatomic,strong)HXStateView * statesView;
@property (nonatomic,assign) NSInteger commentNumber;//评论数
@property (nonatomic,strong)NSMutableArray * commentArr;//评论数组

@property (nonatomic,strong) NSString * proId; //项目ID
//本地数据
-(void)archiveDeatilWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock;

/**
 获取评论
 
 @param returnBlock 评论
 */
-(void)archiveCommentWithReturnBlock:(ReturnValueBlock)returnBlock;

-(void)paddingData;
@end
