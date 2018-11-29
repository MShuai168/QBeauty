//
//  DockBeautyCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "DockBeautyCell.h"

@interface DockBeautyCell()
@end
@implementation DockBeautyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    
    /**
     *  icon
     */
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    //    photoImage.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.height.and.width.mas_equalTo(60);
    }];
    
    /**
     *  隐藏导航栏
     */
    UILabel * nameLabel  = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.numberOfLines = 0;
    nameLabel.textColor = kUIColorFromRGB(0x333333);
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(90);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_lessThanOrEqualTo(40);
    }];
    /**
     *  地址
     */
    UILabel * addressLabel = [[UILabel alloc] init];
    self.addressLabel = addressLabel;
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.textColor = kUIColorFromRGB(0x999999);
    addressLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(90);
        make.right.equalTo(self.contentView.mas_right).offset(-80);
        make.height.mas_equalTo(12);
    }];
    /**
     *  距离
     */
    UILabel * distanceLabel = [[UILabel alloc] init];
    distanceLabel.font = [UIFont systemFontOfSize:11];
    distanceLabel.textColor = kUIColorFromRGB(0x999999);
    self.distanceLabel = distanceLabel;
    [self.contentView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.contentView.mas_top).offset(41.5);
        make.centerY.equalTo(addressLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(11);
        make.width.mas_lessThanOrEqualTo(60);
    }];
    /**
     *  星星
     */
    HXStarView * star = [[HXStarView alloc] init];
    self.star = star;
    [self.contentView addSubview:star];
    [star  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_bottom).offset(5);
        make.left.equalTo(addressLabel);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(100);
    }];
    /**
     *  预约
     */
    UILabel * orderLabel = [[UILabel alloc] init];
    _orderLabel = orderLabel;
    orderLabel.font = [UIFont systemFontOfSize:11];
    orderLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:orderLabel];
    [orderLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(star);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(11);
        make.width.mas_lessThanOrEqualTo(60);
    }];
    
}

-(void)setModel:(DtoListModel *)model {
   
    self.nameLabel.text = model.title ? model.title :@"";
    self.star.star = model.star ? [model.star doubleValue] :0.0;
    self.addressLabel.text  = model.address ? model.address :@"";
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"listLogo"]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
