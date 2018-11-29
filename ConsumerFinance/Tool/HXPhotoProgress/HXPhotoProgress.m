//
//  HXPhotoProgress.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/18.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPhotoProgress.h"

@implementation HXPhotoProgress
-(id)init {
    
    self = [super init];
    if (self) {

    }
    return self;
    
}
-(void)creatUI {
    self.backgroundColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo([UIApplication sharedApplication].keyWindow);
        make.left.equalTo([UIApplication sharedApplication].keyWindow).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [self layoutIfNeeded];
    
    
    UIView * backView = [[UIView alloc] init];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 10;
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo([UIApplication sharedApplication].keyWindow);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
        make.centerY.equalTo([UIApplication sharedApplication].keyWindow);
        make.height.mas_equalTo(165);
    }];
    
    
    UILabel * inforLabel = [[UILabel alloc] init];
    self.inforLabel = inforLabel;
    [inforLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:17]];
    [inforLabel setTextColor:ComonTextColor];
    [inforLabel setText:@"影像上传中......"];
    [backView addSubview:inforLabel];
    [inforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(20);
        make.centerX.equalTo(backView);
        make.height.mas_equalTo(17);
    }];
    
    UILabel * uploadInformationLabel = [[UILabel alloc] init];
    self.uploadInformationLabel = uploadInformationLabel;
    self.uploadInformationLabel.text = @"正在上传第1张";
    uploadInformationLabel.font = [UIFont systemFontOfSize:12];
    uploadInformationLabel.textColor = ComonCharColor;
    [backView addSubview:uploadInformationLabel];
    [uploadInformationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inforLabel.mas_bottom).offset(20);
        make.centerX.equalTo(backView);
        make.height.mas_equalTo(12);
    }];
    
    
    UIView * progressView = [[UIView alloc] init];
    self.progressView = progressView;
    progressView.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    progressView.layer.cornerRadius = 8;
    progressView.layer.masksToBounds=YES;
    [backView addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(30);
        make.right.equalTo(backView).offset(-30);
        make.height.mas_equalTo(16);
        make.top.equalTo(uploadInformationLabel.mas_bottom).offset(15);
    }];
    
    UIView * progressInView = [[UIView alloc] init];
    self.progressInView = progressInView;
    progressInView.backgroundColor = kUIColorFromRGB(0xffffff);
    progressInView.layer.cornerRadius = 8;
    progressInView.layer.masksToBounds = YES;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kUIColorFromRGB(0x56A0FC).CGColor, (__bridge id)[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.8].CGColor, (__bridge id)kUIColorFromRGB(0x56C5FC).CGColor];
    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    [progressInView.layer addSublayer:gradientLayer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-120, 16);
    [progressView addSubview:progressInView];
    [progressInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressView).offset(0);
        make.top.and.bottom.equalTo(progressView);
        make.width.mas_equalTo(0);
    }];

    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = kUIColorFromRGB(0xE4E4E4);
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.and.right.equalTo(backView);
        make.bottom.equalTo(backView).offset(-50.5);
    }];
    
    UIButton * cancelBtn = [[UIButton alloc] init];
    self.cancelBtn = cancelBtn;
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消上传" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:ComonTitleColor forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [backView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(backView);
        make.bottom.equalTo(backView.mas_bottom).offset(0);
        make.height.mas_equalTo(50);
        
    }];
}

-(void)cancelBtnAction {
    
    if ([self.delegate respondsToSelector:@selector(cancelAction)]) {
        [self.delegate cancelAction];
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
