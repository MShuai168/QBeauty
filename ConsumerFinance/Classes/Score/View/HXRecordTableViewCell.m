//
//  HXRecordTableViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/21.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRecordTableViewCell.h"
@interface HXRecordTableViewCell()
@property (nonatomic,strong)UIButton * sureBtn;
@property (nonatomic,strong)UILabel * stateLabel;
@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * informationLabel;
@property (nonatomic,strong)UILabel * hjLimitLabel;
@property (nonatomic,strong)HXRecordModel * recordModel;
@end
@implementation HXRecordTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    
    return self;
}
-(void)creatView {
    [super creatView];
    UILabel * stateLabel = [[UILabel alloc] init];
    self.stateLabel = stateLabel;
//    stateLabel.text =@"待支付";
    stateLabel.textColor = ComonBackColor;
    stateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.contentView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.contentView).offset(-12);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor  = kUIColorFromRGB(0xE6E6E6);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(40);
        make.right.and.left.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = kUIColorFromRGB(0xFAFAFA);
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(86);
        
    }];
    
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
//    photoImage.layer.cornerRadius = 6;
//    photoImage.layer.masksToBounds = YES;
    self.photoImage.layer.borderWidth = 0.5;
    self.photoImage.layer.borderColor = kUIColorFromRGB(0xE5E5E5).CGColor;
    [backView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(12);
        make.top.equalTo(backView).offset(8);
        make.height.mas_equalTo(70);
        make.width.mas_equalTo(70);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    titleLabel.textColor = ComonTextColor;
    titleLabel.numberOfLines = 0;
    [backView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(90);
        make.right.equalTo(backView).offset(-12);
        make.top.equalTo(backView).offset(12);
        make.height.mas_lessThanOrEqualTo(40);
    }];
    
    UILabel * informationLabel = [[UILabel alloc] init];
    self.informationLabel = informationLabel;
    informationLabel.textColor = kUIColorFromRGB(0x3F3F3F);
    informationLabel.font = [UIFont systemFontOfSize:11];
    [backView addSubview:informationLabel];
    [informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(90);
        make.right.equalTo(backView).offset(-12);
        make.top.equalTo(backView).offset(60);
        make.height.mas_equalTo(16);
    }];
    UIView * seclineView = [[UIView alloc] init];
    seclineView.backgroundColor  = kUIColorFromRGB(0xE6E6E6);
    [self.contentView addSubview:seclineView];
    [seclineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(0);
        make.right.and.left.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel * hjLabel = [[UILabel alloc] init];
    hjLabel.text = @"合计:";
    hjLabel.font = [UIFont systemFontOfSize:14];
    hjLabel.textColor = ComonTextColor;
    [self.contentView addSubview:hjLabel];
    [hjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.top.equalTo(backView.mas_bottom).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    
    UILabel * hjLimitLabel = [[UILabel alloc] init];
    self.hjLimitLabel = hjLimitLabel;
    hjLimitLabel.textColor = kUIColorFromRGB(0x3F3F3F);
    hjLimitLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:hjLimitLabel];
    [hjLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(47);
        make.right.equalTo(self.contentView).offset(-120);
        make.top.equalTo(backView.mas_bottom).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    UIButton * sureBtn = [[UIButton alloc] init];
    self.sureBtn = sureBtn;
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = [kUIColorFromRGB(0xFA5555) colorWithAlphaComponent:0.1];
    sureBtn.layer.borderColor = ComonBackColor.CGColor;
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sureBtn setTitleColor:ComonBackColor forState:UIControlStateNormal];
    sureBtn.layer.borderWidth = 0.5;
    [sureBtn setTitle:@"去支付" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 3;
    [self.contentView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(hjLabel);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(88);
    }];
}
-(void)setModel:(HXRecordModel *)model {
    self.recordModel = model;
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:140 height:140]] placeholderImage:[UIImage imageNamed:@"listLogo"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.proName.length!=0?model.proName:@"",model.specOne.length!=0?[NSString stringWithFormat:@" %@",model.specOne]:@"",model.specTwo.length!=0?[NSString stringWithFormat:@" %@",model.specTwo]:@"",model.specThree.length!=0?[NSString stringWithFormat:@" %@",model.specThree]:@""];
    int jfScore = [model.skuScore intValue]>0?[model.skuScore intValue]:0;
    self.informationLabel.text = [NSString stringWithFormat:@"%d趣贝+%@元",jfScore,model.skuPrice.length!=0?model.skuPrice:@"0.00"];
    [Helper changeTextWithFont:16 title:self.informationLabel.text changeTextArr:@[[NSString stringWithFormat:@"%d",jfScore],model.skuPrice.length!=0?model.skuPrice:@"0.00"] label:self.informationLabel color:ComonCharColor];
    
    model.totalScore = model.totalScore.length!=0?model.totalScore:@"0";
    model.totalAmount = model.totalAmount.length!=0?[NumAgent roundDown:model.totalAmount ifKeep:YES]:@"0";

    self.hjLimitLabel.text = [NSString stringWithFormat:@"%d趣贝+¥%@",[model.totalScore intValue],model.totalAmount];
    [Helper changeTextWithFont:16 title:self.hjLimitLabel.text changeTextArr:@[[NSString stringWithFormat:@"%d",[model.totalScore intValue]],model.totalAmount] label:self.hjLimitLabel color:ComonBackColor];

    if ([model.orderStatus intValue]==1) {
        [self changeStates:ShopStatesWait];
    }else if ([model.orderStatus intValue]==2) {
        [self changeStates:ShopStatesWait];
    }else if ([model.orderStatus intValue]==3) {
       [self changeStates:ShopStatesWaitArchive];
    }else if ([model.orderStatus intValue]==4) {
        [self changeStates:ShopStatesWaitArchive];
    }else if ([model.orderStatus intValue]==5) {
        [self changeStates:ShopStatesSuccess];
    }else if ([model.orderStatus intValue]==6) {
        [self changeStates:ShopStatesCancel];
        
    }else {
        [self changeStates:ShopStatesAll];
    }
    
}
-(void)changeStates:(ShopStates)states {
    switch (states) {
        case ShopStatesAll: {
            self.stateLabel.hidden = YES;
            self.sureBtn.hidden = YES;
        }
            break;
        case ShopStatesWait: {
            if ([self.recordModel.orderStatus intValue]==1) {
                
                self.stateLabel.text = @"待支付";
                [self.sureBtn setTitle:@"去支付" forState:UIControlStateNormal];
                self.sureBtn.hidden = NO;
            }else {
                self.sureBtn.hidden = YES;
                self.stateLabel.text = @"处理中";
            }
            self.stateLabel.textColor = ComonBackColor;
        }
            break;
        case ShopStatesWaitArchive:{
            if ([self.recordModel.orderStatus intValue]==3) {
                self.stateLabel.text = @"待发货";
                self.sureBtn.hidden = YES;
            }else {
                self.stateLabel.text = @"已发货";
                [self.sureBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                self.sureBtn.hidden = NO;
            }
            self.stateLabel.textColor = ComonBackColor;
        }
            break;
        case ShopStatesSuccess: {
            self.stateLabel.text = @"已完成";
            self.stateLabel.textColor = ComonCharColor;
            self.sureBtn.hidden = YES;
        }
            break;
        case ShopStatesCancel: {
            self.stateLabel.text = @"已取消";
            self.stateLabel.textColor = ComonCharColor;
            self.sureBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
}

-(void)sureBtnAction {
    if ([self.delegate respondsToSelector:@selector(changeRecordData:)]) {
        [self.delegate changeRecordData:self.recordModel];
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
