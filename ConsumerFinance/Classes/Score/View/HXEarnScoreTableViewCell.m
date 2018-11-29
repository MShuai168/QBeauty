//
//  HXEarnScoreTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXEarnScoreTableViewCell.h"

#import <Masonry/Masonry.h>

@interface HXEarnScoreTableViewCell()

@property (nonatomic, strong) UIView *rightSuccessView;

@end

@implementation HXEarnScoreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        [self updateStyle];
        [self setUpRightSucessView];
    }
    return self;
}

- (void)updateStyle {
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor colorWithHex:0x333333];
    
    self.detailTextLabel.font = [UIFont systemFontOfSize:15];
    self.detailTextLabel.textColor = [UIColor colorWithHex:0xFF8730];
}

- (UIView *)rightSuccessView {
    if (!_rightSuccessView) {
        _rightSuccessView = [[UIView alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"scoreShape"];
        imageView.image = image;
        [_rightSuccessView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_rightSuccessView);
            make.size.mas_equalTo(image.size);
            make.centerY.equalTo(_rightSuccessView);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithHex:0xcccccc];
        label.text = @"已完成";
        [_rightSuccessView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
            make.top.bottom.right.equalTo(_rightSuccessView);
        }];
    }
    return _rightSuccessView;
}

- (void)setUpRightSucessView {
    [self.contentView addSubview:self.rightSuccessView];
    [self.rightSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-33);
    }];
}

- (void)setModel:(HXEarnScoreModel *)model {
    _model = model;
    self.textLabel.text = model.taskName;
    self.imageView.image = [UIImage imageNamed:model.leftImage];
//    self.detailTextLabel.text = [NSString stringWithFormat:@"+%@积分",model.score];
    self.detailTextLabel.text = model.detail;
    
    self.rightSuccessView.hidden = !model.isCompleted;
    self.detailTextLabel.hidden = model.isCompleted;
}


@end
