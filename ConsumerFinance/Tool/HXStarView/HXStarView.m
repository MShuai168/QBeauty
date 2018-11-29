//
//  HXStarView.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/31.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXStarView.h"

@interface HXStarView()

@property (nonatomic, strong) UIView *backgroundkViews;
@property (nonatomic, strong) UIView *foregroundView;

@property (nonatomic, strong) UIImageView *bkImageView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *foreImageView;

@end

@implementation HXStarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.backgroundkViews];
        [self addSubview:self.foregroundView];
    }
    return self;
}

- (UIView *)backgroundkViews {
    if (!_backgroundkViews) {
        _backgroundkViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _backgroundkViews;
}

- (UIView *)foregroundView {
    if (!_foregroundView) {
        _foregroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        _foregroundView.clipsToBounds = YES;
    }
    return _foregroundView;
}

- (UIImageView *)bkImageView {
    if (!_bkImageView) {
        _bkImageView = [[UIImageView alloc] init];
    }
    return _bkImageView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)foreImageView {
    if (!_foreImageView) {
        _foreImageView = [[UIImageView alloc] init];
        _foreImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _foreImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.starViewStyle == HXStarViewStyleRate) {
        [self setUpStarViewForRate];
    } else {
        
        [self setUpStarViewForShow];
    }
}

/**
 展示星级
 */
- (void)setUpStarViewForShow {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImage *image = [UIImage imageNamed:@"star2group"];
    self.bkImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.bkImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.bkImageView.image = [UIImage imageNamed:@"star2group"];
    if (self.star > 5) {
        self.star = 5;
    }
    double persent = self.star/5;
    self.bgView.frame = CGRectMake(0, 0, image.size.width*persent, image.size.height);
    
    self.foreImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.foreImageView.image = [UIImage imageNamed:@"star1group"];
    [self.bgView addSubview:self.foreImageView];
    
    [self addSubview:self.bkImageView];
    [self addSubview:self.bgView];
}

/**
 评级页面
 */
- (void)setUpStarViewForRate {
    
    UIImage *image = [UIImage imageNamed:@"devaStar"];
    
    [self.backgroundkViews.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.foregroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.backgroundkViews.frame = CGRectMake(0, 0, SCREEN_WIDTH-69, 50);
    self.foreImageView.frame = CGRectMake(0, 0, 0, 50);
    
    
    
    for (int i=0; i<5; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(image.size.width+15), 0, image.size.width, image.size.height)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStar:)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i+200;
        tapGesture.view.tag = i+500;
        [imageView addGestureRecognizer:tapGesture];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImage:[UIImage imageNamed:@"devaStar"]];
        [self.backgroundkViews addSubview:imageView];
        
        // 红色的
        UIImageView *foreImageView = [[UIImageView alloc] initWithFrame:imageView.frame];
        UITapGestureRecognizer *tapsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopTapStar:)];
        foreImageView.userInteractionEnabled = YES;
        foreImageView.tag = i+300;
        tapsGesture.view.tag = i+500;
        [foreImageView addGestureRecognizer:tapsGesture];
        foreImageView.contentMode = UIViewContentModeScaleAspectFit;
        foreImageView.image = [UIImage imageNamed:@"evaStar"];
        [self.foregroundView addSubview:foreImageView];
    }
}

- (void)tapStar:(UITapGestureRecognizer *)tapGesure {
    UIImageView * image = (UIImageView *)[self.backgroundkViews viewWithTag:tapGesure.view.tag];
    self.foregroundView.frame = CGRectMake(0, 0, image.origin.x+image.width, self.frame.size.height);
    self.selectStar = tapGesure.view.tag-200+1;
    if (self.selectBlock) {
        self.selectBlock();
    }
}
- (void)stopTapStar:(UITapGestureRecognizer *)tapGesure {
    UIImageView * image = (UIImageView *)[self.backgroundkViews viewWithTag:tapGesure.view.tag-100];
    self.foregroundView.frame = CGRectMake(0, 0, image.origin.x+image.width, self.frame.size.height);
    self.selectStar = tapGesure.view.tag-300+1;
    if (self.selectBlock) {
        self.selectBlock();
    }
}

@end
