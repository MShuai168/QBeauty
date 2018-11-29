//
//  HXEllementModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXEllementModel : NSObject
@property (nonatomic,strong)NSString * admissionAt;
@property (nonatomic,strong)NSString * cityId;
@property (nonatomic,strong)NSString * concurrentPost;
@property (nonatomic,strong)NSString * concurrentPostEarnings; //兼职收入
@property (nonatomic,strong)NSString * createdAt;
@property (nonatomic,strong)NSString *discipline;//学习的专业
@property (nonatomic,strong)NSString *dormAddress;//学校地址
@property (nonatomic,strong)NSString *educationalBackground;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *livingExpenses; //月收入
@property (nonatomic,strong)NSString *provinceId;
@property (nonatomic,strong)NSString *schoolName;//学校名称
@property (nonatomic,strong)NSString *updatedAt;

@end
