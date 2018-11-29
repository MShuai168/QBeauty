//
//  LHBackgroundLayer.h
//  QRCodeDemo
//
//  Created by 侯荡荡 on 16/8/29.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface ScanAnimationLayer : CALayer
/*!
 * @brief 初始化动画图层，开始播放动画
 * @param backgroundColor 背景色
 * @param focusRect 设置焦点坐标
 * @return layer对象
 */
- (instancetype)initWithBounds:(CGRect)bounds backgroundColor:(UIColor *)backgroundColor focusRect:(CGRect)focusRect;
/*!
 * @brief 更新焦点坐标
 * @param completion 完成坐标更新的回调
 */
- (void)updateFocus:(CGRect)focusRect Completion:(void(^)(void))completion;
/*!
 * @brief 开始动画
 */
- (void)startAnimate;
/*!
 * @brief 结束动画
 */
- (void)stopAnimate;
/*!
 * @brief 聚焦动画时间
 */
@property (assign,nonatomic)CGFloat animateDurationWhenFocusChange;

@end
