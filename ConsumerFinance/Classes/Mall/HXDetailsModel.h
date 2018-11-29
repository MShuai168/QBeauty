//
//  HXDetailsModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/31.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXDetailsModel : NSObject
@property(nonatomic,strong)NSString * address;// 地址
@property(nonatomic,strong)NSString * caseNumber;//案例
@property(nonatomic,strong)NSString * companyLatitude ;//经纬度
@property(nonatomic,strong)NSString * companyLongitude ;//经纬度
@property(nonatomic,strong)NSString * companyName; //公司名称
@property(nonatomic,strong)NSArray * companyPicUrl ;//banner图片
@property(nonatomic,strong)NSString * companyProfile;//商户信息描述
@property(nonatomic,strong)NSArray * companyProfilePicUrl ;//商户信息图片
@property(nonatomic,strong)NSString * companyPicUrlcompanyType;
@property(nonatomic,strong)NSString * createdAt;
@property(nonatomic,strong)NSString * dictCode;
@property(nonatomic,strong)NSString * distance;
@property(nonatomic,strong)NSString * id ;//商户ID
@property(nonatomic,strong)NSString * isEnable;
@property(nonatomic,strong)NSString * managerName ;
@property(nonatomic,strong)NSString * paymentType ;
@property(nonatomic,strong)NSString * productTypeId;
@property(nonatomic,strong)NSArray * productTypes;
@property(nonatomic,strong)NSString * remark;
@property(nonatomic,strong)NSString * reservationNumber;
@property(nonatomic,strong)NSString * sales_manager_id;
@property(nonatomic,strong)NSString * starLevel ; //星星等级
@property(nonatomic,strong)NSString * telephone;
@property(nonatomic,strong)NSString * updatedAt; //电话
@end
