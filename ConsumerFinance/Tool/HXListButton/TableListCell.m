//
//  TableListCell.m
//  demo
//
//  Created by Jney on 2016/11/9.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import "TableListCell.h"

@interface TableListCell ()
@property (nonatomic,strong) UILabel        *titleLabel;
@property (nonatomic,strong) UIImageView    *iconImage;
@end

@implementation TableListCell
@synthesize titleLabel, iconImage;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, self.frame.size.height)];
        titleLabel.textColor = ColorWithRGB(51, 51, 51);
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:titleLabel];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 40-0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = ColorWithRGB(221, 221, 221);
        [self.contentView addSubview:line];
        
        iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 12, (self.frame.size.height - 12)/2.0, 12, 12)];
        [self.contentView addSubview:iconImage];
    }
    return self;
}

-(void)setModel:(CellModel *)model{

    _model = model;
    titleLabel.text = model.titleStr;
    titleLabel.numberOfLines = 0;
    if (model.isChoose) {
        iconImage.image = [UIImage imageNamed:@"tick"];
    }else{
        iconImage.image = [UIImage imageNamed:@""];
    }
}

@end
