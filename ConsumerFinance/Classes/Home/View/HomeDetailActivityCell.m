//
//  HomeDetailActivityCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HomeDetailActivityCell.h"

@implementation HomeDetailActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(HomeDetailActivityModel *)model {
    self.titleLabel.text = model.name;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[model.icon stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet]] placeholderImage:[UIImage imageNamed:@"listLogo"]];
    NSArray *array = [model.tag componentsSeparatedByString:@","]; //字符串按照,分隔成数组
//    NSLog(@"array=%@=",array);
//    self【特色标签】【特色标签】【特色标签】】
    self.tagLabel.text = @"";
    for (int i = 0; i<array.count; i++) {
        if ([array[i] length] > 1) {
            self.tagLabel.text = [self.tagLabel.text stringByAppendingFormat:@"【%@】",array[i]];
        }
    }
//    NSLog(@"%@", self.tagLabel.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
