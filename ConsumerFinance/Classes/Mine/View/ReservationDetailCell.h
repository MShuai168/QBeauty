//
//  ReservationDetailCell.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/20.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReservationListModel.h"

@interface ReservationDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

- (void)configCellWithModel:(ReservationDetailModel *)model;

@end
