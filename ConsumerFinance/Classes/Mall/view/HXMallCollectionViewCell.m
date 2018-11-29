//
//  HXMallCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/13.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXMallCollectionViewCell.h"

@interface HXMallCollectionViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HXMallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.centerX.equalTo(self.contentView);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = kUIColorFromRGB(0x888888);
//    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(77);
    }];
    
}

- (void)setViewModel:(HXMallCollectionViewCellViewModel *)viewModel {
    if (viewModel) {
        self.iconImageView.image = [UIImage imageNamed:viewModel.imageName];
        self.titleLabel.text = viewModel.title;
    }
}

@end
