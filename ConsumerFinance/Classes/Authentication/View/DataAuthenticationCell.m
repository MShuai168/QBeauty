//
//  DataAuthenticationCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/10.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "DataAuthenticationCell.h"

@implementation DataAuthenticationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
    
}
-(void)creatView {

    /**
     *  状态
     */
    UILabel * stateLabel = [[UILabel alloc] init];
    self.stateLabel = stateLabel;
    stateLabel.font = [UIFont systemFontOfSize:14];
    stateLabel.textColor = ComonCharColor;
    [self.contentView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(0);
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
