//
//  HomeDetailHeaderView.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HomeDetailHeaderView.h"

@implementation HomeDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //ARRewardView : 自定义的view名称
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"HomeDetailHeaderView" owner:self options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
    }
    return self;
}

- (IBAction)bookingButtonAction:(UIButton *)sender {
    if (self.block) {
        self.block(sender);
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
