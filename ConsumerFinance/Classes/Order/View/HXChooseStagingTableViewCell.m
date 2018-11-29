//
//  HXChooseStagingTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/25.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXChooseStagingTableViewCell.h"

@interface HXChooseStagingTableViewCell()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *stagingNumLabel;
@property (nonatomic, strong) UILabel *payAmountLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *checkButton;

@end

@implementation HXChooseStagingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [self.bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(55);
        make.top.equalTo(self.bgView).offset(10);
        make.bottom.equalTo(self.bgView).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.bgView addSubview:self.stagingNumLabel];
    [self.stagingNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.bottom.top.equalTo(self.bgView);
        make.right.equalTo(self.lineView.mas_left).offset(16);
    }];
    
    [self.bgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(24);
        make.top.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
        make.width.mas_equalTo(60);
    }];
    
    [self.bgView addSubview:self.payAmountLabel];
    [self.payAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel.mas_right).offset(0);
        make.top.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
        make.right.equalTo(self.bgView).offset(-44);
    }];
    
    [self.bgView addSubview:self.checkButton];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-16);
        make.top.bottom.equalTo(self.bgView);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = ColorWithHex(0xFAFAFA);
        _bgView.layer.borderColor = ColorWithHex(0xE5E5E5).CGColor;
        _bgView.layer.borderWidth = 0.5;
        _bgView.layer.cornerRadius = 4;
        
    }
    return _bgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    }
    return _lineView;
}

- (UILabel *)stagingNumLabel {
    if (!_stagingNumLabel) {
        _stagingNumLabel = [[UILabel alloc] init];
        _stagingNumLabel.text = @"3期";
        _stagingNumLabel.font = [UIFont systemFontOfSize:15];
        _stagingNumLabel.textColor = ColorWithHex(0x666666);
    }
    return _stagingNumLabel;
}

-(UILabel *)payAmountLabel {
    if (!_payAmountLabel) {
        _payAmountLabel = [[UILabel alloc] init];
        _payAmountLabel.text = @"¥343.33";
        _payAmountLabel.font = [UIFont systemFontOfSize:14];
        _payAmountLabel.textColor = ColorWithHex(0x151515);
    }
    return _payAmountLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"每期应还";
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = ColorWithHex(0x666666);
    }
    return _contentLabel;
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [[UIButton alloc] init];
        _checkButton.userInteractionEnabled = NO;
        [_checkButton setImage:[UIImage imageNamed:@"orderStaging"] forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage imageNamed:@"orderCheckedStaging"] forState:UIControlStateSelected];
    }
    return _checkButton;
}

- (void)setModel:(HXStagingDetailModel *)model {
    _model = model;
    
    self.stagingNumLabel.text = [NSString stringWithFormat:@"%@期",model.loamTerm];
    self.payAmountLabel.text = [NSString stringWithFormat:@"￥%@",model.repaymentByMonth];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.checkButton.selected = selected;
    if (selected) {
        self.bgView.layer.borderColor = ColorWithHex(0xE6BF73).CGColor;
        self.bgView.backgroundColor = [UIColor colorWithHex:0xE6BF73 alpha:0.3];
        _lineView.backgroundColor = ColorWithHex(0xE6BF73);
    } else {
        self.bgView.backgroundColor = ColorWithHex(0xFAFAFA);
        self.bgView.layer.borderColor = ColorWithHex(0xE5E5E5).CGColor;
        _lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    }
}

@end
