//
//  ComButton.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "ComButton.h"
@interface ComButton()

@end
@implementation ComButton
-(id)init {
    
    self = [super init];
    if (self) {
        [self display];
    }
    return self;
}
-(void)display {
    /**
     *  icon
     *
     */
    UIImageView * image = [[UIImageView alloc] init];
    self.photoImage = image;
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(5);
    }];
    /**
     *  标题
     *
     */
    UILabel * titleLabel = [[UILabel alloc] init];
    self.nameLabel = titleLabel;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor= kUIColorFromRGB(0x333333);
    titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(image.mas_bottom).offset(10);
    }];
    
//    image.backgroundColor = [UIColor orangeColor];
//    titleLabel.backgroundColor = [UIColor redColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation ScreenButton
-(id)init
{
    self = [super init];
    if (self) {
       
        [self display];
    }
    return self;
    
}

-(void)display {
    
    /**
     *  标题
     *
     */
    UILabel * nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.textColor= kUIColorFromRGB(0x666666);
    nameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    /**
     *  icon
     *
     */
    UIImageView * arrowimage = [[UIImageView alloc] init];
    self.arrowimage = arrowimage;
    [self addSubview:arrowimage];
    if (SCREEN_WIDTH==320) {
        [arrowimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(nameLabel.mas_right).offset(-3);
        }];
    }
    [arrowimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(nameLabel.mas_right).offset(6);
    }];
    
}


@end

