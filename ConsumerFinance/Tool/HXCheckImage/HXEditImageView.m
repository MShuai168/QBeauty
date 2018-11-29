//
//  HXEditImageView.m
//  CheckImg
//
//  Created by Jney on 2016/11/30.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import "HXEditImageView.h"

const CGFloat cell_ImageView_height  = 220;
@interface HXEditImageView()

@property (nonatomic,strong) UIButton *sureButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIView   *bgView;
@property (nonatomic,strong) UIView   *baseView;

@property (nonatomic,strong) NSIndexPath *indexPath;

@end

@implementation HXEditImageView
@synthesize sureButton, cancelButton, imageView;

- (__kindof HXEditImageView *)initWithView:(UIImageView *)view SureButton:(NSString *)title andCancelButton:(NSString *)cancel atIndexPath:(NSIndexPath *)indexPath{
    
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        self.indexPath = indexPath;
        self.baseView = view;
        [self beginAnimation:view];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.bgView = bgView;
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
        UITapGestureRecognizer *tapBgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
        bgView.userInteractionEnabled = YES;
        [bgView addGestureRecognizer:tapBgView];
        [self addSubview:bgView];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, [UIScreen mainScreen].bounds.size.height/4 - 90, [UIScreen mainScreen].bounds.size.width - 30, cell_ImageView_height * showScale)];
        UIImageView *imgView = (UIImageView *)view;
        imageView.image = imgView.image;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        [bgView addSubview:imageView];
        
        //更换按钮
        sureButton = [[UIButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 220)/2.0, imageView.frame.size.height + imageView.frame.origin.y, 100, 100)];
        [sureButton setImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
        [sureButton setTitle:title forState:UIControlStateNormal];
        [sureButton setTitleColor:ColorWithRGB(61, 155, 255) forState:UIControlStateNormal];
        [sureButton setTitleEdgeInsets:UIEdgeInsetsMake(sureButton.frame.size.height - sureButton.titleLabel.frame.size.height - sureButton.titleLabel.frame.origin.y, -sureButton.imageView.frame.size.width/2.0, -(sureButton.frame.size.height - sureButton.titleLabel.frame.size.height - sureButton.titleLabel.frame.origin.y), sureButton.imageView.frame.size.width/2.0)];
        [sureButton setImageEdgeInsets:UIEdgeInsetsMake(0, sureButton.titleLabel.frame.size.width/2.0,0, -sureButton.titleLabel.frame.size.width/2.0)];
        [sureButton addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:sureButton];
        
        //删除按钮
        cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(sureButton.frame.origin.x + 120, imageView.frame.size.height + imageView.frame.origin.y, 100, 100)];
        [cancelButton setImage:[UIImage imageNamed:@"deleteimg"] forState:UIControlStateNormal];
        [cancelButton setTitle:cancel forState:UIControlStateNormal];
        [cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(cancelButton.frame.size.height - cancelButton.titleLabel.frame.size.height - cancelButton.titleLabel.frame.origin.y, -cancelButton.imageView.frame.size.width/2.0, -(cancelButton.frame.size.height - cancelButton.titleLabel.frame.size.height - cancelButton.titleLabel.frame.origin.y), cancelButton.imageView.frame.size.width/2.0)];
        [cancelButton setImageEdgeInsets:UIEdgeInsetsMake(0, cancelButton.titleLabel.frame.size.width/2.0,0, -cancelButton.titleLabel.frame.size.width/2.0)];
        [cancelButton setTitleColor:ColorWithRGB(255, 93, 94) forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:cancelButton];
        
        
        //透明度变化
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = [NSNumber numberWithFloat:0.0];
        animation.duration  = 0.3;
        animation.toValue   = [NSNumber numberWithFloat:1.0];
        animation.removedOnCompletion = NO;
        animation.fillMode  =kCAFillModeForwards ;
        [bgView.layer addAnimation:animation forKey:nil];
        

    }
    return self;
    
}

//点击黑色视图   隐藏bgView
- (void) tapBgView:(UITapGestureRecognizer *)tap{
    
    //透明度变化
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.removedOnCompletion = NO;
    animation.fillMode =kCAFillModeForwards ;
    animation.delegate = self;
    [self.bgView.layer addAnimation:animation forKey:nil];
    [self endAnimation:self.baseView];
    
    
}

//动画结束后移除view
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self removeFromSuperview];
    
}

//开始动画
- (void) beginAnimation:(UIView *)view{

    CABasicAnimation *moveAnimation = [[CABasicAnimation alloc] init];
    
    moveAnimation.keyPath = @"position";
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/4 - 90)];
    
    //透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.1];
    
    
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    groupAnimation.animations = @[moveAnimation,opacityAnimation];
    groupAnimation.duration   = 0.3;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode   =kCAFillModeForwards ;
    
    [view.layer addAnimation:groupAnimation forKey:nil];

}

//结束动画
- (void) endAnimation:(UIView *)view{
    
    CABasicAnimation *moveAnimation = [[CABasicAnimation alloc] init];
    
    moveAnimation.keyPath = @"position";
    moveAnimation.toValue = [NSValue valueWithCGPoint:self.baseView.center];
    
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.toValue = [NSValue valueWithCGRect:self.baseView.bounds];
    
    //透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.1];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    groupAnimation.animations = @[moveAnimation,boundsAnimation,opacityAnimation];
    groupAnimation.duration = 0.3;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode =kCAFillModeForwards ;
    
    [view.layer addAnimation:groupAnimation forKey:nil];
    
}

//按钮事件
- (void) sureClick:(UIButton *)but{
    if ([self.delegate respondsToSelector:@selector(HXEditImageViewDelegateClickSureAtIndexPath:)]) {
        [self.delegate HXEditImageViewDelegateClickSureAtIndexPath:self.indexPath];
    }

}

- (void)dismiss{
    //透明度变化
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.removedOnCompletion = NO;
    animation.fillMode =kCAFillModeForwards ;
    animation.delegate = self;
    [self.bgView.layer addAnimation:animation forKey:nil];
    [self endAnimation:self.baseView];

}

- (void) cancelClick:(UIButton *)but{
    if ([self.delegate respondsToSelector:@selector(HXEditImageViewDelegateClickCancelAtIndexPath:)]) {
        [self.delegate HXEditImageViewDelegateClickCancelAtIndexPath:self.indexPath];
    }
}

@end
