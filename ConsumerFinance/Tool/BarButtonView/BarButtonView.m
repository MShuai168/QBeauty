//
//  BarButtonView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/10/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "BarButtonView.h"
@interface BarButtonView ()
{
    BOOL applied;
}
@end
@implementation BarButtonView
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (applied || [[[UIDevice currentDevice] systemVersion] doubleValue]  < 11)
    {
        return;
    }
    
    // Find the _UIButtonBarStackView containing this view, which is a UIStackView, up to the UINavigationBar
    UIView *view = self;
    while (![view isKindOfClass:[UINavigationBar class]] && [view superview] != nil)
    {
        view = [view superview];
        if ([view isKindOfClass:[UIStackView class]] && [view superview] != nil)
        {
            if (self.position == BarButtonViewPositionLeft)
            {
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:8.0]];
                applied = YES;
            }
            else if (self.position == BarButtonViewPositionRight)
            {
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-8.0]];
                applied = YES;
            }
            break;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
@implementation TitileView

@end
@implementation EVNUILayoutView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}
/**
 * 撑开view的布局
 @return CGSize
 */
- (CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
}

@end
