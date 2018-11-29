//
//  HXBookInfoModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/24.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBookInfoModel : NSObject

@property (nonatomic, strong) NSString *id; // 预约表id
@property (nonatomic, strong) NSString *reservationNo; //预约编号
@property (nonatomic, strong) NSString *merId; //商户id
@property (nonatomic, strong) NSString *userId; //用户id
@property (nonatomic, strong) NSString *proId; //产品id
@property (nonatomic, strong) NSString *status; //预约单状态(10：预约中，11设客户经理，20:分配到商家，30:预约取消，40成功)
@property (nonatomic, strong) NSString *name; //预约人姓名
@property (nonatomic, strong) NSString *phone; //预约人电话
@property (nonatomic, strong) NSString *remarks; //预约人备注
@property (nonatomic, strong) NSString *isEnable; //是否启用
@property (nonatomic, strong) NSString *cellphone; //客户经理联系电话
@property (nonatomic, strong) NSString *saleName; //客户经理
@property (nonatomic, strong) NSString *merchantName; //商户名称
@property (nonatomic, strong) NSString *productName; //项目名称
@property (nonatomic, strong) NSString *companyAddress; //项目地址
@property (nonatomic, strong) NSString *icon; //项目头像
@property (nonatomic, strong) NSString *createdTime; //预约单创建时间
@property (nonatomic, strong) NSString *upTime; //更新时间（预约表完成时间）

@end
