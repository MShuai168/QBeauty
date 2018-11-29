//
//  HXCityCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/17.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXCityCollectionViewCell.h"

#import <Masonry/Masonry.h>

@interface HXCityCollectionViewCell()

@property (nonatomic, strong) UILabel *cityLabel;

@end

@implementation HXCityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self.contentView addSubview:self.cityLabel];
        [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.textColor = ColorWithHex(0x333333);
        _cityLabel.font = [UIFont systemFontOfSize:14];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cityLabel;
}

- (void)setCityName:(NSString *)cityName {
    self.cityLabel.text = cityName;
}

@end
