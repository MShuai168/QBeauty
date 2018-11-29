//
//  imageCell.m
//  看漫画页面
//
//  Created by 孟祥群 on 14-5-10.
//  Copyright (c) 2014年 练习. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell
@synthesize index = _index;

@synthesize textLabel = _textLabel;
@synthesize cellView = _cellView;

@synthesize text = _text;

@synthesize imageName = _imageName;

@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.imageView];
        
    }
    return self;
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 20)];
        [_nameLabel setFont:[UIFont systemFontOfSize:15]];
        [_nameLabel setTextColor:kUIColorFromRGB(0xffffff)];
        [_cellView addSubview:_nameLabel];
        
        
    }
    
    
    return _nameLabel;
}
-(UILabel *)dateLabel
{
    
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 5, 150, 20)];
        [_dateLabel setFont:[UIFont systemFontOfSize:15]];
        [_dateLabel setTextColor:kUIColorFromRGB(0xffffff)];
        [_cellView addSubview:_dateLabel];
    }
    
    return _dateLabel;
}

-(UILabel *)titleLabel
{
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 280, 50)];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_titleLabel setTextColor:kUIColorFromRGB(0x999999)];
        [_cellView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}



- (UILabel *)textLabel{
    
    if (_textLabel == nil) {
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        
        _textLabel.backgroundColor = self.backgroundColor;
        
        _textLabel.contentMode = UIViewContentModeCenter;
        
        [self addSubview:_textLabel];
        
    }
    
    return _textLabel;
    
}


- (void)setText:(NSString *)text{
    
    if (text != nil) {
        
        _text = [text copy];
        
        self.textLabel.text = _text;
        
    }
    
}


- (UIImageView *)imageView{
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        self.imageView.frame =CGRectMake(0,[self mainWindow].frame.size.height/2-570/4 , SCREEN_WIDTH, 570/2);
    }
    return _imageView;
    
}
- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}
-(void)setImage:(UIImage *)image {
    if (image) {
        CGFloat scale = image.size.width / image.size.height;
        if (self.imageView.image.size.width>=[self mainWindow].width &&self.imageView.image.size.height>= [self mainWindow].height){
            self.imageView.size = CGSizeMake([self mainWindow].width, [self mainWindow].height);
        }else {
            if (image.size.width > image.size.height) {
                if (image.size.width>[self mainWindow].width) {
                    self.imageView.size = CGSizeMake([self mainWindow].width, [self mainWindow].width / scale);
                }else
                {
                    self.imageView.size = image.size;
                }
            }else
            {
                if (image.size.height > [self mainWindow].height) {
                    self.imageView.size = CGSizeMake([self mainWindow].height * scale, [self mainWindow].height);
                }else
                {
                    self.imageView.size = image.size;
                }
            }
        }
        self.imageView.center = [self mainWindow].center;
        self.imageView.image = image;
    }
    
    
    
    
}
- (void)setImageWithImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)setImageName:(NSString *)imageName{
    
    if (imageName.length!=0) {
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"listLogo"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (self.imageView.image) {
                
                CGFloat scale = self.imageView.image.size.width / self.imageView.image.size.height;
                if (self.imageView.image.size.width>=[self mainWindow].width &&self.imageView.image.size.height>= [self mainWindow].height){
                    self.imageView.size = CGSizeMake([self mainWindow].width, [self mainWindow].height);
                }else {
                    if (self.imageView.image.size.width > self.imageView.image.size.height) {
                        if (self.imageView.image.size.width>[self mainWindow].width) {
                            self.imageView.size = CGSizeMake([self mainWindow].width, [self mainWindow].width / scale);
                        }else
                        {
                            
                            self.imageView.size = self.imageView.image.size;
                        }
                    }else
                    {
                        if (self.imageView.image.size.height > [self mainWindow].height) {
                            self.imageView.size = CGSizeMake([self mainWindow].height * scale, [self mainWindow].height);
                        }else
                        {
                            self.imageView.size = self.imageView.image.size;
                        }
                    }
                }
                self.imageView.center = [self mainWindow].center;
            }
        }];
        
    }else {
        
        [self.imageView setImage:[UIImage imageNamed:@"listLogo"]];
        self.imageView.frame =CGRectMake(0,[self mainWindow].frame.size.height/2-570/4 , SCREEN_WIDTH, 570/2);
    }
    
}

- (void)setImageUrl:(NSString *)imageUrl{
    
    if (imageUrl != nil) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"listLogo"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                CGFloat scale = image.size.width / image.size.height;
                if (image.size.width > image.size.height) {
                    if (image.size.width>[self mainWindow].width) {
                        self.imageView.size = CGSizeMake([self mainWindow].width, [self mainWindow].width / scale);
                    }else
                    {
                        self.imageView.size = image.size;
                    }
                }else
                {
                    if (image.size.height > [self mainWindow].height) {
                        self.imageView.size = CGSizeMake([self mainWindow].height * scale, [self mainWindow].height);
                    }else
                    {
                        self.imageView.size = image.size;
                    }
                }
                self.imageView.center = [self mainWindow].center;
            }
        }];
        
        
    }
    
}
-(void)setNameStr:(NSString *)nameStr
{
    if (nameStr != nil) {
        
        [self.nameLabel setText:nameStr];
        
    }
    
    
    
    
}
-(void)setDateStr:(NSString *)dateStr
{
    
    if (dateStr !=nil) {
        
        [self.dateLabel setText:dateStr];
    }
    
    
}
-(void)setTitleStr:(NSString *)titleStr
{
    if (titleStr != nil) {
        [self.titleLabel setText:titleStr];
    }
    
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

