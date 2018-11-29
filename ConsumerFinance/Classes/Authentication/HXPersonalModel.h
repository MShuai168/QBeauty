//
//  HXPersonalModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/18.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"
@interface HXPersonalModel : NSObject
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * certificationStr;// 身份选择信息
@property (nonatomic,strong) NSString * educationStr;// 学历选择信息
@property (nonatomic,strong) NSString * marriageStr;// 婚姻信息
@property (nonatomic,strong) NSString * addressStr;// 地址信息
@property (nonatomic,strong) NSString * commenAddress; //常住地
@property (nonatomic,strong) NSString * firstNumber;//第一个联系人手机号
@property (nonatomic,strong) NSString * firstName;//第一个联系人姓名
@property (nonatomic,strong) NSString * secondNumber;//第二个联系人手机号
@property (nonatomic,strong) NSString * secondName;//第二个联系人姓名
@property (nonatomic,strong) NSString * thirdNumber;//第三个联系人手机号
@property (nonatomic,strong) NSString * thirdName;//第三个联系人姓名
@property (nonatomic,strong) NSString * firstSelctName;

@property (nonatomic,strong)AddressModel *provinceModel;
@property (nonatomic,strong)AddressModel *cityModel;
@end
