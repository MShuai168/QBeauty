//
//  CouponUnusedCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/21.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "CouponUnusedCell.h"

@implementation CouponUnusedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(CouponListModel *)model withType:(int)type {
    //优惠券类型：S_YHQLX_ZK-折扣优惠券、S_YHQLX_HB-红包优惠券
    self.titleLabel.text = model.benefit;

    if ([model.type isEqualToString:@"S_YHQLX_ZK"]) {
        NSString *str = [NSString stringWithFormat:@"%@折", model.benefit];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        //设置颜色
        //        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(0, 1)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
        //设置尺寸
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(str.length-1, 1)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
        //这段代码必须要写 否则没效果
        self.titleLabel.attributedText = attributedString;
    } else {
        NSString *str = [NSString stringWithFormat:@"￥%@", model.benefit];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        //设置颜色
        //        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(0, 1)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
        //设置尺寸
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, 1)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
        //这段代码必须要写 否则没效果
        self.titleLabel.attributedText = attributedString;
    }
    self.markedLabel.text = model.couponName;
    self.subtitleLabel.text = model.sytjName;
    self.dateLabel.text = model.effectiveTime;
    
    if (type == 1) {
        self.tempLabel.text = @"未使用";
    } else if (type == 2) {
        self.tempLabel.backgroundColor = [UIColor colorWithHex:0xcccccc];
        self.tempLabel.text = @"已使用";
    } else if (type == 3) {
        self.tempLabel.backgroundColor = [UIColor colorWithHex:0xcccccc];
        self.tempLabel.text = @"已过期";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
