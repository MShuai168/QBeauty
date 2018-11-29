//
//  HXEvaluatDetailViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXEvaluateModel.h"
@interface HXEvaluatDetailViewModel : HXBaseViewModel
@property (nonatomic,strong)HXEvaluateModel * model;
-(void)submitDiscusInformationWithPhotoArr:(NSMutableArray *)photoArr totoal:(NSInteger)tototalNumber serverNum:(NSInteger)serverNum quailNum:(NSInteger)quailNum discussText:(NSString *)discussText returnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail;
@end
