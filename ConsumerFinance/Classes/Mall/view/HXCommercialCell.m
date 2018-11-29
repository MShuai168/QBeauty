//
//  HXCommercialCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/28.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXCommercialCell.h"
#import "HXStarView.h"
@interface HXCommercialCell ()
@property (nonatomic,strong)HXStarView * starView;
@end
@implementation HXCommercialCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    _starView = [[HXStarView alloc] init];
    [self.contentView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel.mas_left).offset(0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(12);
    }];
    /**
     *  距离
     */
    UILabel * distanceLabel = [[UILabel alloc] init];
    distanceLabel.font = [UIFont systemFontOfSize:11];
    distanceLabel.textColor = kUIColorFromRGB(0x999999);
    self.distanceLabel = distanceLabel;
    [self.contentView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_starView);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(11);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    [self.paymontLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_starView.mas_bottom).offset(10.5);
        make.left.equalTo(self.contentView).offset(115);
        make.height.mas_lessThanOrEqualTo(35);
    }];
    self.orderLabel.hidden =  NO;
    
}
-(void)setModel:(DtoListModel *)model {
    
    self.nameLabel.text = model.title ?model.title:@"";
    self.starView.star = [model.star doubleValue];
     [self.starView layoutSubviews];
    int moeny = model.minPrice?[model.minPrice intValue] :0;
    [Helper adjustLabel:self.moneyLabel str:[NSString stringWithFormat:@"%d",moeny] font:16];
    self.orderLabel.text =[NSString stringWithFormat:@"%@预约",model.reservationNum ?model.reservationNum:@"0"];
    if ([model.distance floatValue]/1000>=99) {
        self.distanceLabel.text = @">99km";
    }else {
    self.distanceLabel.text = [NSString stringWithFormat:@"%@km",model.distance ?[NumAgent roundDown:[NSString stringWithFormat:@"%f",[model.distance floatValue]/1000] ifKeep:YES] :@"0"];
    }
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:120 height:120]] placeholderImage:[UIImage imageNamed:@"listLogo"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image) {
//            self.photoImage.image =   [self cutImage:image];
        }
    }];
}
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (self.photoImage.size.width / self.photoImage.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * self.photoImage.size.height / self.photoImage.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * self.photoImage.size.width / self.photoImage.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
