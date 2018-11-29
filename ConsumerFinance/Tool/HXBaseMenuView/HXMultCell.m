//
//  HXMultCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/10.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXMultCell.h"

@implementation HXMultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(HXItem *)item {
    self.textLabel.text = item.title;
    self.backgroundColor = item.selected?kUIColorFromRGB(0xf5f7f8) : [UIColor whiteColor];
    self.textLabel.textColor = item.selected?ComonBackColor:ComonTextColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
