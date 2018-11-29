//
//  UIControl+HXCommandCategory.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/29.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "UIControl+HXCommandCategory.h"

static void *UIButtonCCCommandKey = &UIButtonCCCommandKey;

@implementation UIControl (HXCommandCategory)

- (HXCommand *)hx_command {
    return objc_getAssociatedObject(self, UIButtonCCCommandKey);
}

- (void)setHx_command:(HXCommand *)hx_command {
    if (hx_command == nil) return;
    
    objc_setAssociatedObject(self, UIButtonCCCommandKey, hx_command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self hx_hijackActionAndTargetIfNeeded];
}

- (void)hx_hijackActionAndTargetIfNeeded {
    SEL hijackSelector = @selector(hj_commandPerformAction:);
    
    for (NSString *selector in [self actionsForTarget:self forControlEvent:UIControlEventTouchUpInside]) {
        if (hijackSelector == NSSelectorFromString(selector)) {
            return;
        }
    }
    
    [self addTarget:self action:hijackSelector forControlEvents:UIControlEventTouchUpInside];
}

- (void)hj_commandPerformAction:(id)sender {
    [self.hx_command execute:sender];
}

@end
