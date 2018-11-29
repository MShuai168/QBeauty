//
//  HXStateView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXStateView.h"
@interface HXStateView()
@property (nonatomic,strong)UIView * view;
@property (nonatomic,assign)float offset;
@end
@implementation HXStateView
-(id)initWithalertShow:(showType)showtype backView:(UIView *)view offset:(float)offset{
    self = [super init];
    if (self) {
        self.view = view;
        self.showType = showtype;
        self.offset = offset;
        [self creatView];
        
    }
    return self;
}
-(void)creatView {
    self.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:self];
    self.userInteractionEnabled = YES;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(self.view);
        make.width.mas_equalTo(self.view.width);
        make.left.equalTo(self.view);
    }];
//    UIView * backView = [[UIView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];;
    UIImageView * imageView = [[UIImageView alloc] init];
    [imageView addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).mas_offset(140+_offset);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = ComonCharColor;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(imageView.mas_bottom).offset(30);
    }];
    
    UILabel * informationLable = [[UILabel alloc] init];
    informationLable.font = [UIFont systemFontOfSize:14];
    informationLable.textColor = ComonCharColor;
    [self addSubview:informationLable];
    [informationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
    }];
    
    if (![AFNetManager isHaveNet]) {
        imageView.image = [UIImage imageNamed:@"nowifi"];
        titleLabel.text = @"无网络连接";
        informationLable.text = @"请点连接网络后点击屏幕重试";
    }else {
    
    switch (_showType) {
        case 0:
        {
            imageView.image = [UIImage imageNamed:@"abnormal"];
            titleLabel.text = @"发生错误,请点击刷新";
        }
            break;
        case 1:
        {
            imageView.image = [UIImage imageNamed:@"pub_ic_loading"];
            titleLabel.text = @"加载中...";
            imageView.userInteractionEnabled =NO;
            
        }
            break;
        case 2:
        {
            imageView.image = [UIImage imageNamed:@"nodata"];
            titleLabel.text = @"暂无数据";
            imageView.userInteractionEnabled =NO;
        }
            break;
        case 3:
        {
            imageView.image = [UIImage imageNamed:@"pub_ic_nonet"];
            titleLabel.text = @"网络异常,请点击刷新";
        }
            break;
        case 5:
        {
            imageView.image = [UIImage imageNamed:@"nodingdan"];
            titleLabel.text = @"亲，您无待还账单";
            
        }
            break;
        case 6:
        {
            imageView.image = [UIImage imageNamed:@"nodingdan"];
            titleLabel.text = @"亲，您无还款记录";
            
        }
            break;
        case 7:
        {
            imageView.image = [UIImage imageNamed:@"nodingdan"];
            titleLabel.text = @"亲，您还没有订单哦～";
            
        }
            break;
        case 8:
        {
            imageView.image = [UIImage imageNamed:@"nodingdan"];
            titleLabel.text = @"暂无记录";
            
        }
            break;
            
            
        default:
        {
            [self removeFromSuperview];
        }
            break;
    }
    }
    
    
}
-(void)handleTap {
    
    self.submitBlock();
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
