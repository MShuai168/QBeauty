//
//  HXMyPointsViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXMyPointsViewModel : HXBaseViewModel
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSString * score;
@property (nonatomic,assign)NSInteger  archiveType;
@property (nonatomic,assign)NSInteger pageIndex;
/**
 获取积分列表

 @param returnBlock 回调
 */
-(void)archiveMyPointsWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail;
@end
