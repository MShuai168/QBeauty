//
//  HXSystemNotificationCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXSystemNotificationCell.h"
#import "ComButton.h"
@implementation HXSystemNotificationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)creatView {
    [super creatView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.bottom.equalTo(self);
    }];
    //标题
//    self.nameLabel.text = @"系统通知";
    self.nameLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:16];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.mas_equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(16);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(46);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-21);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    UIView *line = [[UIView alloc]init];
    self.line = line;
    line.backgroundColor = HXRGB(221, 221, 221);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.equalTo(self.contentView);
    }];
    
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = kUIColorFromRGB(0x666666);
        _contentLabel.numberOfLines = 0;
        
    }
    return _contentLabel;
}

- (void)layoutSubviews {
    [self creatView];
    [super layoutSubviews];
    
}

@end
