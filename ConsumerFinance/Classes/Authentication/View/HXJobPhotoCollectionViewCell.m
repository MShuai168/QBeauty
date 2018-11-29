//
//  HXJobPhotoCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXJobPhotoCollectionViewCell.h"

@implementation HXJobPhotoCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
    }
    return self;
}
-(void)creatUI {
    UIImageView * photoImage  = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    photoImage.userInteractionEnabled = YES;
    photoImage.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    ComButton * deleteButton  = [[ComButton alloc] init];
    self.deleteButton = deleteButton;
    deleteButton.nameLabel.hidden = YES;
    [deleteButton.photoImage setImage:[UIImage imageNamed:@"photoDelete"]];
    [self.contentView addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(40);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
    }];
    [deleteButton.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(deleteButton.mas_right).offset(0);
        make.top.equalTo(deleteButton.mas_top).offset(0);
        make.width.and.height.mas_equalTo(20);
    }];
    
    UILabel * progressLabel = [[UILabel alloc] init];
    self.progressLabel = progressLabel;
    progressLabel.hidden = YES;
    progressLabel.textAlignment = NSTextAlignmentCenter;
    progressLabel.backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.5];
    [photoImage addSubview:progressLabel];
    progressLabel.layer.cornerRadius = 35/2;
    progressLabel.layer.masksToBounds = YES;
    [progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(photoImage);
        make.centerY.equalTo(photoImage);
        make.width.and.height.mas_equalTo(35);
    }];
    
    progressLabel.textColor = kUIColorFromRGB(0xffffff);
    progressLabel.font = [UIFont systemFontOfSize:11];
    
    
    UIButton * upLoadBtn = [[UIButton alloc] init];
    self.upLoadBtn = upLoadBtn;
    upLoadBtn.hidden = YES;
    [upLoadBtn setTitle:@"等待上传" forState:UIControlStateNormal];
    [upLoadBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [upLoadBtn setBackgroundColor:[kUIColorFromRGB(0x000000)  colorWithAlphaComponent:0.5]];
    [upLoadBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    upLoadBtn.layer.cornerRadius = 15;
    upLoadBtn.layer.masksToBounds = YES;
    [photoImage addSubview:upLoadBtn];
    [upLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(photoImage);
        make.centerX.equalTo(photoImage);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    
    
}

-(void)setModel:(HXPhotoModel *)model {
    switch (model.states) {
        case PhotoStatesWait:
        {
            if (!self.nostates) {
                
                self.upLoadBtn.hidden = NO;
                [self.upLoadBtn setTitle:@"等待上传" forState:UIControlStateNormal];
                [self.upLoadBtn setBackgroundColor:[kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.5]];
                self.upLoadBtn.enabled = NO;
                self.progressLabel.hidden = YES;
                self.deleteButton.hidden = YES;
            }
            
        }
            break;
        case PhotoStatesProgress:
        {
            if (!self.nostates) {
                
                self.progressLabel.hidden = NO;
                self.upLoadBtn.hidden = YES;
                NSInteger jd = (NSInteger)(model.progress*100);
                NSString * progress = [NSString stringWithFormat:@"%ld",(long)jd];
                self.progressLabel.text = [NSString stringWithFormat:@"%@%%",progress];
                self.deleteButton.hidden = YES;
            }
        }
            break;
        case PhotoStatesSuccess:
        {
            
            self.upLoadBtn.hidden = YES;
            self.progressLabel.hidden = YES;
            self.deleteButton.hidden = model.serverSuccess?YES:NO;
            
        }
            break;
        case PhotoStatesFail:
        {
            if (!self.nostates) {
                
                self.upLoadBtn.hidden = NO;
                [self.upLoadBtn setTitle:@"重新上传" forState:UIControlStateNormal];
                self.upLoadBtn.enabled = YES;
                self.progressLabel.hidden = YES;
                [self.upLoadBtn setBackgroundColor:[ComonBackColor colorWithAlphaComponent:0.5]];
                self.deleteButton.hidden = YES;
            }
            
        }
            break;
            
        default:
            break;
    }
    
    if (model.photoImage) {
        
        self.photoImage.image = model.photoImage;
    }else {
//        NSString * photoUrl = [Helper photoUrl:model.photoUrl width:((SCREEN_WIDTH-60)/2-10)*2 height:105*2];
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"listLogo"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            model.photoImage = image;
        }];
        
        
    }
    
    
}

@end
