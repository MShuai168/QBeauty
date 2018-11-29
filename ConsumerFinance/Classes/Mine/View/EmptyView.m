//
//  EmptyView.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/18.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        //ARRewardView : 自定义的view名称
//        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"EmptyView" owner:self options:nil];
//        UIView *backView = [nibView objectAtIndex:0];
//        backView.frame = frame;
//        [self addSubview:backView];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"EmptyView" owner:self options:nil].firstObject;
        view.frame = frame;
        [self addSubview:view];
    }
    return self;
}

- (void)initWithImgName:(NSString *)str warningTitle:(NSString *)title {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
