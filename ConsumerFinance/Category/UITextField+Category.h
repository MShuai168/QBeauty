//
//  UITextField+HXTextField.h
//  ConsumerFinance
//
//  Created by Jney on 16/7/11.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

@property(nonatomic,assign)CGFloat keyBoardHeight;

/**
 设置底部border

 */
- (void)setBottomBorder:(UIColor *)color;

/**
 *  键盘添加确定按钮
 */
-(void)creatSureButtonOnTextView;
/**
 *  键盘事件
 */
-(void)keyBoardEvent;
@end
