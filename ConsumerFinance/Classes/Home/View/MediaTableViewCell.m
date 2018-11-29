//
//  MediaTableViewCell.m
//  creditor
//
//  Created by Jney on 16/9/24.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import "MediaTableViewCell.h"
#import "UIImage+Category.h"

const CGFloat cell_height_imgCell  = 240;
@interface MediaTableViewCell ()


@end

@implementation MediaTableViewCell

@synthesize imgView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ColorWithRGB(242, 242, 242);
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, cell_height_imgCell - 20)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:imgView];
        
        
    
        
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    if ([image isKindOfClass:[NSString class]]) {
        image = nil;
    }
    imgView.image = image;
    imgView.layer.borderColor = ColorWithRGB(255, 174, 0).CGColor;
    imgView.layer.borderWidth = 1;
}

- (void)setIndex:(NSInteger *)index{

    _index = index;
}
- (void)setImageStream:(NSString *)imageStream{

    _imageStream = imageStream;
}

- (void)setImagePageID:(NSString *)imagePageID{

    _imagePageID = imagePageID;
}

@end
