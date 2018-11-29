//
//  HXBookingTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/16.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBookingTableViewCell.h"

#import <RZDataBinding/RZDataBinding.h>

@interface HXBookingTableViewCell()

@end

@implementation HXBookingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    [self.contentView addSubview:self.bookingNumberLabel];
    [self.bookingNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.bookingNumberLabel.mas_top);
        make.height.equalTo(self.bookingNumberLabel.mas_height);
        make.left.equalTo(self.bookingNumberLabel.mas_right).offset(15);
        make.width.mas_equalTo(80);
    }];

    [self.contentView addSubview:self.lineView];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(44);
    }];
    
    // 公司信息
    
    [self.contentView addSubview:self.companyView];
    [self.companyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.lineView).offset(10);
        make.height.mas_equalTo(60);
    }];
    
    [self.companyView addSubview:self.logoImageView];
    [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.companyView);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.companyView addSubview:self.companyLabel];
    [self.companyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImageView.mas_right).offset(15);
        make.top.equalTo(self.companyView).offset(11);
        make.right.equalTo(self.companyView);
    }];
    
    [self.companyView addSubview:self.addressLabel];
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.companyLabel);
        make.top.equalTo(self.companyLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.companyView).offset(-11);
    }];
    
    // 客户信息

    [self.contentView addSubview:self.productLabel];
    
    [self.productLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.companyView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(13);
    }];

    [self.contentView addSubview:self.iphoneLabel];
    [self.iphoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.productLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(13);
    }];
    
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.iphoneLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.contentView addSubview:self.commentValueLabel];
    [self.commentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iphoneLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.left.equalTo(_commentLabel).offset(75);
        make.height.mas_greaterThanOrEqualTo(16);
    }];
    
    [self.contentView addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.commentValueLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(16);
    }];
    
}

#pragma mark - 懒加载

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _commentLabel.numberOfLines = 0;
        _commentLabel.textColor = ColorWithHex(0x666666);
        _commentLabel.font = [UIFont systemFontOfSize:13];
        _commentLabel.text = @"备注：";
        
    }
    return _commentLabel;
}

- (UILabel *)commentValueLabel {
    if (!_commentValueLabel) {
        _commentValueLabel = [[UILabel alloc] init];
        _commentValueLabel.text = @"备注值";
        _commentValueLabel.textColor = ColorWithHex(0x666666);
        _commentValueLabel.font = [UIFont systemFontOfSize:13];
        _commentValueLabel.preferredMaxLayoutWidth = self.frame.size.width - 100;
        _commentValueLabel.numberOfLines = 0;
    }
    return _commentValueLabel;
}

- (UILabel *)bookingNumberLabel {
    if (!_bookingNumberLabel) {
        _bookingNumberLabel = [[UILabel alloc] init];
        _bookingNumberLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _bookingNumberLabel.numberOfLines = 0;
        _bookingNumberLabel.textColor = ColorWithHex(0x333333);
        _bookingNumberLabel.font = [UIFont systemFontOfSize:13];
    }
    return _bookingNumberLabel;
}

- (UIView *)companyView {
    if (!_companyView) {
        _companyView = [[UIView alloc] init];
        _companyView.backgroundColor = ColorWithHex(0xF2F4F5);
    }
    return _companyView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.preferredMaxLayoutWidth = self.frame.size.width - 90;
        _addressLabel.textColor = ColorWithHex(0x999999);
        _addressLabel.font = [UIFont systemFontOfSize:12];
    }
    return _addressLabel;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.backgroundColor = [UIColor whiteColor];
    }
    return _logoImageView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.textColor = ColorWithHex(0x4A90E2);
        _statusLabel.font = [UIFont systemFontOfSize:15];
    }
    return _statusLabel;
}

- (UILabel *)companyLabel {
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.textColor = ColorWithHex(0x333333);
        _companyLabel.preferredMaxLayoutWidth = self.frame.size.width-90;
        _companyLabel.font = [UIFont systemFontOfSize:16];
    }
    return _companyLabel;
}

- (UILabel *)productLabel {
    if (!_productLabel) {
        _productLabel = [[UILabel alloc] init];
        _productLabel.preferredMaxLayoutWidth = self.frame.size.width-30;
        _productLabel.textColor = ColorWithHex(0x666666);
        [_productLabel sizeToFit];
        _productLabel.font = [UIFont systemFontOfSize:13];
        _productLabel.text = @"预约人：";
        
        _productValueLabel = [[UILabel alloc] init];
        _productValueLabel.text = @"dsds";
        _productValueLabel.textColor = ColorWithHex(0x666666);
        _productValueLabel.font = [UIFont systemFontOfSize:13];
        
        [_productLabel addSubview:_productValueLabel];
        [_productValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_productLabel);
            make.left.equalTo(_productLabel).offset(75);
        }];
    }
    return _productLabel;
}

- (UILabel *)iphoneLabel {
    if (!_iphoneLabel) {
        _iphoneLabel = [[UILabel alloc] init];
        _iphoneLabel.preferredMaxLayoutWidth = self.frame.size.width-30;
        _iphoneLabel.textColor = ColorWithHex(0x666666);
        _iphoneLabel.font = [UIFont systemFontOfSize:13];
        _iphoneLabel.text = @"预约手机：";
        
        _iphoneValueLabel = [[UILabel alloc] init];
        _iphoneValueLabel.textColor = ColorWithHex(0x666666);
        _iphoneValueLabel.font = [UIFont systemFontOfSize:13];
        
        [_iphoneLabel addSubview:_iphoneValueLabel];
        [_iphoneValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_iphoneLabel);
            make.left.equalTo(_iphoneLabel).offset(75);
        }];
    }
    return _iphoneLabel;
}

- (UILabel *)orderTimeLabel {
    if (!_orderTimeLabel) {
        _orderTimeLabel = [[UILabel alloc] init];
        _orderTimeLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _orderTimeLabel.textColor = ColorWithHex(0x666666);
        _orderTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _orderTimeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    }
    return _lineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = ColorWithHex(0xE6E6E6);
    }
    return _bottomLineView;
}

- (void)setViewModel:(HXBookingTableViewCellViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.bookingNumberLabel.text = [NSString stringWithFormat:@"编号：%@",viewModel.bookingNumber];
    
    switch (viewModel.status) {
        case bookingDetailCancel:
            self.statusLabel.text = @"已取消";
            self.statusLabel.textColor = ColorWithHex(0x999999);
            
            break;
        case bookingDetailInProgress:
            self.statusLabel.text = @"处理中";
            self.statusLabel.textColor = ColorWithHex(0x4A90E2);
            
            break;
        case bookingDetailSucess:{
            }
            break;
            
        default:
            break;
    }
    
    self.companyLabel.text = viewModel.companyName;
    self.addressLabel.text = viewModel.address;
    NSURL *imageUrl = [NSURL URLWithString:viewModel.logo];
    
    
    [self.logoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"listLogo"]];
    
    self.productValueLabel.text = viewModel.bookingPerson;
    self.iphoneValueLabel.text = viewModel.bookingIphone;
    self.commentValueLabel.text = viewModel.comment;
    
    self.orderTimeLabel.text = [NSString stringWithFormat:@"提交时间：%@",viewModel.commintTime];
    
    [self.contentView layoutIfNeeded];
    
}


@end
