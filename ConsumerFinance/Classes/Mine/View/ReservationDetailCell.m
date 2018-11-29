//
//  ReservationDetailCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/20.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "ReservationDetailCell.h"

@implementation ReservationDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(ReservationDetailModel *)model {
    NSString *productImage = [NSString stringWithFormat:@"https://cdns.mtscrm.com/%@",model.productImage];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[productImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet]] placeholderImage:[UIImage imageNamed:@"defaultImg"]];
    self.titleLabel.text = model.productName;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f", model.price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
