//
//  BeautyClinicCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BeautyClinicCell.h"
#import "HXStarView.h"
@interface BeautyClinicCell()
@property (nonatomic,strong)UILabel * addressLabel;
@end
@implementation BeautyClinicCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    [self.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(85);
    }];
    /**
     *  地址
     */
    UILabel * addressLabel = [[UILabel alloc] init];
    self.addressLabel = addressLabel;
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.textColor = kUIColorFromRGB(0x999999);
    addressLabel.text = @"上海市虹口区丰同路637号上海市虹口区";
    addressLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(115);
        make.right.equalTo(self.contentView.mas_right).offset(-50);
        make.height.mas_equalTo(12);
    }];
}
-(void)setModel:(DtoListModel *)model {
    
    self.nameLabel.text = model.title ?model.title:@"";
    self.addressLabel.text = model.detail ? model.detail :@"";
    int moeny = model.minPrice?[model.minPrice intValue] :0;
    [Helper adjustLabel:self.moneyLabel str:[NSString stringWithFormat:@"%d",moeny] font:16];
    self.orderLabel.text = model.reservationNum ? [NSString stringWithFormat:@"%@预约",model.reservationNum] :@"0预约";
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:170 height:170]] placeholderImage:[UIImage imageNamed:@"listLogo"] options:SDWebImageAllowInvalidSSLCertificates];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
