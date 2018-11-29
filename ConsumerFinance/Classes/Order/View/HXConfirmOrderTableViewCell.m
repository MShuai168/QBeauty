//
//  HXConfirmOrderTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/21.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXConfirmOrderTableViewCell.h"

@interface HXConfirmOrderTableViewCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nameValueLabel;

@end

@implementation HXConfirmOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(69);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.contentView addSubview:self.nameValueLabel];
    [self.nameValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(0);
        make.top.equalTo(self.nameLabel.mas_top);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
    }];
    
}

- (UILabel *)nameValueLabel {
    if (!_nameValueLabel) {
        _nameValueLabel = [[UILabel alloc] init];
        _nameValueLabel.numberOfLines = 0;
        _nameValueLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _nameValueLabel.textColor = ColorWithHex(0x333333);
        _nameValueLabel.font = [UIFont systemFontOfSize:13];
    }
    return _nameValueLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = ColorWithHex(0x999999);
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.text = @"姓名：";
    }
    return _nameLabel;
}

- (void)setViewModel:(HXConfirmOrderTableViewCellViewModel *)viewModel {
    _viewModel = viewModel;
    self.nameLabel.text = [NSString stringWithFormat:@"%@：",viewModel.title];
    self.nameValueLabel.text = viewModel.rightValue;
    
    [self.contentView layoutIfNeeded];
}

@end
