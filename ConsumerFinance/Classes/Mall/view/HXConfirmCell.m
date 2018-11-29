//
//  HXConfirmCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/17.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXConfirmCell.h"

@implementation HXConfirmCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    /**
     *  icon
     */
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    //    photoImage.backgroundColor = [UIColor blackColor];
    [photoImage setImage:[UIImage imageNamed:@"test02"]];
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.height.and.width.mas_equalTo(60);
    }];
    
    /**
     *  名字
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
    
 
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
