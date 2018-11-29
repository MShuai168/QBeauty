//
//  HXEvaluateCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXEvaluateCell.h"
@interface HXEvaluateCell()
@property (nonatomic,strong) UIImageView * photoImage; //icon;
@property (nonatomic,strong)UILabel * dateLabel;
@end
@implementation HXEvaluateCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)creatView {
    [super creatView];
    /**
     *  icon
     */
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    //    photoImage.backgroundColor = [UIColor blackColor];
    [photoImage setImage:[UIImage imageNamed:@"listLogo"]];
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.height.and.width.mas_equalTo(60);
    }];
    
    /**
     *  标题
     */
    UILabel * nameLabel  = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = kUIColorFromRGB(0x333333);
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(25);
        make.left.equalTo(self.contentView).offset(85);
        make.right.equalTo(self.contentView).offset(-85);
        make.height.mas_lessThanOrEqualTo(16);
    }];
    
    
    UILabel * dateLabel = [[UILabel alloc] init];
    self.dateLabel = dateLabel;
    dateLabel.font = [UIFont systemFontOfSize:13];
    dateLabel.textColor = ComonCharColor;
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(13);
        make.right.equalTo(self.contentView).offset(-90);
    }];
    
    UIButton * selectBtn = [[UIButton alloc] init];
    self.selectBtn = selectBtn;
    [selectBtn setBackgroundColor:ComonBackColor];
    [selectBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.contentView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
}

-(void)setModel:(HXEvaluateModel *)model {
    
    self.nameLabel.text = model.merName.length!=0?model.merName:@"";
    self.dateLabel.text = model.updateDate.length?model.updateDate:@"";
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.url.length!=0?model.url:@""] placeholderImage:[UIImage imageNamed:@"listLogo"]];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
