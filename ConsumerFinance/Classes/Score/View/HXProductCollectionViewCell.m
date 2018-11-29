//
//  HXProductCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXProductCollectionViewCell.h"
#import "StrikeThroughLabel.h"
#import "ComButton.h"
@interface HXProductCollectionViewCell()
@property (nonatomic,strong)ComButton * shopBtn;
@property (nonatomic,strong)UILabel * stockLabel;
@property (nonatomic,strong)HXShopCarModel * recomenModel;
@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * informationLabel;
@property (nonatomic,strong)StrikeThroughLabel * priceLabel;
@end
@implementation HXProductCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
    }
    return self;
}
-(void)creatUI {
    
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.right.and.left.equalTo(self.contentView);
        make.height.mas_equalTo(self.frame.size.width);
    }];
    

    UILabel * titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    titleLabel.textColor = kUIColorFromRGB(0x555555);
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(-8);
        make.top.equalTo(photoImage.mas_bottom).offset(10);
        make.height.mas_equalTo(48);
    }];
    
    UILabel * informationLabel = [[UILabel alloc] init];
    self.informationLabel = informationLabel;
    informationLabel.font = [UIFont systemFontOfSize:11];
    informationLabel.textColor = kUIColorFromRGB(0x252525);
    [self.contentView addSubview:informationLabel];
    [informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(-8);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(16);
    }];
    
//    UILabel * sclabel = [[UILabel alloc] init];
//    sclabel.font = [UIFont systemFontOfSize:11];
//    sclabel.text = @"市场价:";
//    sclabel.textColor = ComonCharColor;
//    [self.contentView addSubview:sclabel];
//    [sclabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(8);
//        make.top.equalTo(informationLabel.mas_bottom).offset(10);
//        make.height.mas_equalTo(11);
//    }];
    
    StrikeThroughLabel * priceLabel = [[StrikeThroughLabel alloc] init];
    self.priceLabel = priceLabel;
    priceLabel.strikeThroughEnabled = YES;
    priceLabel.font = [UIFont systemFontOfSize:11];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.textColor = ComonCharColor;
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.top.equalTo(informationLabel.mas_bottom).offset(10);
        make.width.mas_lessThanOrEqualTo(self.contentView.frame.size.width-50);
    }];
    
    
    UILabel * stockLabel = [[UILabel alloc] init];
    self.stockLabel = stockLabel;
    stockLabel.font = [UIFont systemFontOfSize:11];
    stockLabel.textColor = ComonCharColor;
    [self.contentView addSubview:stockLabel];
    if (SCREEN_WIDTH<=320) {
        [priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(informationLabel.mas_bottom).offset(6);
            make.width.mas_lessThanOrEqualTo(self.contentView.frame.size.width-50);
        }];
        
        [stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceLabel.mas_bottom).offset(2);
            make.left.equalTo(self.contentView).offset(8);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-20);
        }];
    }else {
        
        [stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(priceLabel);
            make.right.equalTo(self.contentView).offset(-8);
            make.width.mas_lessThanOrEqualTo(65);
        }];
        
    }
    
    ComButton * shopBtn = [[ComButton alloc] init];
    self.shopBtn = shopBtn;
    self.shopBtn.hidden = YES;
    [shopBtn addTarget:self action:@selector(shopBtnAction) forControlEvents:UIControlEventTouchUpInside];
    shopBtn.photoImage.image = [UIImage imageNamed:@"cartsimple1"];
    [self.contentView addSubview:shopBtn];
    [shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(informationLabel.mas_bottom).offset(2);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(50);
    }];
    [shopBtn.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopBtn);
        make.right.equalTo(shopBtn).offset(-8);
    }];
    
}
-(void)setShoopBool:(BOOL)shoopBool {
    if (shoopBool) {
        self.shopBtn.hidden = NO;
        self.stockLabel.hidden = YES;
        [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(self.contentView.frame.size.width-50);
        }];
    }else {
        self.shopBtn.hidden = YES;
        self.stockLabel.hidden = NO;
        if (SCREEN_WIDTH<=320) {
            [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_lessThanOrEqualTo(self.contentView.frame.size.width-60);
            }];
            
        }
        
    }
}
-(void)setModel:(HXShopCarModel *)model {
    self.recomenModel  =  model;
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:self.frame.size.width*2 height:self.frame.size.width*2]] placeholderImage:[UIImage imageNamed:@"listLogo"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.proName.length!=0?model.proName:@"",model.specOne.length!=0?[NSString stringWithFormat:@" %@",model.specOne]:@"",model.specTwo.length!=0?[NSString stringWithFormat:@" %@",model.specTwo]:@"",model.specThree.length!=0?[NSString stringWithFormat:@" %@",model.specThree]:@""];
    NSInteger fontNumber = SCREEN_WIDTH<=320?12:16;
    
    model.score = model.score.length!=0?model.score:@"0";
    model.price = model.price.length!=0?[NumAgent roundDown:model.price ifKeep:YES]:@"0.00";
    self.informationLabel.text = [NSString stringWithFormat:@"%d趣贝+¥%@",[model.score intValue],model.price];
    _informationLabel.textColor = kUIColorFromRGB(0x252525);
    [Helper changeTextWithFont:fontNumber title:self.informationLabel.text changeTextArr:@[[NSString stringWithFormat:@"%d",[model.score intValue]],model.price] label:self.informationLabel color:ComonBackColor];
    self.priceLabel.text = [NumAgent fomateNum:[NSString stringWithFormat:@"¥%@",model.markPrice.length!=0?model.markPrice:@"0"]];
    
    self.stockLabel.text = [NSString stringWithFormat:@"库存: %d",model.stock.length!=0?[model.stock intValue]:0];
}

-(void)shopBtnAction {
    
    if ([self.delegate respondsToSelector:@selector(changeShopCart:)]) {
        [self.delegate changeShopCart:self.recomenModel];
    }
}
@end
