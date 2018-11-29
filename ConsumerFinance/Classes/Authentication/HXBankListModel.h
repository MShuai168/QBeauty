//
//  HXBankListModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBankListModel : NSObject
@property (nonatomic,strong)NSString * id;//银行卡id
@property (nonatomic,strong)NSString * bankName;//银行卡名称
@property (nonatomic,strong)NSString * bankIcon;
@property (nonatomic,strong)NSString * cardNo;//银行卡号
@property (nonatomic,strong)NSString * cardType;//银行卡类型
@property (nonatomic,strong)NSString * cellphone;//手机号
@property (nonatomic,strong)NSString * bankColour;
@property (nonatomic,strong)NSString * isdefault; // 1绿通默认卡 0一般卡
@end
