
//
//  HXMyPointsCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyPointsCell.h"

@implementation HXMyPointsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            }
    
    return self;
}
-(void)creatView {
    [super creatView];
    
    /**
     *  标题
     */
    UILabel * nameLabel  = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = ComonTextColor;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-100);
        make.height.mas_lessThanOrEqualTo(15);
    }];
    
    UILabel * dateLabel  = [[UILabel alloc] init];
    self.dateLabel = dateLabel;
    dateLabel.font = [UIFont systemFontOfSize:12];
    dateLabel.textColor = ComonCharColor;
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(30);
        make.width.mas_lessThanOrEqualTo(100);
        make.height.mas_lessThanOrEqualTo(14);
    }];
    
    UILabel * archivePointLabel = [[UILabel alloc] init];
    self.archivePointLabel = archivePointLabel;
    archivePointLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    [self.contentView addSubview:archivePointLabel];
    [archivePointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-35/2);
        make.centerY.equalTo(self.contentView);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    
}
-(void)setModel:(HXScoreRecordsModel *)model {
    
    self.archivePointLabel.text = model.score.length!=0?[model.modifyType boolValue]?[NSString stringWithFormat:@"+%@",model.score]:model.score:@"";
    self.archivePointLabel.textColor = [model.modifyType boolValue]?kUIColorFromRGB(0xFF8730):ComonTextColor;
    self.nameLabel.text = model.taskName.length!=0?model.taskName:@"";
    self.dateLabel.text = model.scoreTime.length!=0?model.scoreTime:@"";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
