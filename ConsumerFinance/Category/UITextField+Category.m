//
//  UITextField+HXTextField.m
//  ConsumerFinance
//
//  Created by Jney on 16/7/11.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "UITextField+Category.h"
#import <objc/runtime.h>

static void *strKey = &strKey;

@implementation UITextField (Category)

- (void)setBottomBorder:(UIColor *)color {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}

-(void)setKeyBoardHeight:(CGFloat )keyBoardHeight
{
    NSString *str = [NSString stringWithFormat:@"%f",keyBoardHeight];
    objc_setAssociatedObject(self, & strKey, str, OBJC_ASSOCIATION_COPY);
}

-(CGFloat )keyBoardHeight
{
    
    NSString *str = objc_getAssociatedObject(self, &strKey);
    CGFloat height = [str floatValue];
    return height;
}
#pragma mark-键盘确定按钮
-(void)creatSureButtonOnTextView{
    
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 50, 44)];
    doneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [doneBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,5)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [doneBtn setTitleColor:[UIColor colorWithRed:21/255.0 green:126/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(hidKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolBar.items = @[spaceItem,item];
    self.inputAccessoryView = toolBar;
}
//点击空白处隐藏键盘
-(void)hidKeyboard{
    
    [self.superview endEditing:YES];
}


-(void)keyBoardEvent{
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘隐藏的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasHide:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    /**
     *  点击空白处隐藏键盘
     */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyboard)];
    [self.superview addGestureRecognizer:tap];
    self.superview.userInteractionEnabled = YES;
    
}
//键盘出现
-(void)keyboardWasShown:(NSNotification*)info{
    //动画
    [UIView animateWithDuration:0.5 animations:^{
        if ([self.superview isKindOfClass:[UITableViewCell class]]) {
            self.superview.superview.frame = CGRectMake(0, 0, self.superview.width, self.superview.frame.size.height-self.keyBoardHeight);
            
            UIView* subView = nil;
            if ([NSStringFromClass(self.superview.class) isEqualToString:@"UITableViewCellContentView"]) {
                subView = self.superview.superview.superview;
                while (subView != nil) {
                    if ([subView.superview isKindOfClass:[UITableView class]]) {
                        subView = subView.superview;
                        break;
                    }
                    subView = subView.superview;
                }
                UITableView* tableView = (UITableView*)subView;
                
                tableView.frame = CGRectMake(0, 0, self.superview.width, self.superview.frame.size.height-self.keyBoardHeight);
            }
        }else{
            //获取键盘的高度
            NSDictionary *userInfo = [info userInfo];
            NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
            CGRect keyboardRect = [aValue CGRectValue];
            int height = keyboardRect.size.height;
            if ((self.superview.frame.size.height-self.frame.size.height-self.frame.origin.y)<(height+44)) {
                
                self.superview.frame = CGRectMake(0, 64-((height+44)-(self.superview.frame.size.height-self.frame.size.height-self.frame.origin.y)), self.superview.frame.size.width, self.superview.frame.size.height);
            }else
            {
                self.superview.frame = CGRectMake(0, 64, self.superview.frame.size.width, self.superview.frame.size.height);
            }
        }
    } completion:^(BOOL finished) {
        
        
    }];
    
    
    
}
//键盘隐藏
-(void)keyboardWasHide:(NSNotification*)info{
    //动画
    [UIView animateWithDuration:0.5 animations:^{
        if ([self.superview isKindOfClass:[UITableViewCell class]]){
            
            UIView* subView = nil;
            if ([NSStringFromClass(self.superview.class) isEqualToString:@"UITableViewCellContentView"]) {
                subView = self.superview.superview.superview;
                while (subView != nil) {
                    if ([subView.superview isKindOfClass:[UITableView class]]) {
                        subView = subView.superview;
                        break;
                    }
                    subView = subView.superview;
                }
                UITableView* tableView = (UITableView*)subView;
                
                tableView.frame = CGRectMake(0, 0, self.superview.width, self.superview.frame.size.height);
            }
        }else{
            self.superview.frame = CGRectMake(0, 64, self.superview.frame.size.width, self.superview.frame.size.height);
        }
        
    }];
    
}


@end
