//
//  UIBarButtonItem+Category.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/3/28.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category)
/**
 *  设置导航控制器左右按钮
 *
 *  @param icon        正常显示的图片名
 *  @param highlighted 高亮显示的图片名
 *  @param target      目标对象
 *  @param action      点击事件
 *
 *  @return UIBarButtonItem对象
 */
- (id)initWithIcon:(NSString *)icon
   highlightedIcon:(NSString *)highlighted
            target:(id)target
            action:(SEL)action;
/**
 *  设置导航控制器左右按钮
 *
 *  @param title  显示的文字
 *  @param color  字体颜色
 *  @param font   字体大小
 *  @param target 目标对象
 *  @param action 点击事件
 *
 *  @return UIBarButtonItem对象
 */
- (id)initWithTitle:(NSString *)title
          textColor:(UIColor *)color
           textFont:(UIFont *)font
             target:(id)target
             action:(SEL)action;
@end
