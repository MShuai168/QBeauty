//
//  HXButton.m
//  DeliverSpeech
//
//  Created by Jney on 16/5/31.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import "HXButton.h"
@implementation HXButton
{
    NSInteger _second;
    NSTimer *_timer;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:HXRGB(60, 155, 255) forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}
/**
 *  按钮根据时间变化
 */
-(void)timeStart{
    //设置倒计时总时长
    if (self.time == 0) {
        self.time = 60;
    }
    _second = self.time;//60秒倒计时
    //开始倒计时
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    self.enabled = NO;
    
}
-(void)timeFireMethod{
    //倒计时-1
    _second--;
    //修改倒计时标签现实内容
    if (_titleStr.length == 0) {
        [self setTitle:[NSString stringWithFormat:@"剩余%ld秒",(long)_second] forState:UIControlStateNormal];
    }else{
        [self setTitle:[NSString stringWithFormat:@"%ld%@",(long)_second,_titleStr] forState:UIControlStateNormal];
        
    }
    [self setTitleColor:COLOR_GRAY_DARK forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_second==0){
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        self.enabled = YES;
        [self setTitleColor:HXRGB(60, 155, 255) forState:UIControlStateNormal];
        [_timer invalidate];
    }
}

- (void)invlidateTimer {
    [_timer invalidate];
    _timer = nil;
}


@end
