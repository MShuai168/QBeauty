//
//  HXConfirmReservationViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/24.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXPreDtoModel.h"
#import "LetterListModel.h"
@interface HXConfirmReservationViewModel : HXBaseViewModel
@property (nonatomic,strong)HXPreDtoModel * preModel; //商户详情页ID

@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSString * address;
@property (nonatomic,strong)NSString * imageUrl;


/**
 预约订单

 @param name 客户名称
 @param phone 手机号
 @param remark 备注
 @param returnBlock 回调
 */
-(void)submitCertificationWithName:(NSString *)name phone:(NSString *)phone remark:(NSString *)remark returnBlock:(ReturnValueBlock)returnBlock;
@end
