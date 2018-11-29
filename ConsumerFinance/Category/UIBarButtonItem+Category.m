//
//  UIBarButtonItem+Category.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/3/28.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "UIBarButtonItem+Category.h"
#import "NSString+Category.h"

@implementation UIBarButtonItem (Category)

- (id)initWithIcon:(NSString *)icon
   highlightedIcon:(NSString *)highlighted
            target:(id)target
            action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:icon];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlighted]
                      forState:UIControlStateHighlighted];
    // 设置尺寸
    button.bounds = (CGRect){CGPointZero, image.size};
    [button addTarget:target action:action
     forControlEvents:UIControlEventTouchUpInside];
   
    return [self initWithCustomView:button];
}

- (id)initWithTitle:(NSString *)title
          textColor:(UIColor *)color
           textFont:(UIFont *)font
             target:(id)target
             action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    // 设置尺寸
    CGSize fontSize = [title sizeWithConstrainedSize:CGSizeMake(MAXFLOAT, 44)
                                                font:font
                                         lineSpacing:0];
    button.bounds   = (CGRect){CGPointZero, fontSize};
    
    [button addTarget:target action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}


@end
