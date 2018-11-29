//
//  HXDataAuthenModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXDataAuthenModel : NSObject
@property (nonatomic,strong)NSString * cellphone;//电话号码
@property (nonatomic,strong)NSString * createdAt;
@property (nonatomic,strong)NSString * icon ;
@property (nonatomic,strong)NSString * id ;
@property (nonatomic,strong)NSString * idCard;//身份证号码
@property (nonatomic,strong)NSString * identity_tag; //1：企业主，2：上班族，3：学生、4：自由职业者
@property (nonatomic,strong)NSString * isAuth ;//是否实名认证
@property (nonatomic,strong)NSString * isBankAuth ;//是否银行卡认证
@property (nonatomic,strong)NSString * isBlack;
@property (nonatomic,strong)NSString * isCreditAuth;//是否人行征信认证
@property (nonatomic,strong)NSString * isHomeAuth;//是否进行家庭认证
@property (nonatomic,strong)NSString * isMailAuth;//是否邮箱认证
@property (nonatomic,strong)NSString * isOperatorAuth;//是否运营商认证
@property (nonatomic,strong)NSString * isPersonalAuth;//是否个人信息认证
@property (nonatomic,strong)NSString * isSchoolAuth;//是否学籍认证
@property (nonatomic,strong)NSString *isWorkAuth;//是否工作认证
@property (nonatomic,strong)NSString *issuingAuthority;
@property (nonatomic,strong)NSString *macCode;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *realName;
@property (nonatomic,strong)NSString *recommendPhone;
@property (nonatomic,strong)NSString *updatedAt;
@property (nonatomic,strong)NSString *validPeriod;
@property (nonatomic,strong)NSString * isOtherAuth;

@end
