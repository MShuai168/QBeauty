//
//  HXRepaymentCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRepaymentCell.h"
@interface HXRepaymentCell()
@property (nonatomic,strong)UILabel * moneyLabel;
@property (nonatomic,strong)UILabel * statesLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@end
@implementation HXRepaymentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)creatView {
    [super creatView];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.bottom.equalTo(self);
    }];
    
    UILabel * rmbLable = [[UILabel alloc] init];
    rmbLable.font = [UIFont systemFontOfSize:16];
    rmbLable.textColor = kUIColorFromRGB(0xE6BF73);
    [self.contentView addSubview:rmbLable];
    rmbLable.text = @"¥";
    [self.contentView addSubview:rmbLable];
    [rmbLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(29);
    }];
    
    UILabel * moneyLabel = [[UILabel alloc] init];
    self.moneyLabel = moneyLabel;
    moneyLabel.font = [UIFont systemFontOfSize:25];
    moneyLabel.textColor = kUIColorFromRGB(0xE6BF73);
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rmbLable.mas_right).offset(5);
        make.top.equalTo(self.contentView).offset(20);
    }];
    
    
    UILabel * statesLabel = [[UILabel alloc] init];
    self.statesLabel = statesLabel;
    statesLabel.font = [UIFont systemFontOfSize:13];
    statesLabel.textColor = kUIColorFromRGB(0x4A90E2);
    [self.contentView addSubview:statesLabel];
    [statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    UIImageView * sureImage = [[UIImageView alloc] init];
    sureImage.image  = [UIImage imageNamed:@"agree_icon"];
    [self.contentView addSubview:sureImage];
    
    [sureImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyLabel);
        make.right.equalTo(statesLabel.mas_left).offset(-5);
        make.width.and.height.mas_equalTo(13);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(65);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    UILabel * repayTime = [[UILabel alloc] init];
    repayTime.font = [UIFont systemFontOfSize:13];
    repayTime.textColor = ComonCharColor;
    repayTime.text = @"还款时间";
    [self.contentView addSubview:repayTime];
    [repayTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    UILabel * timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = ComonCharColor;
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(repayTime);
    }];
    
}

-(void)setModel:(HXRepaymentModel *)model {
    
    self.moneyLabel.text = model.tradeAmount?model.tradeAmount:@"";
    self.statesLabel.text = [model.refundStatus isEqualToString:@"0"]?@"还款失败":@"还款成功";
    
    self.timeLabel.text = model.createdAt?model.createdAt:@"";
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
