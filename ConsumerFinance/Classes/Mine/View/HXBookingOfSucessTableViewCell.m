//
//  HXBookingOfSucessTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/7/5.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBookingOfSucessTableViewCell.h"

@implementation HXBookingOfSucessTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setUpView {
    [super setUpView];
    [self.contentView addSubview:self.businessView];
    [self.businessView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(90);
        make.top.equalTo(self.commentValueLabel.mas_bottom).offset(10);
    }];
    
    [self.businessView addSubview:self.businessLabel];
    [self.businessLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.businessView).offset(15);
        make.top.equalTo(self.businessView).offset(15);
        make.right.equalTo(self.businessView).offset(-15);
    }];
    
    [self.businessView addSubview:self.accountManagerLabel];
    [self.accountManagerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.businessView).offset(15);
        make.right.equalTo(self.businessView).offset(-15);
        make.top.equalTo(self.businessLabel.mas_bottom).offset(10);
    }];
    
    [self.businessView addSubview:self.accountTelLabel];
    [self.accountTelLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.businessView).offset(15);
        make.right.equalTo(self.businessView).offset(-15);
        make.top.equalTo(self.accountManagerLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.businessView).offset(-10);
    }];
    
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.businessView.mas_bottom).offset(0);
    }];
    
    
    [self.orderTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.bottomLineView.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
    }];
    
    [self.contentView addSubview:self.successTimeLabel];
    [self.successTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.orderTimeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(16);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.contentView addSubview:self.successImageView];
    [self.successImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(14);
        make.right.equalTo(self.contentView).offset(-14);
        make.width.height.mas_equalTo(70);
    }];
}

- (UIView *)businessView {
    if (!_businessView) {
        _businessView = [[UIView alloc] init];
        _businessView.backgroundColor = ColorWithHex(0xFFF5E5);
    }
    return _businessView;
}

- (UILabel *)businessLabel {
    if (!_businessLabel) {
        _businessLabel = [[UILabel alloc] init];
        _businessLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _businessLabel.font = [UIFont systemFontOfSize:13];
        _businessLabel.textColor = ColorWithHex(0xF39F19);
        _businessLabel.text = @"推荐商户：";
        
        _businessValueLabel = [[UILabel alloc] init];
        _businessValueLabel.textColor = ColorWithHex(0xF39F19);
        _businessValueLabel.font = [UIFont systemFontOfSize:13];
        
        [_businessLabel addSubview:_businessValueLabel];
        [_businessValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_businessLabel);
            make.left.equalTo(_businessLabel).offset(75);
        }];
    }
    return _businessLabel;
}

- (UILabel *)accountTelLabel {
    if (!_accountTelLabel) {
        _accountTelLabel = [[UILabel alloc] init];
        _accountTelLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _accountTelLabel.font = [UIFont systemFontOfSize:13];
        _accountTelLabel.textColor = ColorWithHex(0xF39F19);
        _accountTelLabel.text = @"联系手机：";
        
        _accountTelValueLabel = [[UILabel alloc] init];
        _accountTelValueLabel.textColor = ColorWithHex(0xF39F19);
        _accountTelValueLabel.font = [UIFont systemFontOfSize:13];
        
        [_accountTelLabel addSubview:_accountTelValueLabel];
        [_accountTelValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_accountTelLabel);
            make.left.equalTo(_accountTelLabel).offset(75);
        }];
    }
    return _accountTelLabel;
}

- (UILabel *)accountManagerLabel {
    if (!_accountManagerLabel) {
        _accountManagerLabel = [[UILabel alloc] init];
        _accountManagerLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _accountManagerLabel.font = [UIFont systemFontOfSize:13];
        _accountManagerLabel.textColor = ColorWithHex(0xF39F19);
        _accountManagerLabel.text = @"客户经理：";
        
        _accountManagerValueLabel = [[UILabel alloc] init];
        _accountManagerValueLabel.textColor = ColorWithHex(0xF39F19);
        _accountManagerValueLabel.font = [UIFont systemFontOfSize:13];
        
        [_accountManagerLabel addSubview:_accountManagerValueLabel];
        [_accountManagerValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_accountManagerLabel);
            make.left.equalTo(_accountManagerLabel).offset(75);
        }];
    }
    return _accountManagerLabel;
}

- (UIImageView *)successImageView {
    if (!_successImageView) {
        _successImageView = [[UIImageView alloc] init];
        _successImageView.image = [UIImage imageNamed:@"bookingSuccess"];
    }
    return _successImageView;
}

- (UILabel *)successTimeLabel {
    if (!_successTimeLabel) {
        _successTimeLabel = [[UILabel alloc] init];
        _successTimeLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _successTimeLabel.textColor = ColorWithHex(0x666666);
        _successTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _successTimeLabel;
}

- (void)setViewModel:(HXBookingTableViewCellViewModel *)viewModel {
    [super setViewModel:viewModel];
    self.businessValueLabel.text = viewModel.recommendCompany;
    self.accountManagerValueLabel.text = viewModel.accountManager;
    self.accountTelValueLabel.text = viewModel.accountManagerTel;
    self.successTimeLabel.text = [NSString stringWithFormat:@"完成时间：%@",viewModel.successTime];
    
    [self.contentView layoutIfNeeded];
}

@end
