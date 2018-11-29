//
//  DtoListModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/28.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BeautyClinicModel.h"

@interface DtoListModel : BeautyClinicModel
@property(nonatomic,strong)NSString * detail;
@property(nonatomic,strong)NSString * distance ; //距离
@property(nonatomic,strong)NSString * dtoFlg ; //1商家 2项目
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * imgUrl; //列表展示图
@property(nonatomic,strong)NSString * latitude;
@property(nonatomic,strong)NSString * longitude;
@property(nonatomic,strong)NSString * minPrice; //最低月供
@property(nonatomic,strong)NSString * reservationNum; //预约数
@property(nonatomic,strong)NSString * star; //星级
@property (nonatomic,assign)BOOL bigBool; //NO 90 YES 105

@end
