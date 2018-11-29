//
//  HXEvaluateCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HXEvaluateModel.h"
@interface HXEvaluateCell : BaseTableViewCell
@property (nonatomic,strong)HXEvaluateModel * model;
@property (nonatomic,strong)UIButton * selectBtn;
@end
