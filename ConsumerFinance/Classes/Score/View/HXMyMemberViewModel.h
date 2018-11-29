//
//  HXMyMemberViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/20.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXMyMemberModel.h"

@interface HXMyMemberViewModel : HXBaseViewModel
@property (nonatomic,strong)HXMyMemberModel * model;
@property (nonatomic,strong)NSMutableArray * recomendArr;//推荐商品
@property (nonatomic,assign)NSInteger page;//标记翻页
-(void)archiveMemberWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail;
-(void)archivewRecommendProduceWithSuccessBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
@end
