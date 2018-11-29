//
//  DockBeautyCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BeautyClinicModel.h"
#import "StarView.h"
#import "DtoListModel.h"
#import "HXStarView.h"
@interface DockBeautyCell : BaseTableViewCell
@property (nonatomic,strong)DtoListModel * model;
@property (nonatomic,strong) UILabel * orderLabel; //预约
@property (nonatomic,strong) UILabel * distanceLabel; //距离
@property (nonatomic,strong) UILabel * addressLabel; //地址
@property (nonatomic,strong) UIImageView * photoImage; //icon
@property (nonatomic,strong) HXStarView * star;
@end
