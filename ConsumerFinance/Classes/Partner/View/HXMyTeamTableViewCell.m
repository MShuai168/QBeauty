//
//  HXMyTeamTableViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/30.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyTeamTableViewCell.h"
@interface HXMyTeamTableViewCell()
@property (nonatomic,strong)UILabel * identyLabel;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)UILabel * levelLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@end
@implementation HXMyTeamTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    
    UILabel * nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = ComonTextColor;
//    nameLabel.text = @"张**（187****7654）";
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-80);
    }];
    
    UILabel * identyLabel = [[UILabel alloc] init];
    self.identyLabel  = identyLabel;
    identyLabel.font = [UIFont systemFontOfSize:13];
    identyLabel.textColor = ComonCharColor;
    [self.contentView addSubview:identyLabel];
    [identyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(48);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    UILabel * dateLabel = [[UILabel alloc] init];
    self.dateLabel = dateLabel;
    dateLabel.font = [UIFont systemFontOfSize:13];
    dateLabel.textColor = ComonCharColor;
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(69);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    UILabel * levelLabel = [[UILabel alloc] init];
    self.levelLabel = levelLabel;
    levelLabel.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.textColor = ComonCharColor;
    levelLabel.font = [UIFont systemFontOfSize:12];
    levelLabel.layer.cornerRadius = 10;
    levelLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:levelLabel];
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    UILabel * typeLabel = [[UILabel alloc] init];
    self.typeLabel = typeLabel;
    typeLabel.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    typeLabel.textAlignment = NSTextAlignmentCenter;
    typeLabel.textColor = ComonCharColor;
    typeLabel.font = [UIFont systemFontOfSize:12];
    typeLabel.layer.cornerRadius = 10;
    typeLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(55);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
}

-(void)setModel:(HXMyteamModel *)model {
//    NSString * name;
//    if (model.name.length>=2) {
//        NSString * str  =  [NSString stringWithFormat:@"%@", [model.name substringFromIndex:1]];
//        name = [NSString stringWithFormat:@"%@", [model.name substringToIndex:1]];
//        for (int i =0; i<str.length; i++) {
//            name = [NSString stringWithFormat:@"%@*",name];
//        }
//    }else {
//        name = model.name;
//    }
//    NSString * iphoneStr;
//    if (model.cellphone.length>8) {
//        iphoneStr = [NSString stringWithFormat:@" (%@)",[model.cellphone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
//    }else {
//        if (model.cellphone.length!=0) {
//            iphoneStr = [NSString stringWithFormat:@" %@",model.cellphone];
//        }
//    }
//    self.nameLabel.text = [NSString stringWithFormat:@"%@%@",name.length!=0?name:@"",iphoneStr.length!=0?iphoneStr:@""]; //隐藏姓名、手机号
    self.nameLabel.text = [NSString stringWithFormat:@"%@(%@)", model.name, model.cellphone];   //不隐藏姓名、手机号码
    
    self.identyLabel.text = [NSString stringWithFormat:@"身份：%@",model.partnerGradeName.length!=0?model.partnerGradeName:@""];
    NSString *dateString;
    if (model.gmtCreate.length!=0) {
        NSTimeInterval interval    =[model.gmtCreate doubleValue] / 1000.0;
        NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dateString       = [formatter stringFromDate: date];
    }
    
    self.dateLabel.text = [NSString stringWithFormat:@"加入时间：%@",dateString.length!=0?dateString:@""];
    self.levelLabel.text = [NSString stringWithFormat:@"%@",model.grade.length!=0?model.grade:@""];
    self.typeLabel.text = [NSString stringWithFormat:@"%@",model.type.length!=0?model.type:@""];
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
