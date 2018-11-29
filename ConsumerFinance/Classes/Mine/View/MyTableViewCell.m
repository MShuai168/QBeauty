//
//  MyTableViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "MyTableViewCell.h"
@interface MyTableViewCell()

@end
@implementation MyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    [self creatLine:25 hidden:NO];
//    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    /**
     *   icon
     */
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    [self.contentView addSubview:photoImage];
//    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(0);
//        make.centerY.equalTo(self.contentView);
//    }];
    
    /**
     *   名称
     */
    UILabel * nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = ComonTitleColor;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(50);
    }];
    /**
     *   状态信息
     */
    UILabel * statesLabel = [[UILabel alloc] init];
    self.statesLabel = statesLabel;
    statesLabel.font = [UIFont systemFontOfSize:14];
    statesLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:statesLabel];
    [statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-30);
    }];

}
-(UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.backgroundColor = ComonBackColor;
        _numberLabel.font = [UIFont systemFontOfSize:13];
        _numberLabel.textColor = CommonBackViewColor;
        _numberLabel.layer.cornerRadius =10;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.layer.masksToBounds = YES;
        _numberLabel.text = 0;
        [self.contentView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(115);
            make.height.and.width.mas_equalTo(20);
        }];
    }
    return _numberLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
