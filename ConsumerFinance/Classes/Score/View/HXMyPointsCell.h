//
//  HXMyPointsCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HXScoreRecordsModel.h"
@interface HXMyPointsCell : BaseTableViewCell
@property (nonatomic,strong)UILabel * archivePointLabel;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)HXScoreRecordsModel * model;
@end
