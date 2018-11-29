//
//  ProgressView.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/8.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "ProgressView.h"


@interface ProgressView ()
@property (nonatomic, strong) CALayer* layerProgress;
@end

@implementation ProgressView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor                = COLOR_GRAY_LIGHT;
        self.layer.masksToBounds            = YES;
        self.layer.cornerRadius             = self.bounds.size.height/2;
        
        self.layerProgress                  = [CALayer layer];
        [self.layer insertSublayer:self.layerProgress atIndex:0];
        self.layerProgress.frame            = self.bounds;
        self.layerProgress.masksToBounds    = YES;
        self.layerProgress.cornerRadius     = self.bounds.size.height/2;
        self.layerProgress.backgroundColor  = COLOR_YELLOW_DARK.CGColor;
        
        self.progress   = 0.01f;
    }
    
    return self;
}

- (void) setProgress:(CGFloat)progress {
    _progress = progress;
    
    if (isnan(_progress)) {
        return;
    }
    
    CGRect frame                = self.layerProgress.frame;
    frame.size.width            = self.bounds.size.width * _progress;
    self.layerProgress.frame    = frame;
    
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.layerProgress.backgroundColor = progressColor.CGColor;
}

@end
