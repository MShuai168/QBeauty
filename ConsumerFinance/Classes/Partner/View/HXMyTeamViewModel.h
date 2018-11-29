//
//  HXMyTeamViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXMyTeamViewModel : HXBaseViewModel
@property (nonatomic,strong)NSMutableArray * teamArr;
@property (nonatomic,assign)NSInteger pageIndex;
-(void)archiveInformationWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;
@end
