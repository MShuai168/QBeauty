//
//  imageCell.h
//  看漫画页面
//
//  Created by 孟祥群 on 14-5-10.
//  Copyright (c) 2014年 练习. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImage/UIImageView+WebCache.h"

@interface ImageCell : UIScrollView

// 索引
@property (nonatomic, assign) NSUInteger index;
// 文本
@property (nonatomic, copy) NSString *text;
@property (nonatomic,retain)UIView * cellView;
@property (nonatomic,retain)NSString * nameStr;
//时间
@property (nonatomic,retain)UILabel * dateLabel;
@property (nonatomic,retain)NSString * dateStr;
//内容
@property (nonatomic,retain)UILabel * titleLabel;
@property (nonatomic,retain)NSString * titleStr;
// 文本控件
@property (nonatomic, retain) UILabel *textLabel;
// 图片名称
@property (nonatomic, retain) NSString *imageName;
// 图片链接
@property (nonatomic, retain) NSString *imageUrl;
// 图片控件
@property (nonatomic, retain) UIImageView *imageView;
// 图片大小
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic,retain)UILabel * nameLabel;
@property (nonatomic,retain)UIImage * image;

- (void)setImageWithImage:(UIImage *)image;

@end
