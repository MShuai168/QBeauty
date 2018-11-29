//
//  DZCustomTextField.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "DZCustomTextField.h"

@interface DZCustomTextField ()
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;
@end

@implementation DZCustomTextField

- (void)customWithPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font {
    self.placeholder = placeholder;
    
    self.placeholderColor = color;
    self.placeholderFont = font;
    
    NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [placeholderStr addAttribute:NSForegroundColorAttributeName
                        value:color
                        range:NSMakeRange(0, placeholder.length)];
    [placeholderStr addAttribute:NSFontAttributeName
                        value:font
                        range:NSMakeRange(0, placeholder.length)];
    self.attributedPlaceholder = placeholderStr;
}

// 重写这个方法是为了使Placeholder居中，如果不写会出现类似于下图中的效果，文字稍微偏上了一些
- (void)drawPlaceholderInRect:(CGRect)rect{
    UIColor *placeholderColor = self.placeholderColor;  //设置颜色
    [placeholderColor setFill];
    UIFont * font =  self.placeholderFont; //设置字体大小
    CGRect placeholderRect = CGRectMake(0, (rect.size.height- font.pointSize)/2, rect.size.width, font.pointSize+5);//设置距离
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
