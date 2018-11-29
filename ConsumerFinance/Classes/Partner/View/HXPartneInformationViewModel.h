//
//  HXPartneInformationViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXPartneInformationModel.h"
@interface HXPartneInformationViewModel : HXBaseViewModel
@property (nonatomic,strong)NSString * inviterCodeStr;//推荐码
@property (nonatomic,strong)NSString * nameStr; //名字
@property (nonatomic,strong)NSString * gradeNameStr;//等级名称
@property (nonatomic,strong)HXPartneInformationModel * model;

/**
 获取个人信息

 @param block 回调
 @param failBlock 错误回调
 */
-(void)archiceInformationWithReturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock;//获取个人信息
@end
