//
//  UIControl+HXCommandCategory.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/29.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXCommand.h"

@interface UIControl (HXCommandCategory)

@property (nonatomic, strong) HXCommand *hx_command;

@end
