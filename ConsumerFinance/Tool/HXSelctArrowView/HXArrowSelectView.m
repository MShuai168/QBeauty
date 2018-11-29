//
//  HXArrowSelectView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXArrowSelectView.h"
#define BtnTag 500
@interface HXArrowSelectView()
@property (nonatomic, assign) CGPoint origin;// 箭头位置
@property (nonatomic,strong)UIImageView * backGoundView;
@end
@implementation HXArrowSelectView
- (instancetype)initWithOrigin:(CGPoint)origin selectBlock:(selectBlock)selectBlock
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.selectBlock = selectBlock;
        self.origin = origin;
        [self creatUI];
    }
    return self;
}
-(void)creatUI {
    UIImageView * backImage =[[UIImageView alloc] initWithFrame:CGRectMake(self.origin.x, self.origin.y, 0, 0)];
    self.backGoundView = backImage;
    backImage.image = [UIImage imageNamed:@"Artboard"];
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];
    NSArray * titleArr = @[@"全部",@"获取",@"使用"];
    for (int i = 0; i < 3; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5+i*36, 86, 36)];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag = i+BtnTag;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:ComonTextColor forState:UIControlStateNormal];
        [backImage addSubview:btn];
        
        if (i!=2) {
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(5, 5+36+i*36, 76,0.5 )];
            lineView.backgroundColor = kUIColorFromRGB(0xE6E6E6);
            [backImage addSubview:lineView];
        }
    }
    
}
-(void)btnAction:(UIButton *)button {
    if (self.selectBlock) {
        self.selectBlock(button.tag - BtnTag);
    }
    [self dismiss];
    
}
- (void)popView
{
    NSArray *results = [self.backGoundView subviews];
    for (UIView *view in results) {
        [view setHidden:YES];
    }
    UIWindow *windowView = [UIApplication sharedApplication].keyWindow;
    [windowView addSubview:self];
    [self startAnimateView_x:self.origin.x _y:self.origin.y origin_width:86 origin_height:113];
    
}
- (void)startAnimateView_x:(CGFloat) x
                        _y:(CGFloat) y
              origin_width:(CGFloat) width
             origin_height:(CGFloat) height
{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backGoundView.frame = CGRectMake(x, y, width, height);
    }completion:^(BOOL finished) {
        NSArray *results = [self.backGoundView subviews];
        for (UIView *view in results) {
            [view setHidden:NO];
        }
    }];
}
#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![[touches anyObject].view isEqual:self.backGoundView]) {
        [self dismiss];
    }
}
#pragma mark -
- (void)dismiss
{
    /**
     * 删除 在backGroundView 上的子控件
     */
    NSArray *results = [self.backGoundView subviews];
    for (UIView *view in results) {
        [view removeFromSuperview];
    }
    [UIView animateWithDuration:0.25 animations:^{
        //
        self.backGoundView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        [self.backGoundView removeFromSuperview];
        //
        [self removeFromSuperview];
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
