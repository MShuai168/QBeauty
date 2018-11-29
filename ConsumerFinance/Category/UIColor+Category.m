//
//  UIColor+Category.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/27.
//  Copyright © 2016年 Hou. All rights reserved.


#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)colorRGBConvertToHSB:(UIColor *)color withBrighnessDelta:(CGFloat)delta {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    brightness += delta;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

+ (UIColor *)colorRGBConvertToHSB:(UIColor *)color withAlphaDelta:(CGFloat)delta {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    alpha += delta;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSInteger)hex{
    return [self colorWithHex:hex alpha:1];
}

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha{
    
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithRGB:(NSUInteger)r green:(NSInteger)g blue:(NSUInteger)b {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}

+ (UIColor *)colorWithRGB:(NSUInteger)r green:(NSInteger)g blue:(NSUInteger)b alpha:(CGFloat)a {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];
}



@end
