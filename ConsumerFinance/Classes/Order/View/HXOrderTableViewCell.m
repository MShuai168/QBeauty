//
//  HXOrderTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/14.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXOrderTableViewCell.h"

#import <Masonry/Masonry.h>

@interface HXOrderTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *orderLabel;

@end

@implementation HXOrderTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUpView];
}

- (void)setUpView {
    
    [self.contentView addSubview:self.orderLabel];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(38);
    }];
    
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.orderLabel.mas_bottom).offset(15);
        make.size.mas_equalTo([UIImage imageNamed:@"dingdanYM"].size);
    }];
    [self.contentView addSubview:self.companyLabel];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.top.equalTo(self.orderLabel.mas_bottom).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(self.companyLabel.intrinsicContentSize.height);
    }];
    
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.orderLabel.mas_bottom).offset(33);
        make.size.mas_equalTo([UIImage imageNamed:@"NextButton"].size);
    }];
    
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImageView.mas_left).offset(0);
        make.bottom.equalTo(self.contentView).offset(-33);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(80);
    }];
    
    [self.contentView addSubview:self.productLabel];
    [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.companyLabel.mas_left);
        make.top.equalTo(self.companyLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-150);
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productLabel.mas_right).offset(15);
        make.top.equalTo(self.orderLabel.mas_bottom).offset(33);
        make.right.equalTo(self.rightImageView.mas_left).offset(0);
    }];
    
    [self.contentView addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.companyLabel.mas_left);
        make.top.equalTo(self.productLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-20);
        make.right.equalTo(self.priceLabel.mas_right);
    }];
    
//    [self.contentView addSubview:self.lineView];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView);
//        make.height.mas_equalTo(0.5);
//        make.right.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView).offset(0);
//    }];
}

- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.font = [UIFont systemFontOfSize:13];
        _orderLabel.textColor = ColorWithHex(0x999999);
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ColorWithHex(0xE6E6E6);
        [_orderLabel addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_orderLabel);
            make.bottom.equalTo(_orderLabel);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return _orderLabel;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"NextButton"];
    }
    return _rightImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"dingdanYM"];
    }
    return _iconImageView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.textColor = ColorWithHex(0x4A90E2);
        _statusLabel.font = [UIFont systemFontOfSize:12];
    }
    return _statusLabel;
}

- (UILabel *)companyLabel {
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.textColor = ColorWithHex(0x333333);
        _companyLabel.font = [UIFont systemFontOfSize:15];
    }
    return _companyLabel;
}

- (UILabel *)productLabel {
    if (!_productLabel) {
        _productLabel = [[UILabel alloc] init];
        _productLabel.textColor = ColorWithHex(0x666666);
        _productLabel.font = [UIFont systemFontOfSize:12];
    }
    return _productLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.textColor = ComonBackColor;
        _priceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _priceLabel;
}

- (UILabel *)orderTimeLabel {
    if (!_orderTimeLabel) {
        _orderTimeLabel = [[UILabel alloc] init];
        _orderTimeLabel.textColor = ColorWithHex(0x666666);
        _orderTimeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _orderTimeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorWithHex(0xcccccc);
    }
    return _lineView;
}

- (void)setViewModel:(HXOrderTableViewCellViewModel *)viewModel {
    self.orderLabel.text = [NSString stringWithFormat:@"订单编号：%@",viewModel.orderNoOuter];
    self.companyLabel.text = viewModel.companyName;
    self.productLabel.text = viewModel.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",[NSString stringFormatterWithCurrency:viewModel.price]];
    self.statusLabel.text = viewModel.status;
    self.orderTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",viewModel.orderTime];
}

@end
