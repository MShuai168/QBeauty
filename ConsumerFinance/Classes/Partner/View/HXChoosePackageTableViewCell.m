//
//  HXChoosePackageTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXChoosePackageTableViewCell.h"
#import "UIControl+HXCommandCategory.h"

#import <RZDataBinding/RZDataBinding.h>

@interface HXChoosePackageTableViewCell()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation HXChoosePackageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)bind {
    [self.leftButton rz_bindKey:RZDB_KP(UIButton, selected) toKeyPath:RZDB_KP(HXPackageModel, isChoosed) ofObject:self.model];
}

- (void)unBind {
    [self.leftButton rz_unbindKey:RZDB_KP(UIButton, selected) fromKeyPath:RZDB_KP(HXPackageModel, isChoosed) ofObject:self.model];
}

- (void)createUI {
    [self.contentView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(47);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftButton.mas_right).offset(1);
        make.top.equalTo(self.contentView).offset(22);
        make.right.equalTo(self.contentView).offset(-30);
        make.height.mas_equalTo(16);
    }];
    
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView).offset(-20);
        make.size.mas_equalTo(self.tagLabel.intrinsicContentSize);
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagLabel.mas_right);
        make.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        _leftButton.hx_command = self.hx_command;
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setImage:[UIImage imageNamed:@"packageunSelect"] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"packageSelect"] forState:UIControlStateSelected];
        [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(-28, 0, 0, 0)];
    }
    return _leftButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = ColorWithHex(0x333333);
    }
    return _titleLabel;
}

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.text = @"￥";
        _tagLabel.font = [UIFont systemFontOfSize:12];
        _tagLabel.textColor = ColorWithHex(0x333333);
    }
    return _tagLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:18];
        _priceLabel.font = [UIFont fontWithName:@"DINMittelschrift-Alternate" size:18];
        _priceLabel.textColor = ColorWithHex(0x333333);
    }
    return _priceLabel;
}

- (void)setModel:(HXPackageModel *)model {
    _model = model;
    self.leftButton.selected = model.isChoosed;
    self.titleLabel.text = model.name;
    self.priceLabel.text = [NSString stringFormatterWithCurrency:model.price];
    
//    [self unBind];
//    [self bind];
}

- (void)leftButtonClick:(UIButton *)button {
    [self.hx_command execute:button];
}

@end
