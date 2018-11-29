//
//  HXPartnerRecordTableViewCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HXBuyRecordModel.h"
@interface HXPartnerRecordTableViewCell : BaseTableViewCell
@property (nonatomic,strong)HXBuyRecordModel * model;
@property (nonatomic,strong)HXBuyRecordModel * incomeModel;
@property (nonatomic,strong)HXBuyRecordModel * withdrawModel;
@property (nonatomic,strong)UILabel * moneyLabel;
@property (nonatomic,strong)UILabel * stateLabel;
@property (nonatomic,strong)UILabel * dateLabel;
@end
