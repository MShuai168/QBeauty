//
//  UITableView+bgImage.m
//  SafetyProduction
//
//  Created by MaShuai on 16/5/12.
//  Copyright © 2016年 MaShuai. All rights reserved.
//

#import "UITableView+bgImage.h"

@implementation UITableView (bgImage)

//- (void)showNullDataImageViewWithImage:(NSString *)image imageSize:(CGSize)imageRect  andTitleStr:(NSString *)titleStr titleColor:(NSInteger)hexValuer withIsShow:(BOOL)isShow {
//    UIView *backView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
//    if (isShow) {
//        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
//        [imageV setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - imageRect.width) / 2, ([UIScreen mainScreen].bounds.size.width - imageRect.height) / 2, imageRect.width, imageRect.height)];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageV.frame) + 20, [UIScreen mainScreen].bounds.size.width - 20, 40)];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = titleStr;
//        label.textColor = [UIColor colorWithHex:hexValuer];
//        label.font = [UIFont systemFontOfSize:15];
//        [backView addSubview:imageV];
//        [backView addSubview:label];
//        self.backgroundView = backView;
//    } else {
//        self.backgroundView = backView;
//    }
//}

- (void)showNullDataImageViewWithImage:(NSString *)imageName andTitleStr:(NSString *)titleStr titleColor:(NSInteger)hexValue withIsShow:(BOOL)isShow {
    UIView *backView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
    if (isShow) {
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - image.size.width) / 2, ([UIScreen mainScreen].bounds.size.width - image.size.height) / 2, image.size.width, image.size.height)];
        imgView.image = image;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgView.frame) + 15, [UIScreen mainScreen].bounds.size.width - 20, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titleStr;
        label.textColor = [UIColor colorWithHex:hexValue];
        label.font = [UIFont systemFontOfSize:15];
        [backView addSubview:imgView];
        [backView addSubview:label];
        self.backgroundView = backView;
    } else {
        self.backgroundView = backView;
    }
}

- (void)showNullDataImageViewWithImage:(NSString *)image imageRect:(CGRect)imageRect andTitleStr:(NSString *)titleStr titleColor:(NSInteger)hexValue withIsShow:(BOOL)isShow {
    UIView *backView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
    if (isShow) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        [imageV setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - imageRect.size.width) / 2, imageRect.origin.y, imageRect.size.width, imageRect.size.height)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageV.frame) + 10, [UIScreen mainScreen].bounds.size.width - 20, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titleStr;
        label.textColor = [UIColor colorWithHex:hexValue];
        label.font = [UIFont systemFontOfSize:15];
        
        [backView addSubview:imageV];
        [backView addSubview:label];
        self.backgroundView = backView;
    } else {
        self.backgroundView = backView;
    }
}


@end
