//
//  HXMYCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMYCollectionViewCell.h"

@implementation HXMYCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
    }
    return self;
}
-(void)creatUI {
    
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImageView = photoImage;
    [self.contentView addSubview:photoImage];
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.centerX.equalTo(self.contentView);
        make.height.and.with.mas_equalTo(40);
    }];
    
    UIView * numberView = [[UIView alloc] init];
    self.numberView = numberView;
    numberView.backgroundColor = ComonBackColor;
    numberView.layer.cornerRadius = 7.5;
    numberView.layer.masksToBounds = YES;
    [photoImage addSubview:numberView];
    [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoImage);
        make.right.equalTo(photoImage);
        make.height.and.width.mas_equalTo(15);
    }];
    
    UILabel * numberLabel = [[UILabel alloc] init];
    self.numberLabel = numberLabel;
    numberLabel.text = @"0";
    numberLabel.layer.cornerRadius = 7.5;
    numberLabel.layer.masksToBounds = YES;
    numberLabel.textColor = CommonBackViewColor;
    numberLabel.font = [UIFont systemFontOfSize:12];
    [numberView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.centerX.equalTo(numberView);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.textColor = ComonTitleColor;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(56);
        make.centerX.equalTo(self.contentView);
    }];
}
@end
