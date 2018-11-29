//
//  MBProgressHUD+Category.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/3/30.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "MBProgressHUD+Category.h"

@implementation MBProgressHUD (Category)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    //在iOS11上，多了一个_UIInteractiveHighlightEffectWindow类型窗口，hidden= YES。MBProgressHUD使用[[UIApplication shareApplication] lastObject]获取最上层窗口并添加，此时拿到的窗口为_UIInteractiveHighlightEffectWindow，并不可见。
    //解决办法： 将MBProgressHUD中获取最上层窗口的方法（[[UIApplication shareApplication] lastObject]）替换成[UIApplication shareApplication].keyWindow即可。
//    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.font = NormalFontWithSize(16.0f + fontScale);
    hud.contentColor = COLOR_DEFAULT_WHITE;
    hud.bezelView.backgroundColor = ColorWithRGBA(0.0, 0.0, 0.0, 0.9);
//    hud.bezelViewColor = ColorWithRGBA(0.0, 0.0, 0.0, 0.9);
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5f];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"" view:view];
}



/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font = NormalFontWithSize(16.0f + fontScale);
    hud.contentColor = COLOR_DEFAULT_WHITE;
    hud.bezelView.backgroundColor = ColorWithRGBA(0.0, 0.0, 0.0, 0.9);
//    hud.bezelViewColor = ColorWithRGBA(0.0, 0.0, 0.0, 0.9);
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

@end

