//
//  BarButtonView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/10/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BarButtonViewPosition) {
    BarButtonViewPositionLeft,
    BarButtonViewPositionRight
};
@interface BarButtonView : UIView
@property (nonatomic, assign) BarButtonViewPosition position;
@end

@interface TitileView : UIView
@property(nonatomic, assign) CGSize intrinsicContentSize;
@end

@interface EVNUILayoutView:UIView
- (instancetype)initWithFrame:(CGRect)frame;
@end
