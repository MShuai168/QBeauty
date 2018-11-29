//
//  HXActivityTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXActivityTableViewCell.h"

@interface HXActivityTableViewCell()

@property (nonatomic, strong) UIImageView *activityImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HXActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

- (UIImageView *)activityImageView {
    if (!_activityImageView) {
        _activityImageView = [[UIImageView alloc] init];
        _activityImageView.layer.cornerRadius = 5;
        _activityImageView.layer.masksToBounds = YES;
    }
    return _activityImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = ColorWithHex(0x444444);
    }
    return _titleLabel;
}

- (void)setUpView {
    [self.contentView addSubview:self.activityImageView];
    [self.activityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(135);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.activityImageView.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HXRGB(221, 221, 221);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
    }];
}

- (void)setModel:(HXActivityModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    
    [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:(SCREEN_WIDTH-60)*2 height:270]] placeholderImage:[UIImage imageNamed:@"banner3"]];
    
    self.height = [self.titleLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)].height + 180;
    
}

@end
