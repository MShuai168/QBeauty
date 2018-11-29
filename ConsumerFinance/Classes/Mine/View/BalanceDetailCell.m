//
//  BalanceDetailCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "BalanceDetailCell.h"

@implementation BalanceDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(BalanceDetailModel *)model {
    self.titleLabel.text = model.changeSource;
    self.dateLabel.text = [Helper dateWithTimeStampAll:model.created / 1000];
    //1:充值  2:消费  3:退款(退卡,消费退款)
    if (model.type == 1) {
        self.imgView.image = [UIImage imageNamed:@"chongZhi"];
        self.moneyLabel.text = model.changeAmount;
        self.moneyLabel.textColor = kUIColorFromRGB(0xFF7593);
    } else if (model.type == 2) {
        self.imgView.image = [UIImage imageNamed:@"xiaoFei"];
        self.moneyLabel.text = model.changeAmount;
        self.moneyLabel.textColor = kUIColorFromRGB(0x000000);
    } else if (model.type == 3) {
        self.imgView.image = [UIImage imageNamed:@"tuiKuan"];
        self.moneyLabel.text = model.changeAmount;
        self.moneyLabel.textColor = kUIColorFromRGB(0xFF7593);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
