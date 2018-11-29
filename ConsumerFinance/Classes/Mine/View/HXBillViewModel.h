//
//  HXBillViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXBillViewModel : HXBaseViewModel
@property (nonatomic,strong)NSMutableArray * billArr;
@property (nonatomic,strong)HXStateView * stateView;
-(void)archiveBillInformationWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail;
-(void)showItemView:(UIView *)view  type:(NSInteger)type;
@end
