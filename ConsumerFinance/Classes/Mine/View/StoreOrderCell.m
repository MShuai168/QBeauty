//
//  StoreOrderCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "StoreOrderCell.h"

@implementation StoreOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(StoreOrderListModel *)model {
    self.dateLabel.text = [Helper dateWithTimeStampAll:model.gmtCreate/1000];
    self.adressLabel.text = model.shopName;
    self.titleLabel.text = model.productName;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", model.realFee];
    self.orderStatusLabel.text = model.orderStatusName;
    [Helper changeLineSpaceForLabel:self.titleLabel WithSpace:6];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
