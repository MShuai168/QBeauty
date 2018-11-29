//
//  HXBankListCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/21.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBankListCell.h"
@interface HXBankListCell()
@property (nonatomic,strong)UILabel * bankName;
@property (nonatomic,strong)UILabel * kindLabel;
@property (nonatomic,strong)UILabel * bankNumberLabel;
@property (nonatomic,strong)UILabel * numberLabel;
@property (nonatomic,strong)UILabel * tagLabel;
@property (nonatomic,strong)UIImageView * backImage;
@property (nonatomic,strong)UIImageView * headImage;
@end
@implementation HXBankListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = COLOR_BACKGROUND;
        
        
    }
    return self;
    
}
-(void)creatView {
    
    [super creatView];
    UIImageView * backImage = [[UIImageView alloc] init];
    self.backImage = backImage;
    [self.contentView addSubview:backImage];
    backImage.layer.cornerRadius = 10;
    backImage.layer.masksToBounds = YES;
    [self.contentView addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
    }];
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    bottomView.layer.cornerRadius = 20;
    bottomView.layer.masksToBounds = YES;
    [backImage addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImage).mas_offset(15);
        make.left.equalTo(backImage).mas_offset(20);
        make.width.and.height.mas_equalTo(40);
    }];
    
    UIImageView * headImage = [[UIImageView alloc] init];
    self.headImage = headImage;
//    [headImage setImage:[UIImage imageNamed:@"gongshang"]];
    [bottomView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(bottomView);
    }];
    
    
    UILabel * bankName = [[UILabel alloc] init];
    self.bankName = bankName;
    bankName.font = [UIFont fontWithName:@".PingFangSC-Regular" size:15];
    [bankName setTextColor:[kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.8]];
    [backImage addSubview:bankName];
    [bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImage).offset(80);
        make.top.equalTo(backImage).offset(20);
        
    }];
    
    self.tagLabel = [[UILabel alloc] init];
    self.tagLabel.text = @"默认卡";
    self.tagLabel.font = [UIFont systemFontOfSize:12];
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-15 * (CGFloat)M_PI / 180), 1, 0, 0);
    self.tagLabel.transform = matrix;
    [self.tagLabel setTextColor:[kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.8]];
    [backImage addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankName);
        make.right.equalTo(backImage).offset(-15);
    }];
    
    UILabel * kindLabel = [[UILabel alloc] init];
    self.kindLabel = kindLabel;
    kindLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:12];
    [kindLabel setTextColor:[kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.8]];
    [backImage addSubview:kindLabel];
    [kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImage).offset(80);
        make.top.equalTo(backImage).offset(40);
        
    }];
    
    UILabel * bankNumberLabel = [[UILabel alloc] init];
    self.bankNumberLabel = bankNumberLabel;
    bankNumberLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:20];
    [bankNumberLabel setTextColor:[kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.8]];
    [backImage addSubview:bankNumberLabel];
    [bankNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backImage).offset(-20);
        make.top.equalTo(backImage).offset(65);
        
    }];
    UILabel * numberLabel = [[UILabel alloc] init];
    self.numberLabel = numberLabel;
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.textColor = [kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.4];
    [backImage addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImage).offset(23);
        make.right.equalTo(backImage).offset(-20);
    }];
    
    
    for (int i = 0; i<12; i++) {
    UIView * dianView = [[UIView alloc] init];
    dianView.backgroundColor = [kUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.8];
    dianView.layer.cornerRadius = 2.5;
    [backImage addSubview:dianView];
    int group = i/4;
    [dianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImage).offset(80+i*10+group*((SCREEN_WIDTH - 290)/3));
        make.centerY.equalTo(bankNumberLabel);
        make.height.and.width.mas_equalTo(5);
        
    }];
//    105 95 35 47
    }

}

-(void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in self.subviews){
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]){
            //添加图片
            UIButton* deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteBtn.frame = subView.bounds;
            [deleteBtn addTarget:self action:@selector(delegateBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [deleteBtn setImage:[UIImage imageNamed:@"cellDelete"] forState:UIControlStateNormal];
            deleteBtn.backgroundColor = COLOR_BACKGROUND;
            [subView addSubview:deleteBtn];
            break;
        }
    }
}

-(void)setModel:(HXBankListModel *)model {
    
    self.bankName.text = model.bankName?model.bankName:@"";
    if (model.cardType.length!=0) {
        self.kindLabel.text = [model.cardType isEqualToString:@"1"]?@"储蓄卡":@"信用卡";
    }
    self.tagLabel.hidden = ![model.isdefault isEqualToString:@"1"];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.bankIcon]];
    if (model.cardNo.length>=4) {
     NSString * bank = [model.cardNo substringFromIndex:model.cardNo.length-4];
        self.bankNumberLabel.text = bank ;
    }
    if ([model.bankColour isEqualToString:@"1"]) {
        self.backImage.image = [UIImage imageNamed:@"bankBack3"];
    }else if ([model.bankColour isEqualToString:@"2"]){
        self.backImage.image = [UIImage imageNamed:@"bankBack1"];
    }else {
        self.backImage.image = [UIImage imageNamed:@"bankBack2"];
    }
    
}

-(void)delegateBtnAction {
    if (self.delegate) {
        [self.delegate delegateCell:self.index];
    }
}

@end
