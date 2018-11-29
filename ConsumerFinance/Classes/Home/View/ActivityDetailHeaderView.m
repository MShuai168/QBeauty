//
//  ActivityDetailHeaderView.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/9/25.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "ActivityDetailHeaderView.h"

@implementation ActivityDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //ARRewardView : 自定义的view名称
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"ActivityDetailHeaderView" owner:self options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
