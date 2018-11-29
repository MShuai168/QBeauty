//
//  HXPartnerRecordViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXPartnerRecordViewModel : HXBaseViewModel
@property (nonatomic,assign)NSInteger buyRecordIndex;
@property (nonatomic,assign)NSInteger incomeIndex;
@property (nonatomic,assign)NSInteger withdrawIndex;
@property (nonatomic,strong)HXStateView * buyStateView;
@property (nonatomic,strong)HXStateView * incomeStateView;
@property (nonatomic,strong)HXStateView * withdrawStateView;
@property (nonatomic,strong)NSMutableArray * buyRecordArr;//购买数组
@property (nonatomic,strong)NSMutableArray * incomeArr;//收益数组
@property (nonatomic,strong)NSMutableArray * withdrawArr;//提现数组
@property (nonatomic,assign)BOOL openHdBool;
-(void)archiveRecordInformationWithType:(NSString *)type returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock;

-(void)showItemView:(UIView *)view  type:(NSInteger)type kindType:(NSString *)kindType;
@end
