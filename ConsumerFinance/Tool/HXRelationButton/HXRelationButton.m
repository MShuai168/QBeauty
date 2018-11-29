//
//  HXRelationButton.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/12.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXRelationButton.h"
#import "Helper.h"
@interface HXRelationButton()
@property (nonatomic,strong)NSArray * nameArr;
@property (nonatomic,strong)UIView * view;
@end
@implementation HXRelationButton
-(id)initWithNameArray:(NSArray *)nameArr view:(UIView *)view{
    
    self = [super init];
    if (self) {
        self.nameArr = nameArr;
        self.view = view;
        [self display];
    }
    return self;
}
-(void)display {
    for (int i = 0; i<self.nameArr.count; i++) {
        UIButton * selectButton = [[UIButton alloc] init];
        selectButton.tag = i+100;
        selectButton.layer.borderColor = kUIColorFromRGB(0xcccccc).CGColor;
        selectButton.layer.borderWidth = 1;
        [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [selectButton setTitle:[self.nameArr objectAtIndex:i] forState:UIControlStateNormal];
        [selectButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [selectButton setTitleColor:ComonCharColor forState:UIControlStateNormal];
        [self.view addSubview:selectButton];
        float width = [Helper widthOfString:[self.nameArr objectAtIndex:i] font:[UIFont systemFontOfSize:14] height:14];
        if (i==0) {
            
            [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_view);
                make.width.mas_equalTo(18+width);
                make.height.mas_equalTo(30);
                make.right.equalTo(_view.mas_right).offset(-15);
            }];
        }else {
            UIButton * lastButton = (UIButton *)[_view viewWithTag:i+99];
            [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_view);
                make.width.mas_equalTo(18+width);
                make.height.mas_equalTo(30);
                make.right.equalTo(lastButton.mas_left).offset(-5);
            }];
        }
        
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
