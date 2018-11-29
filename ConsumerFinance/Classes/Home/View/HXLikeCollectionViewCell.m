//
//  HXLikeCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXLikeCollectionViewCell.h"
@interface HXLikeCollectionViewCell()
@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * moneyLabel;
@end
@implementation HXLikeCollectionViewCell
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
    photoImage.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(5);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
//    titleLabel.text = @"Channel 香奈儿粉Channel 香奈儿粉Channel 香奈儿粉";
    self.titleLabel = titleLabel;
    titleLabel.textColor = ComonTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoImage.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
//    nameLabel.text = @"上海复美医疗美容医院";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = ComonCharColor;
    nameLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(146);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];
    
    UILabel * moneyLabel = [[UILabel alloc] init];
    self.moneyLabel = moneyLabel;
//    moneyLabel.text = @"¥6600起";
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = kUIColorFromRGB(0xFF6098);
    moneyLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(167);
        make.centerX.equalTo(self.contentView);
        make.width.mas_lessThanOrEqualTo(self.contentView.frame.size.width-10);
    }];
    
}
-(void)setModel:(HXProjectModel *)model {
    
    self.titleLabel.text = model.name ? model.name :@"";
    model.stagePrice = model.stagePrice.length!=0?[NumAgent roundDown:model.stagePrice ifKeep:NO]:@"0.00";
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@起",model.stagePrice];
    self.nameLabel.text = model.merName ? model.merName :@"";
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.icon width:180 height:180]] placeholderImage:[UIImage imageNamed:@"listLogo"] options:SDWebImageAllowInvalidSSLCertificates];
}
@end
