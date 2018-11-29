//
//  UITableView+bgImage.h
//  SafetyProduction
//
//  Created by MaShuai on 16/5/12.
//  Copyright © 2016年 MaShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (bgImage)

/*
    image:图片名称
    imageRect:图片大小
 */
//-(void)showNullDataImageViewWithImage:(NSString *)image imageSize:(CGSize)imageRect  andTitleStr:(NSString *)titleStr titleColor:(NSInteger)hexValue withIsShow:(BOOL)isShow;

-(void)showNullDataImageViewWithImage:(NSString *)imageName andTitleStr:(NSString *)titleStr titleColor:(NSInteger)hexValue withIsShow:(BOOL)isShow;


/*
    image:图片名称
    imageRect:图片所在位置
 */
-(void)showNullDataImageViewWithImage:(NSString *)image imageRect:(CGRect)imageRect  andTitleStr:(NSString *)titleStr titleColor:(NSInteger)hexValue withIsShow:(BOOL)isShow;

@end
