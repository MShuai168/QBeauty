//
//  AcdSeeCollectionViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "AcdSeeCollectionViewCell.h"
@implementation AcdSeeCollectionViewCell
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
    
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self.contentView);
    }];
    
    
}
-(void)setUrl:(NSString *)url {
    url =  [Helper photoUrl:url width:200 height:200];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager diskImageExistsForURL:[NSURL URLWithString:url]];
    if ([manager diskImageExistsForURL:[NSURL URLWithString:url]]) {
        _photoImage.image = [UIImage imageNamed:@"listLogo"];
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         UIImage * image  = [[manager imageCache] imageFromDiskCacheForKey:[NSURL URLWithString:url].absoluteString];
            dispatch_async(dispatch_get_main_queue(),^{
                _photoImage.image = image;
            });
        });
    }else {
        SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
        [_photoImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"listLogo"] options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    
    
    
    
}
@end
