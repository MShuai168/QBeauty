//
//  HXMyMemberCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyMemberCollectionViewCell.h"

@implementation HXMyMemberCollectionViewCell
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
    self.photoImage = photoImage;
    photoImage.layer.cornerRadius = 30;
    photoImage.layer.masksToBounds = YES;
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(5);
        make.height.and.width.mas_equalTo(60);
    }];
    
    
    UILabel * titleLbel = [[UILabel alloc] init];
    self.titleLbel = titleLbel;
    titleLbel.textColor = ComonCharColor;
    titleLbel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.contentView addSubview:titleLbel];
    [titleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImage.mas_right).offset(8);
        make.top.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    UILabel * contentLbel = [[UILabel alloc] init];
    self.contentLbel = contentLbel;
    contentLbel.textColor = ComonCharColor;
    contentLbel.numberOfLines = 0;
    contentLbel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self.contentView addSubview:contentLbel];
    [contentLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImage.mas_right).offset(8);
        make.top.equalTo(titleLbel.mas_bottom).offset(4);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(36);
    }];
}
@end
