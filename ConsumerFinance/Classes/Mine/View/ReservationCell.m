//
//  ReservationCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/23.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "ReservationCell.h"

@implementation ReservationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Helper changeLineSpaceForLabel:self.nameLabel WithSpace:8];
}

- (void)configCellWithModel:(ReservationListModel *)model {
    self.nameLabel.text = model.shopName;
    self.stateLabel.text = model.reserveStatusName;
    self.dateLabel.text = [Helper dateWithTimeStampAll:model.gmtStart/1000];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
