//
//  HXCertificationModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXCertificationModel : NSObject
@property (nonatomic,strong)NSString * idCard; //身份证号
@property (nonatomic,strong)NSString * realName; //真实姓名
@property (nonatomic,strong)NSString * validPeriod;//有效期
@property (nonatomic,strong)NSString * issuingAuthority;//发证机构
@property (nonatomic,strong)NSString * isAuth;
@property (nonatomic,strong)NSArray * cardImg;
@end
