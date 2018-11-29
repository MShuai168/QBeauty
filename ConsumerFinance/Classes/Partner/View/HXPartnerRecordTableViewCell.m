//
//  HXPartnerRecordTableViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerRecordTableViewCell.h"

@implementation HXPartnerRecordTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    
    UILabel * moneyLabel = [[UILabel alloc] init];
    self.moneyLabel = moneyLabel;
    moneyLabel.textColor = ComonTextColor;
    moneyLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(0);
    }];
    
    UILabel * nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = ComonTextColor;
    self.nameLabel = nameLabel;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-150);
    }];
    
    UILabel * dateLabel = [[UILabel alloc] init];
    self.dateLabel = dateLabel;
    dateLabel.font = [UIFont systemFontOfSize:13];
    dateLabel.textColor = ComonCharColor;
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(44);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    UILabel * stateLabel = [[UILabel alloc] init];
    self.stateLabel = stateLabel;
    stateLabel.font = [UIFont systemFontOfSize:13];
    stateLabel.textColor = ComonCharColor;
    [self.contentView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(44);
        make.right.equalTo(self.contentView).offset(0);
    }];

}
-(void)setModel:(HXBuyRecordModel *)model {
    self.nameLabel.text = model.packageName.length!=0?model.packageName:@"";
    self.dateLabel.text = model.createTime.length!=0?model.createTime:@"";
    self.moneyLabel.text = model.orderPrice.length!=0?[NumAgent roundDown:model.orderPrice ifKeep:YES]:@"0.00";
    self.stateLabel.text = [ProfileManager getBuyRecordStateWithString:model.orderStatus];
}
-(void)setIncomeModel:(HXBuyRecordModel *)incomeModel {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSString * iphoneStr;
//    if (incomeModel.cellphone.length>8) {
//        iphoneStr = [NSString stringWithFormat:@" (%@)",[incomeModel.cellphone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
//    }else {
//        if (incomeModel.cellphone.length!=0) {
//            iphoneStr = [NSString stringWithFormat:@" %@",incomeModel.cellphone];
//        }
//    }
//    self.nameLabel.text = [NSString stringWithFormat:@"%@%@",incomeModel.name.length!=0?incomeModel.name:@"",iphoneStr.length!=0?iphoneStr:@""];
    self.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",incomeModel.name.length!=0?incomeModel.name:@"",incomeModel.cellphone.length!=0?incomeModel.cellphone:@""];
    
    self.dateLabel.text = incomeModel.createTime.length!=0?incomeModel.createTime:@"";
    float num = [incomeModel.accountAmount floatValue];
    if (num > 0) {
        self.moneyLabel.text = [NSString stringWithFormat:@"+%@",incomeModel.accountAmount.length!=0?[NumAgent roundDown:incomeModel.accountAmount ifKeep:YES]:@"0.00"];
    } else {
        self.moneyLabel.text = [NSString stringWithFormat:@"%@",incomeModel.accountAmount.length!=0?[NumAgent roundDown:incomeModel.accountAmount ifKeep:YES]:@"0.00"];
    }
}
-(void)setWithdrawModel:(HXBuyRecordModel *)withdrawModel {
     self.nameLabel.text = withdrawModel.name.length!=0?withdrawModel.name:@"";
    self.dateLabel.text = withdrawModel.createTime.length!=0?withdrawModel.createTime:@"";
    self.moneyLabel.text = [NSString stringWithFormat:@"-%@",withdrawModel.applyMoney.length!=0?[NumAgent roundDown:withdrawModel.applyMoney ifKeep:YES]:@"0.00"];
    self.stateLabel.text = [ProfileManager getWithdrawStateWithString:withdrawModel.type];
    if ([withdrawModel.type isEqualToString:@"4"]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
     self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [self.moneyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.contentView).offset(0);
        }];
        [self.stateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(0);
        }];
    }else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType=UITableViewCellAccessoryNone;
        [self.moneyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
        }];
        [self.stateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
        }];
    }
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
