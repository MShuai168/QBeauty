//
//  HXBillDetailsModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBillDetailsModel : NSObject
@property (nonatomic,strong)NSString * canChoose;//能还款
@property (nonatomic,strong)NSString * isChooosed;//是否已打灰色小钩 1已打 0没打
@property (nonatomic,strong)NSString * name;//名称 1/4期
@property (nonatomic,strong)NSString * refundDate;//还款日期
@property (nonatomic,strong)NSString * detail;//右下红色小字，有什么显示是
@property (nonatomic,strong)NSString * status;
@property (nonatomic,strong)NSString * statusName;//状态名称
@property (nonatomic,strong)NSString * money;//金色金额
@property (nonatomic,strong)NSString * interest;//罚息
@property (nonatomic,strong)NSString * currentPeriods;//期数
@property (nonatomic,strong)NSString * payamt;//应还金额，拿这个金额字段去请求立即还款，计算上方的卡里面的值
@property (nonatomic,assign)BOOL haveSelect; //NO未选择 YES已选择
@property (nonatomic,assign)BOOL firstSelect; //第一个可以选择的一期
@property (nonatomic,strong)NSString * isDefault;
@end
