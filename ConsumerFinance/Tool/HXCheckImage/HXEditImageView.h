//
//  HXEditImageView.h
//  CheckImg
//
//  Created by Jney on 2016/11/30.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXEditImageView;
@protocol HXEditImageViewDelegate <NSObject>

- (void) HXEditImageViewDelegateClickSureAtIndexPath:(NSIndexPath*)indexPath;
- (void) HXEditImageViewDelegateClickCancelAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface HXEditImageView : UIView<CAAnimationDelegate>

@property (nonatomic,weak) id<HXEditImageViewDelegate>delegate;

- (__kindof HXEditImageView *)initWithView:(UIImageView *)view SureButton:(NSString *)title andCancelButton:(NSString *)cancel atIndexPath:(NSIndexPath *)indexPath;
- (void) dismiss;

@end
