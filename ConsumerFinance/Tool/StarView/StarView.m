//
//  StarView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/13.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "StarView.h"
#define StarTag 100
@implementation StarView
-(id)init {
    self = [super init];
    if (self) {
        for (int i = 0; i<5; i++) {
            UIImageView * image = (UIImageView *)[self viewWithTag:i+StarTag-1];
            UIImageView * starImage = [[UIImageView alloc] init];
            starImage.tag = i+StarTag;
            starImage.image = [UIImage imageNamed:@"star2"];
            [self addSubview:starImage];
            if (i==0) {
                [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.mas_left).offset(0);
                }];
            }else{
                [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(image.mas_right).offset(2);
                }];
            }
        }
    }
    return self;
}
-(void)layoutSubviews {
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
