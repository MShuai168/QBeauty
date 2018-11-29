//
//  StoreOrderDetailCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "StoreOrderDetailCell.h"

@implementation StoreOrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(StoreOrderDetailModel *)model {
    self.titleLabel.text = model.productName;
//    [Helper changeLineSpaceForLabel:self.titleLabel WithSpace:5];
    self.numLabel.text = [NSString stringWithFormat:@"X%d",model.salesCount];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",model.price*model.salesCount];
    if (model.isTk) {
        self.refundLabel.hidden = false;
        self.refundLabel.text = [NSString stringWithFormat:@"已退X%d",model.tkCount];
//        self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",model.price*model.tkCount];
    } else {
        self.refundLabel.hidden = true;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
