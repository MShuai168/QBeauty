//
//  HXWeddingDetailCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXWeddingDetailCell.h"
@implementation HXWeddingDetailCell
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
    nameLabel.text = @"[ 自体脂肪面部填充]";
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = kUIColorFromRGB(0x333333);
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(90);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(16);
    }];
    /**
     * 座位
     */
    UILabel * numberLabel = [[UILabel alloc] init];
    numberLabel.text = @"17～32桌";
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(90);
        make.height.mas_equalTo(12);
    }];
    /**
     * 层高
     */
    UILabel * heightLabel  = [[UILabel alloc] init];
    heightLabel.font = [UIFont systemFontOfSize:11];
    heightLabel.text = @"层高：5m";
    heightLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:heightLabel];
    [heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(90);
        make.height.mas_equalTo(12);
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
