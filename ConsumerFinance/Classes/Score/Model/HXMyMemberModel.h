//
//  HXMyMemberModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/20.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXMyMemberModel : NSObject
@property(nonatomic,strong)NSString *  difference;//差分
@property(nonatomic,strong)NSString * endValue;//升级总分
@property(nonatomic,strong)NSString * gradeId;//当前等级id
@property(nonatomic,strong)NSString * gradeName;//当前等级
@property(nonatomic,strong)NSString * growthValue;//成长值
@property(nonatomic,strong)NSString * nextGradeName;//下级名字
@property(nonatomic,strong)NSString * startValue;
@end
