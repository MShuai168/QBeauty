//
//  HXPersonDetailModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXPersonDetailModel : NSObject
@property(nonatomic,strong)NSString * authTime; //认证时间
@property(nonatomic,strong)NSString * cityId; //城市id
@property(nonatomic,strong)NSString * commonAddress ;//常住地址
@property(nonatomic,strong)NSString * commonCellphone;
@property(nonatomic,strong)NSString * createdAt ;
@property(nonatomic,strong)NSString * education;//学历
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * identityTag ;//身份标识
@property(nonatomic,strong)NSString * jdAccount;
@property(nonatomic,strong)NSString * jdPassword;
@property(nonatomic,strong)NSString * maritalStatus; //婚姻状况"已婚":10);"未婚":20);"离异":21);"丧偶":25);再婚":30);
@property(nonatomic,strong)NSString * message;
@property(nonatomic,strong)NSString * provinceId;//省id
@property(nonatomic,strong)NSString * pullTime;
@property(nonatomic,strong)NSString * qqAccount;
@property(nonatomic,strong)NSString * realName ;//真实姓名
@property(nonatomic,strong)NSString * updatedAt ;
@property(nonatomic,strong)NSString * weChatAccount;

@end
