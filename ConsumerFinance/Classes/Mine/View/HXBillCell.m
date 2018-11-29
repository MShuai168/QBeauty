//
//  HXBillCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/17.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBillCell.h"
@interface HXBillCell()
@property (nonatomic,strong)UILabel *  periodLabel;
@property (nonatomic,strong)UILabel * repaymentLabel;
@property (nonatomic,strong)UILabel * moneyLabel;
@property (nonatomic,strong)UILabel * statesLabel;
@end
@implementation HXBillCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    /**
     *  分期
     */
    UILabel *  periodLabel = [[UILabel alloc] init];
    self.periodLabel = periodLabel;
    periodLabel.font = [UIFont systemFontOfSize:16];
    periodLabel.textColor = kUIColorFromRGB(0x999999);
    [self.contentView addSubview:periodLabel];
    [periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_lessThanOrEqualTo(60);
        make.centerY.equalTo(self.contentView);
    }];
    /**
     *  名称
     */
    UILabel * nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = ComonTextColor;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.periodLabel.mas_right).offset(15);
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-100);
    }];
    /**
     *  还款日
     */
    UILabel * repaymentLabel =[[UILabel alloc] init];
    self.repaymentLabel = repaymentLabel;
    repaymentLabel.font = [UIFont systemFontOfSize:11];
    repaymentLabel.textColor = ComonCharColor;
    [self.contentView addSubview:repaymentLabel];
    [repaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.periodLabel.mas_right).offset(15);
        make.top.equalTo(self.contentView).offset(45);
    }];
    /**
     *  金额
     */
    UILabel * moneyLabel = [[UILabel alloc] init];
    self.moneyLabel = moneyLabel;
    moneyLabel.font = [UIFont systemFontOfSize:11];
    moneyLabel.textColor = kUIColorFromRGB(0xE6BF73);
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(22);
    }];
    /**
     *  状态
     */
    UILabel * statesLabel  = [[UILabel alloc] init];
    self.statesLabel = statesLabel;
    statesLabel.font = [UIFont systemFontOfSize:12];
    statesLabel.textColor = ComonBackColor;
    [self.contentView addSubview:statesLabel];
    [statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(42);
    }];
}
-(void)setModel:(HXBillModel *)model {
    self.periodLabel.text = model.currentPeriods?model.currentPeriods:@"";
    self.nameLabel.text = model.name?model.name:@"";
    self.repaymentLabel.text = model.refundDate.length!=0?[NSString stringWithFormat:@"还款日：%@",model.refundDate]:@"";
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.money?model.money:@"0.00"];
    self.statesLabel.text = model.detail?model.detail:@"";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
