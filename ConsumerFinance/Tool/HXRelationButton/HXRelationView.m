//
//  HXRelationView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/12.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXRelationView.h"
@interface HXRelationView()
@property (nonatomic,strong)NSArray * nameArr;
@property (nonatomic,strong)UIView * view;
@end
@implementation HXRelationView
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
    [_view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_view);
        make.right.equalTo(_view);
        make.left.equalTo(_view).offset(50);
    }];

    for (int i = 0; i<self.nameArr.count; i++) {
        UIButton * selectButton = [[UIButton alloc] init];
        selectButton.tag = i+100;
        selectButton.selected = NO;
        selectButton.layer.borderColor = kUIColorFromRGB(0xcccccc).CGColor;
        selectButton.layer.borderWidth = 1;
        [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [selectButton setTitle:[self.nameArr objectAtIndex:i] forState:UIControlStateNormal];
        [selectButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [selectButton setTitleColor:ComonCharColor forState:UIControlStateNormal];
        [self addSubview:selectButton];
        float width = [Helper widthOfString:[self.nameArr objectAtIndex:i] font:[UIFont systemFontOfSize:14] height:14];
        if (i==0) {
            
            [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.width.mas_equalTo(18+width);
                make.height.mas_equalTo(30);
                make.right.equalTo(self.mas_right).offset(-15);
            }];
        }else {
            UIButton * lastButton = (UIButton *)[self viewWithTag:i+99];
            [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.width.mas_equalTo(18+width);
                make.height.mas_equalTo(30);
                make.right.equalTo(lastButton.mas_left).offset(-5);
            }];
        }
        
    }
    
}
#pragma mark -- 设置选择位置
-(void)screeButton:(NSString *)name {
    UIButton * button;
    if ([name isEqualToString:@"父亲"]) {
        button =  (UIButton *)[self viewWithTag:104];
        button.selected = YES;
        self.name = button.titleLabel.text;
    }else if ([name isEqualToString:@"母亲"]) {
        button =  (UIButton *)[self viewWithTag:103];
        button.selected = YES;
        self.name = button.titleLabel.text;
    }else if ([name isEqualToString:@"配偶"]) {
        button =  (UIButton *)[self viewWithTag:102];
        button.selected = YES;
        self.name = button.titleLabel.text;
    }else if ([name isEqualToString:@"子女"]) {
        button =  (UIButton *)[self viewWithTag:101];
        button.selected = YES;
        self.name = button.titleLabel.text;
    }else if ([name isEqualToString:@"兄妹"]) {
        button =  (UIButton *)[self viewWithTag:100];
        button.selected = YES;
        self.name = button.titleLabel.text;
    }else if ([name isEqualToString:@"朋友"] ||[name isEqualToString:@"同事"] ||[name isEqualToString:@"同学"] ) {
        button =  (UIButton *)[self viewWithTag:100];
        button.selected = YES;
        self.name = button.titleLabel.text;
    }else {
        button =  (UIButton *)[self viewWithTag:104];
        button.selected = YES;
        self.name = button.titleLabel.text;
    }
    [button setTitleColor:kUIColorFromRGB(0x4990e2) forState:UIControlStateNormal];
    button.layer.borderColor = kUIColorFromRGB(0x4990e2).CGColor;
    for (int i = 0; i<self.nameArr.count; i++) {
        UIButton * newButton = (UIButton *)[self viewWithTag:i+100];
        if (![button isEqual:newButton]) {
            newButton.layer.borderColor = kUIColorFromRGB(0xcccccc).CGColor;
            [newButton setTitleColor:ComonCharColor forState:UIControlStateNormal];
            newButton.selected = NO;
            
        }
    }
}
-(void)updateButtonName:(NSString *)name {
    
   UIButton * button =  (UIButton *)[self viewWithTag:100];
    [button setTitle:name forState:UIControlStateNormal];
    
}
#pragma mark -- button点击事件
-(void)selectButtonAction:(id)sender {
    UIButton * button = (UIButton *)sender;
    if (!button.selected) {
        [button setTitleColor:kUIColorFromRGB(0x4990e2) forState:UIControlStateNormal];
        button.layer.borderColor = kUIColorFromRGB(0x4990e2).CGColor;
        self.name = button.titleLabel.text;
        if (self.select) {
            
            self.select(self.name);
        }
    }
    button.selected = !button.selected;
    for (int i = 0; i<self.nameArr.count; i++) {
        UIButton * newButton = (UIButton *)[self viewWithTag:i+100];
        if (![button isEqual:newButton]) {
            newButton.layer.borderColor = kUIColorFromRGB(0xcccccc).CGColor;
            [newButton setTitleColor:ComonCharColor forState:UIControlStateNormal];
            newButton.selected = NO;
            
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
