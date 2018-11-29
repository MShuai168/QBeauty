//
//  HXRecordDetailTableViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRecordDetailTableViewCell.h"

@implementation HXRecordDetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier comonBool:(BOOL)comonBool{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (comonBool) {
            [self creatViewFirView];
        }else {
            [self creatViewSecondView];
        }
    }
    
    return self;
}
-(void)creatViewFirView {
  
    
    
    
}
-(void)creatViewSecondView {
    
    
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
