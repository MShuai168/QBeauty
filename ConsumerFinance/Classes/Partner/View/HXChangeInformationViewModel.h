//
//  HXChangeInformationViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXChangeInformationModel.h"
@interface HXChangeInformationViewModel : HXBaseViewModel
@property (nonatomic,strong)NSString * nameStr;
@property (nonatomic,strong)NSString * identyStr;
@property (nonatomic,strong)NSString * iphoneStr;
@property (nonatomic,strong)HXChangeInformationModel * model;

/**
 获取个人信息

 @param block 回调
 @param failBlock 错误回调
 */
-(void)archiveInformationWithReturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock;


/**
 提交个人信息修改

 @param block 回调
 @param failBlock 错误回调
 */
-(void)submitInformationWithReturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock;
@end
