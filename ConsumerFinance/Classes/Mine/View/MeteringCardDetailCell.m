//
//  MeteringCardDetailCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "MeteringCardDetailCell.h"

@implementation MeteringCardDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(MeteringCardDetailModel *)model withNumType:(int)type{
    self.titleLabel.text = model.projectName;
    //次卡类型(1:有限   2：无限)
    if (type == 1) {
        self.totalNumLabel.text = [NSString stringWithFormat:@"%d次", model.totalTime];
        self.residueLabel.text = [NSString stringWithFormat:@"%d次", model.surTime];
    } else if (type == 2) {
        self.totalNumLabel.text = @"无限";
        self.residueLabel.text = @"无限";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
