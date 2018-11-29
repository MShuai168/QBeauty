//
//  DatePickerView.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/9/5.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//  https://github.com/tanhuang/datePickView/tree/master

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer;

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate;

@end

@interface DatePickerView : UIView

@property (copy, nonatomic) NSString *title;

/// 是否自动滑动 默认YES
@property (assign, nonatomic) BOOL isSlide;

/// 选中的时间， 默认是当前时间 2017-02-12 13:35
@property (copy, nonatomic) NSString *date;

/// 分钟间隔 默认15分钟
@property (assign, nonatomic) NSInteger minuteInterval;

@property (weak, nonatomic) id <DatePickerViewDelegate> delegate;


/**
 显示  必须调用
 */
- (void)show;

@end
