//
//  HXBillingdetailsCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/16.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBillingdetailsCell.h"
@interface HXBillingdetailsCell()
@property (nonatomic,strong)UILabel * periodLabel;
@property (nonatomic,strong)UILabel * moneyLabel;
@property (nonatomic,strong)UILabel * statesLabel;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)UILabel * punishLabel;
@end
@implementation HXBillingdetailsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    UIButton * photoImage = [[UIButton alloc] init];
    [photoImage addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    self.photoImage =photoImage;
    photoImage.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    photoImage.layer.cornerRadius= 10;
    photoImage.layer.masksToBounds = YES;
    [self.contentView addSubview:photoImage];
    
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(15);
        make.height.and.width.mas_equalTo(20);
    }];
    
    UIView * topLine = [[UIView alloc] init];
    self.topLine = topLine;
    topLine.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(photoImage.mas_top).offset(0);
        make.width.mas_equalTo(1);
        make.centerX.equalTo(photoImage);
        make.top.equalTo(self.contentView);
    }];
    
    UIView * botLine = [[UIView alloc] init];
    self.botLine = botLine;
    botLine.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    [self.contentView addSubview:botLine];
    [botLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(1);
        make.centerX.equalTo(photoImage);
        make.top.equalTo(photoImage.mas_bottom).offset(0);
    }];
   
    /**
     *  分期
     */
    UILabel * periodLabel = [[UILabel alloc] init];
    self.periodLabel = periodLabel;
    periodLabel.font = [UIFont systemFontOfSize:14];
    periodLabel.textColor = kUIColorFromRGB(0x666666);
    [self.contentView addSubview:periodLabel];
    [periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(50);
        make.top.equalTo(self.contentView).mas_offset(23);
    }];
    
    /**
     *  金额
     */
    UILabel * moneyLabel = [[UILabel alloc] init];
    self.moneyLabel = moneyLabel;
    moneyLabel.font = [UIFont systemFontOfSize:18];
    moneyLabel.textColor = kUIColorFromRGB(0xE6BF73);
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(21);
    }];
    
    /**
     *  状态
     */
    UILabel * statesLabel = [[UILabel alloc] init];
    self.statesLabel = statesLabel;
    statesLabel.font = [UIFont systemFontOfSize:14];
    statesLabel.textColor = ComonCharColor;
    [self.contentView addSubview:statesLabel];
    [statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(23);
    }];
    /**
     *  日期
     */
    UILabel * dateLabel = [[UILabel alloc] init];
    self.dateLabel = dateLabel;
    dateLabel.font = [UIFont systemFontOfSize:11];
    dateLabel.textColor = kUIColorFromRGB(0x929292);
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(45);
        make.left.equalTo(self.contentView).offset(50);
    }];
    
    /**
     *  罚息
     */
    UILabel * punishLabel = [[UILabel alloc] init];
    self.punishLabel = punishLabel;
    punishLabel.font = [UIFont systemFontOfSize:11];
    punishLabel.textColor = ComonBackColor;
    [self.contentView addSubview:punishLabel];
    [punishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-14);
        make.top.equalTo(self.contentView).offset(45);
    }];
}
-(void)setModel:(HXBillDetailsModel *)model {
    if ([model.canChoose boolValue]) {
        self.photoImage.userInteractionEnabled = YES;
    }else {
        self.photoImage.userInteractionEnabled = NO;
    }
    if (![model.isChooosed boolValue]) {
        if (!model.haveSelect) {
            if ([model.canChoose boolValue]) {
                [self.photoImage setBackgroundImage:[UIImage imageNamed:@"Optional"] forState:UIControlStateNormal];
                self.photoImage.backgroundColor = kUIColorFromRGB(0xffffff);
                if (!model.firstSelect) {
                    [self.photoImage setBackgroundImage:nil forState:UIControlStateNormal];
                    self.photoImage.backgroundColor = kUIColorFromRGB(0xE6E6E6);
                    self.photoImage.enabled =NO;
                }
                
            }else {
                [self.photoImage setBackgroundImage:nil forState:UIControlStateNormal];
                self.photoImage.backgroundColor = kUIColorFromRGB(0xE6E6E6);
            }
            
        }else {
            
        [self.photoImage setBackgroundImage:[UIImage imageNamed:@"orderCheckedStaging"] forState:UIControlStateNormal];
            
        }
        self.photoImage.hidden = NO;
    }else {
        //已经还款 model.isChooosed 为1 灰色小钩
        [self.photoImage setBackgroundImage:[UIImage imageNamed:@"orderSc"] forState:UIControlStateNormal];
        self.photoImage.userInteractionEnabled = NO;
    }
    self.periodLabel.text = model.name?model.name:@"";
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.money?model.money:@"0.00"];
    self.statesLabel.text = model.statusName?model.statusName:@"";
    self.dateLabel.text = model.refundDate?[NSString stringWithFormat:@"还款日:%@",model.refundDate]:@"";
    self.punishLabel.text = model.detail?model.detail:@"";
    
    
}
-(void)selectAction {
    
    if ([self.delegate respondsToSelector:@selector(selectAction:)]) {
        [self.delegate selectAction:self.index];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
