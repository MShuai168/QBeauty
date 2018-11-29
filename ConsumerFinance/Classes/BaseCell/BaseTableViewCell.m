
//
//  BaseTableViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.backgroundColor = kUIColorFromRGB(0xf9f9f9);
        [self creatView];
        
    }
    return self;
    
}
-(void)creatView {
    

    
}
#pragma mark -- 创建分割线
-(void)creatLine:(NSInteger)left hidden:(BOOL)hidden {
    UIView *line = [[UIView alloc]init];
    self.line = line;
    line.hidden = hidden;
    line.backgroundColor = HXRGB(221, 221, 221);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView).mas_offset(left);
        make.width.mas_equalTo(SCREEN_WIDTH-left);
    }];
    
}
#pragma mark -- setter and getter
-(UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font =[UIFont systemFontOfSize:14];
        _nameLabel.textColor = ComonTextColor;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
        }];
    }
    return _nameLabel;
}
-(HDTextField *)writeTextfield {
    if (_writeTextfield == nil) {
        _writeTextfield = [[HDTextField alloc] initWithFrame:CGRectMake(0, 80, 320, 49)];
        _writeTextfield.textColor = ComonTextColor;
        _writeTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _writeTextfield.textAlignment = NSTextAlignmentRight;
        _writeTextfield.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_writeTextfield];
        [_writeTextfield  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.mas_equalTo(SCREEN_WIDTH-100);
        }];
    }
    return _writeTextfield;
}
-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = ComonCharColor;
//        _titleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
//            make.left.lessThanOrEqualTo(self.contentView.mas_left).offset(100);
        }];
    }
    return _titleLabel;
}
-(UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:ComonCharColor forState:UIControlStateNormal];
        [self.contentView addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(0);
        }];
    }
    return _rightButton;
}
-(UIImageView *)headImage {
    if (_headImage == nil) {
        _headImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImage];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = 25;
        [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.height.and.width.mas_equalTo(50);
            make.right.equalTo(self.contentView).offset(0);
        }];

    }
    return _headImage;
    
}
-(UIImageView *)bankImage
{
    if (_bankImage == nil) {
        _bankImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_bankImage];
        [_bankImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.width.and.height.mas_equalTo(25);
        }];
    }
    return _bankImage;
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
