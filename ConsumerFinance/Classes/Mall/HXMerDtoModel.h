//
//  HXMerDtoModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/3.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
//DtoListModel 一样 后期删除
@interface HXMerDtoModel : NSObject
@property (nonatomic,strong) NSString * detail;//商户地址
@property (nonatomic,strong) NSString * distance;//商户距离
@property (nonatomic,strong) NSString * dtoFlg;//dto判断 1为商家 2为项目
@property (nonatomic,strong) NSString * id ;//商户id
@property (nonatomic,strong) NSString * imgUrl;//商户图片
@property (nonatomic,strong) NSString * latitude;
@property (nonatomic,strong) NSString * longitude;
@property (nonatomic,strong) NSString * minPrice ;//分期价
@property (nonatomic,strong) NSString * reservationNum;//分期数
@property (nonatomic,strong) NSString * star ;//星级
@property (nonatomic,strong) NSString * title;//标题
@property (nonatomic,assign) BOOL  heightBool;
@end
