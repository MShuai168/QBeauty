//
//  HXHomeCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXHomeCollectionViewCell.h"


#import <Masonry/Masonry.h>

@interface HXHomeCollectionViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel * paymontLabel;

@end

@implementation HXHomeCollectionViewCell

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
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(100);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.text = @"医院名称";
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_bottom).offset(10);
        make.left.right.equalTo(self.contentView);
    }];
    
    _starView = [[HXStarView alloc] init];
    _starView.hidden = YES;
    [self.contentView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(12);
        make.bottom.equalTo(self.contentView);
    }];
    
    /**
     * 月付
     */
    UILabel * paymontLabel = [[UILabel alloc] init];
    self.paymontLabel = paymontLabel;
    paymontLabel.text = @"月付:";
    self.paymontLabel.hidden = YES;
    paymontLabel.font = [UIFont systemFontOfSize:13];
    paymontLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:paymontLabel];
    [paymontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.hidden = YES;
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.textColor = ColorWithHex(0xFC4880);
    _priceLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paymontLabel);
        make.left.equalTo(paymontLabel.mas_right).offset(5);
        make.height.mas_equalTo(16);
    }];
}

- (void)setViewModel:(HXHomeCollectionViewCellViewModel *)viewModel {
    if (viewModel) {
        NSURL * url = [NSURL URLWithString:viewModel.imageName];
        
        if (url) {
            
            [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"listLogo"] options:SDWebImageAllowInvalidSSLCertificates];
        }
        self.titleLabel.text = viewModel.title;
        self.starView.hidden = YES;
        self.priceLabel.hidden = YES;
        if (viewModel.cellStyle == HXHomeCollectionViewCellStyleCompany) {
            self.starView.hidden = NO;
            self.starView.starViewStyle = HXStarViewStyleShow;
            self.starView.star = viewModel.stars;
            
        } else {
            self.priceLabel.hidden = NO;
            self.paymontLabel.hidden = NO;
            self.priceLabel.text = [NSString stringWithFormat:@"¥%i起",(int)viewModel.price];
        }
    }
}

@end
