//
//  HXBookingOfCancelTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/7/5.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBookingOfCancelTableViewCell.h"

@implementation HXBookingOfCancelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setUpView {
    [super setUpView];
    [self.orderTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.commentValueLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
    }];
    
    [self.contentView addSubview:self.cancelTimeLabel];
    [self.cancelTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.orderTimeLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(16);
    }];
}

- (UILabel *)cancelTimeLabel {
    if (!_cancelTimeLabel) {
        _cancelTimeLabel = [[UILabel alloc] init];
        _cancelTimeLabel.preferredMaxLayoutWidth = self.frame.size.width - 30;
        _cancelTimeLabel.textColor = ColorWithHex(0x666666);
        _cancelTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _cancelTimeLabel;
}

- (void)setViewModel:(HXBookingTableViewCellViewModel *)viewModel {
    [super setViewModel:viewModel];
    self.cancelTimeLabel.text = [NSString stringWithFormat:@"取消时间：%@",viewModel.cancelTime];
    [self.contentView layoutIfNeeded];
}

@end
