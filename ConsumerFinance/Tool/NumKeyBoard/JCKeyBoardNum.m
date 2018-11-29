//
//  JCKeyBoardNum.m
//  JCKeyBoard
//
//  Created by QB on 16/4/26.
//  Copyright © 2016年 JC. All rights reserved.
//

#import "JCKeyBoardNum.h"

#define clearColor    [UIColor clearColor]
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define keyHeight  250

@interface JCKeyBoardNum ()

- (instancetype)initWithFrame:(CGRect)frame; // 初始化方法

+ (instancetype)ShowWithFrame:(CGRect)frame;

@property (nonatomic, strong) NSArray *numArray; //键盘数组

@end

@implementation JCKeyBoardNum

- (NSArray *)numArray {
    // 懒加载
    if (!_numArray) {
        self.numArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    }
    return _numArray;
}

+ (instancetype)show {
    // 显示
    return [self new];
}

+ (instancetype)ShowWithFrame:(CGRect)frame {
    // 显示大小
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    // 工厂方法
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = clearColor;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        self.frame = CGRectMake(0, ScreenHeight - keyHeight , ScreenWidth, keyHeight);
        //创建数字键盘
        [self setupNumKeyBoard];
    }
    return self;
}

- (void)setupNumKeyBoard {
    // 创建NumKeyBoard
    NSMutableArray *numArray = [NSMutableArray arrayWithArray:self.numArray];
    int row = 4;
    int coloumn = 3;
    CGFloat keyWidth = self.frame.size.width / coloumn;
    CGFloat keyNewHeight = self.frame.size.height / row;
    
    for (int i = 0; i < 12; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i % coloumn *keyWidth, i / coloumn *keyNewHeight, keyWidth, keyNewHeight)];
        button.tag = i;
        //设置背景图
        [button setBackgroundImage:[JCKeyBoardNum imageWithColor:[UIColor colorWithRed:0.82 green:0.84 blue:0.85 alpha:1.0]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:22.0f];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
        if (i == 9 || i == 10 || i == 11) {
            button.backgroundColor = [UIColor colorWithRed:0.82 green:0.84 blue:0.85 alpha:1];
            [button setBackgroundImage:[JCKeyBoardNum imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
//            button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
            if (i == 9) {
                //                [button setTitle:@"完成" forState:UIControlStateNormal];
                [button setTitle:@"字母X" forState:UIControlStateNormal];
            } else if(i == 11) {
//                [button setTitle:@"删除" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"ic_delete_nor"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"ic_delete_hor_on"] forState:UIControlStateHighlighted];
            } else {
                [button setTitle:@"0" forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:22.0f];
                button.backgroundColor = [UIColor whiteColor];
                [button setBackgroundImage:[JCKeyBoardNum imageWithColor:[UIColor colorWithRed:0.82 green:0.84 blue:0.85 alpha:1.0]] forState:UIControlStateHighlighted];
            }
        } else {
            button.backgroundColor = [UIColor whiteColor];
            [button setBackgroundImage:[JCKeyBoardNum imageWithColor:[UIColor colorWithRed:0.82 green:0.84 blue:0.85 alpha:1]] forState:UIControlStateHighlighted];
            [button setTitle:[numArray objectAtIndex:i]forState:UIControlStateNormal];
        }
        //创建划线
        CGFloat lineW = self.frame.size.width;
        CGFloat lineH = self.frame.size.height;
        for (int i = 0; i < row - 1; i++) {
            UIView *lineView = [UIView new];
            lineView.frame = CGRectMake(0, keyNewHeight * (i + 1), lineW, 0.5);
            lineView.backgroundColor = [UIColor grayColor];
            [self addSubview:lineView];
        }
        for (int i = 0; i < coloumn - 1; i++) {
            UIView *lineView = [UIView  new];
            lineView.frame = CGRectMake(keyWidth * (i + 1), 0, 0.5, lineH);
            lineView.backgroundColor = [UIColor grayColor];
            [self addSubview:lineView];
        }
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    // 绘制的图
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 0.5f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)clickBtn:(UIButton *)sender {
    // 按钮的点击事件
    if (self.completeBlock) {
        self.completeBlock(sender.titleLabel.text,sender.tag);
    }
}

//隐藏键盘
- (void)dismiss {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
