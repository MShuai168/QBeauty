//
//  HXTravelCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DtoListModel.h"
@interface HXTravelCell : BaseTableViewCell
@property (nonatomic,strong)DtoListModel * model;
@property (nonatomic,strong) UIImageView * photoImage; //icon
@property (nonatomic,strong) UILabel * paymontLabel; //月付
@property (nonatomic,strong) UILabel * moneyLabel; //月付金钱
@property (nonatomic,strong) UILabel * orderLabel;//订单
@end
