//
//  HXMyViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXCreditLimitModel.h"
#import "HXMyNumberModel.h"
@interface HXMyViewModel : HXBaseViewModel
@property (nonatomic,strong)HXCreditLimitModel * creditModel; //信用分
@property (nonatomic, assign) BOOL isHiddenActivateView; // 是否隐藏激活页面
@property (nonatomic,strong)HXMyNumberModel * numberModel;
/**
 信用分激活
 
 @param returnBlock 回调
 */
-(void)creditActivationWithReturnBlock:(ReturnValueBlock)returnBlock;

/**
 信用卡激活查询
 
 @param returnBlock 回调
 */
-(void)archiveCreditActivationInformationWithReturnBlock:(ReturnValueBlock)returnBlock;

@end
