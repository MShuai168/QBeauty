//
//  HXRecomdCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRecomdCollectionViewCell.h"
#import "StrikeThroughLabel.h"
@interface HXRecomdCollectionViewCell()
@property (nonatomic,strong)StrikeThroughLabel * priceLabel;
@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * scroLabel;
@property (nonatomic,strong)UILabel * moneyLabel;
@end
@implementation HXRecomdCollectionViewCell
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
        make.left.equalTo(self.contentView).offset(5);
        make.top.equalTo(self.contentView).offset(5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
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
    
    UILabel * qblabel = [[UILabel alloc] init];
    qblabel.text = @"趣贝";
    qblabel.textColor = ComonCharColor;
    qblabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:qblabel];
    [qblabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(176);
        make.right.equalTo(self.contentView.mas_right).offset(-self.contentView.width/2-0.5);
    }];
    UILabel * scroLabel = [[UILabel alloc] init];
    self.scroLabel = scroLabel;
    scroLabel.textColor = kUIColorFromRGB(0xFF6098);
//    scroLabel.text = @"40000";
    scroLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:scroLabel];
    scroLabel.font = [UIFont systemFontOfSize:11];
    [scroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-self.contentView.width/2-22);
        make.left.equalTo(self.contentView).offset(1);
        make.centerY.equalTo(qblabel);
    }];
    
    UILabel * moneyLabel = [[UILabel alloc] init];
    self.moneyLabel = moneyLabel;
    moneyLabel.layer.cornerRadius =2;
    moneyLabel.layer.masksToBounds = YES;
    moneyLabel.backgroundColor = kUIColorFromRGB(0xFF6098);
    moneyLabel.font = [UIFont systemFontOfSize:11];
    moneyLabel.textColor = CommonBackViewColor;
//    moneyLabel.text = @"+600000元";
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(0.5);
        make.centerY.equalTo(scroLabel);
        make.width.mas_lessThanOrEqualTo(self.contentView.frame.size.width/2-2);
    }];
    
    
    StrikeThroughLabel * priceLabel = [[StrikeThroughLabel alloc] init];
    self.priceLabel = priceLabel;
//    priceLabel.text = @"¥1000";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.strikeThroughEnabled = YES;
    priceLabel.font = [UIFont systemFontOfSize:11];
    priceLabel.textColor = ComonCharColor;
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(195);
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
    }];
}
-(void)setModel:(HXShopCarModel *)model {
    
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:200 height:200]] placeholderImage:[UIImage imageNamed:@"listLogo"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.proName.length!=0?model.proName:@"",model.specOne.length!=0?[NSString stringWithFormat:@" %@",model.specOne]:@"",model.specTwo.length!=0?[NSString stringWithFormat:@" %@",model.specTwo]:@"",model.specThree.length!=0?[NSString stringWithFormat:@" %@",model.specThree]:@""];

    model.score = model.score.length!=0?[NSString stringWithFormat:@"%d",[model.score intValue]]:@"0";
    model.price = model.price.length!=0?[NumAgent roundDown:model.price ifKeep:NO]:@"0";
    self.scroLabel.text = model.score;
    self.moneyLabel.text = [NSString stringWithFormat:@"+%@元",model.price.length!=0?model.price:@"0"];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.markPrice.length!=0?[NumAgent roundDown:model.markPrice ifKeep:NO]:@"0"];
    
}
@end
