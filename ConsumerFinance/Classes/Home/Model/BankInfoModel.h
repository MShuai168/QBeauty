//
//  BankInfoModel.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/10.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankInfoModel : NSObject
/*
 序号	字段名	中文名	必选	备注
 1.	responseCode（head）	返回代码	True	0000成功
 2.	responseMsg（head）	返回信息	True	返回结果描述
 3	userUuid	用户标识	True
 4	tailCardNo	银行卡号	True	只有后四位
 5	bankName	银行名称	True
 6	cellphone	预留手机号	True
 7	idCard	身份证号	True
 8	realName	真是姓名	true
 9	resultCode	绑卡结果	true	01标识成功，目前仅返回成功信息
 10	isContracted	是否签过合同	False	为空时标识没有签约，其余均可是为已签约
 11	message	绑卡结果描述	False	可能为空
 12	updatedAt	更新时间	true	2016-07-27 14:36:19
 13	createdAt	创建时间	True	2016-07-27 14:36:19
 */
@property (nonatomic, strong) NSString *tailCardNo;
@property (nonatomic, assign) BOOL      isContracted;//
@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *bankAddress;
@property (nonatomic, strong) NSString *cellphone;
@property (nonatomic, strong) NSString *idCard;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *resultCode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *bindType;//宝付银行卡区别
@property (nonatomic, strong) NSString *cardNo;//银行卡号







@end
