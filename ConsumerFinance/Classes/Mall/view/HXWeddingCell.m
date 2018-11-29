//
//  HXWeddingCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/14.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXWeddingCell.h"

@implementation HXWeddingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    
    /**
     * 月付
     */
    UILabel * paymontLabel = [[UILabel alloc] init];
    paymontLabel.text = @"月付:";
    paymontLabel.font = [UIFont systemFontOfSize:11];
    paymontLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:paymontLabel];
    [paymontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.star.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(90);
        make.height.mas_lessThanOrEqualTo(35);
    }];
    /**
     * money
     */
    UILabel * moneyLabel  = [[UILabel alloc] init];
    moneyLabel.font = [UIFont systemFontOfSize:11];
    moneyLabel.text = @"¥0起";
    moneyLabel.textColor = ComonBackColor;
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paymontLabel);
        make.left.equalTo(paymontLabel.mas_right).offset(10);
        make.height.mas_equalTo(16);
    }];
    
    [self.distanceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.star);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(11);
        make.width.mas_lessThanOrEqualTo(60);
    }];
    [self.orderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paymontLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(11);
        make.width.mas_lessThanOrEqualTo(60);
    }];
    
}
-(void)setModel:(BeautyClinicModel *)model {
    
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
