//
//  YBAlertView.h
//  YBAlertView_Demo
//
//  Created by Jason on 16/1/12.
//  Copyright © 2016年 www.jizhan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

#define kScreenH ([UIScreen mainScreen].bounds.size.height)
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
typedef void(^ClickAlertControllerBlock)(NSString * contentMsg);
@interface HXAlertController : UIView

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *placeHoderStr;
@property (nonatomic,assign)UIKeyboardType keyBoardType;
@property (nonatomic,copy) ClickAlertControllerBlock clickAlertControllerBlock;
- (void)show;
- (void)close;


@end
