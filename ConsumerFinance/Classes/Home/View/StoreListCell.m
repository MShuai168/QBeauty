//
//  StoreListCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/18.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "StoreListCell.h"

@implementation StoreListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(StoreListModel *)model {
//    [self.imgView sd_setImageWithURL:model.logo placeholderImage:[UIImage imageNamed:@"listLogo"] options:SDWebImageAllowInvalidSSLCertificates];
//    NSString *url = [model.logo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[model.logo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet]] placeholderImage:[UIImage imageNamed:@"listLogo"]];
    self.titleLabel.text = model.shopName;
    self.addressLabel.text = model.address;
    self.phoneLabel.text = model.tel;
    self.dateLabel.text = [NSString stringWithFormat:@"%@--%@",model.startTime,model.endTime];
    if (model.distanceStr != nil) {
//        NSLog(@"距离不为空");
        self.addressImg.hidden = false;
        self.distanceLabel.hidden = false;
        self.distanceLabel.text = model.distanceStr;
    } else {
//        NSLog(@"XXXX 空空如也");
        self.addressImg.hidden = true;
        self.distanceLabel.hidden = true;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
