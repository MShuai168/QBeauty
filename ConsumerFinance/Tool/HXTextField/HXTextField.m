//
//  HXTextField.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2018/1/9.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HXTextField.h"

@implementation HXTextField

- (void)deleteBackward {
    if ([self.text length] == 0) {
        if (self.deleteKeyReturnBlock) {
            self.deleteKeyReturnBlock(self);
        }
    }
    [super deleteBackward];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
