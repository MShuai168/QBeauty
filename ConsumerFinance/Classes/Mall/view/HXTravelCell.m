//
//  HXTravelCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXTravelCell.h"

@implementation HXTravelCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    /**
     *  icon
     */
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    //    photoImage.backgroundColor = [UIColor blackColor];
//    [photoImage setImage:[UIImage imageNamed:@"test01"]];
//    photoImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.height.and.width.mas_equalTo(60);
    }];
    
    /**
     *  标题
     */
    UILabel * nameLabel  = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = kUIColorFromRGB(0x333333);
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(115);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_lessThanOrEqualTo(48);
    }];
    /**
     * 月付
     */
    UILabel * paymontLabel = [[UILabel alloc] init];
    self.paymontLabel = paymontLabel;
    paymontLabel.text = @"月付:";
    paymontLabel.font = [UIFont systemFontOfSize:11];
    paymontLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:paymontLabel];
    [paymontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(88);
        make.left.equalTo(self.contentView).offset(115);
        make.height.mas_lessThanOrEqualTo(35);
    }];
    /**
     * money
     */
    UILabel * moneyLabel  = [[UILabel alloc] init];
    self.moneyLabel = moneyLabel;
    moneyLabel.font = [UIFont systemFontOfSize:11];
    moneyLabel.textColor = kUIColorFromRGB(0xFF6098);
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paymontLabel);
        make.left.equalTo(paymontLabel.mas_right).offset(10);
        make.height.mas_equalTo(16);
    }];
    //    [Helper adjustLabel:moneyLabel str:@"120" font:16];
    
    /**
     *  预约
     */
    UILabel * orderLabel = [[UILabel alloc] init];
    orderLabel.hidden = YES;
    self.orderLabel = orderLabel;
    orderLabel.font = [UIFont systemFontOfSize:11];
    orderLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:orderLabel];
    [orderLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paymontLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(11);
        make.width.mas_lessThanOrEqualTo(60);
    }];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
