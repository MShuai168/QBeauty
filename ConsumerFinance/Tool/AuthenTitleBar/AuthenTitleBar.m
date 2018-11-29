//
//  AuthenTitleBar.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/25.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "AuthenTitleBar.h"
#import "ComButton.h"
@implementation AuthenTitleBar
-(id)initWithIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        [self createView:index];
    }
    return self;
}
-(void)createView:(NSInteger)index {
    NSArray * nameArr = @[@"选择分期",@"认证资料",@"签署合同",@"订单成功"];
    for (int i = 0; i<4; i++) {
        ComButton * button = [[ComButton alloc] init];
        button.nameLabel.text = [nameArr objectAtIndex:i];
        button.nameLabel.font = [UIFont systemFontOfSize:13];
//        button.nameLabel.textColor = kUIColorFromRGB(0x666666);
//        [button.photoImage setImage:[UIImage imageNamed:@"1@2x"]];
        [button.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button);
            make.top.equalTo(button);
            make.width.mas_equalTo(10.5);
            make.height.mas_equalTo(35);
        }];
        [button.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button);
            make.centerX.equalTo(button).offset(5.25);
        }];
        button.backgroundColor = kUIColorFromRGB(0xfafafa);
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(SCREEN_WIDTH/4);
            make.left.equalTo(self).offset(i*SCREEN_WIDTH/4);
            make.top.equalTo(self);
            
        }];
        if (index == i) {
            button.backgroundColor = kUIColorFromRGB(0xfafafa);
            [button.photoImage setImage:[UIImage imageNamed:@"1@2x"]];
        }else {
            button.backgroundColor = [UIColor whiteColor];
            [button.photoImage setImage:[UIImage imageNamed:@"3@2x"]];
        }
        if (index == i-1) {
            [button.photoImage setImage:[UIImage imageNamed:@"2@2x"]];
        }
    }
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = HXRGB(221, 221, 221);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
