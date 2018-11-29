//
//  HXMessageCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMessageCell.h"

@implementation HXMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    //图片
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.height.and.width.mas_equalTo(43);
    }];
    
    self.numberView = [[UIView alloc] init];
    self.numberView.backgroundColor = kUIColorFromRGB(0xffffff);
    self.numberView.layer.cornerRadius = 10;
    self.numberView.clipsToBounds = YES;
    [photoImage addSubview:self.numberView];
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(photoImage).offset(6);
        make.top.equalTo(photoImage).offset(-6);
        make.height.and.width.mas_offset(20);
    }];
    
    //消息数量
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.font = [UIFont systemFontOfSize:10];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.backgroundColor = ComonBackColor;
    self.numberLabel.textColor = kUIColorFromRGB(0xffffff);
    self.numberLabel.layer.cornerRadius = 9;
    self.numberLabel.layer.masksToBounds = YES;
    [self.numberView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.numberView).offset(1);
        make.right.bottom.equalTo(self.numberView).offset(-1);
        
    }];
    
    //标题
    self.nameLabel.text = @"系统通知";
    self.nameLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:14];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(73);
        make.top.mas_equalTo(self.contentView).offset(18);
    }];
    //内容
    UILabel * contentLabel = [[UILabel alloc] init];
    self.contentLabel = contentLabel;
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.textColor = ComonCharColor;
    [self.contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(42);
        make.left.equalTo(self.contentView).offset(73);
        make.right.equalTo(self.contentView).offset(-22);
    }];
    //时间
    UILabel * timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.textColor = ComonCharColor;
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
}

@end
