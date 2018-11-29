//
//  UIViewController+Category.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/28.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)

/**
 设置导航条透明
 */
- (void)setNavigationBarTransparent:(CGFloat)alpha;

/**
 *  设置导航条的背景图片
 */
- (void)setNavigationBarBackgroundImage;
/**
 *  automaticallyAdjustsScrollViewInsets根据按所在界面的status bar，
 *  navigationbar，与tabbar的高度，自动调整scrollview的 inset,设置为no，
 *  不让viewController调整，我们自己修改布局即可
 */
- (void)cancelAutomaticallyAdjusts;
/**
 *  设置默认背景色
 */
- (void)setViewBackgroundColor;
/**
 *  设置控制器的导航条及颜色
 *
 *  @param color 导航条颜色(color = nil 时默认红色)
 */
- (void)setNavigationBarBackgroundColor:(UIColor *)color;
/**
 *  设置控制器的标题及颜色
 *
 *  @param title 显示的标题
 *  @param titleColor 标题的颜色(color = nil 时默认白色)
 */
- (void)setControllerTitle:(NSString *)title titleColor:(UIColor *)color;
/**
 *  设置导航条左按钮
 *
 *  @param title  显示的文字
 *  @param action 点击事件
 */
- (void)setLeftBarButtonWithTitle:(NSString *)title action:(SEL)action;
/**
 *  设置导航条左按钮
 *
 *  @param iconName  显示的图片名
 *  @param action 点击事件
 */
- (void)setLeftBarButtonWithIcon:(NSString *)iconName action:(SEL)action;
/**
 *  设置导航条右按钮
 *
 *  @param title  显示的文字
 *  @param action 点击事件
 */
- (void)setRightBarButtonWithTitle:(NSString *)title action:(SEL)action;
/**
 *  设置导航条右按钮
 *
 *  @param iconName  显示的图片名
 *  @param action 点击事件
 */
- (void)setRightBarButtonWithIcon:(NSString *)iconName action:(SEL)action;
/**
 *  设置返回按钮
 *
 *  @param icon 图片名称，icon == nil --> icon = @"icon_back_white"
 */
- (void)setBackItemWithIcon:(NSString *)icon;

/**
 *  隐藏导航条左按钮
 *
 *
 */
- (void)hiddenLeftItemButton;

/**
 *  返回事件(可重写)
 */
- (void)onBack;

/**
 *  隐藏导航栏下面的标线
 */
-(void)hiddenNavgationBarLine:(BOOL)hidden;


@end




@interface UIViewController (Exception)




/**
 *  显示异常页面
 */
- (void) showExceptionView;
- (void) showExceptionViewInView:(UIView*)view;
/**
 *  显示错误页面
 */
- (void) showErrorView;
- (void) showErrorViewInView:(UIView*)view;
/**
 *  显示断网异常页面
 */
- (void) showOffNetworkView;
- (void) showOffNetworkViewInView:(UIView*)view;
/**
 *  显示无数据页面
 */
- (void) showNullDataView;
- (void) showNullDataViewInView:(UIView*)view;
- (void) showNullDataViewInView:(UIView*)view withTitle:(NSString *)title;
/**
 *  无数据显示
 *
 *  @param frame 相对于tableview.backgroundView的位置
 *  @param icon  显示图片
 *  @param tips  提示文字
 *
 *  @return 当前view
 */
- (UIView *)showNullDataViewWithFrame:(CGRect)frame
                             iconName:(NSString *)icon
                                 tips:(NSString *)tips;
/**
 *  无数据显示
 *
 *  @param superFrame 父视图相对于tableview.backgroundView的位置
 *  @param subFrame   子视图相对于父视图的位置
 *  @param icon       显示图片
 *  @param tips       提示文字
 *
 *  @return 当前view
 */
- (UIView *)showNullDataViewWithSuperFrame:(CGRect)superFrame
                                  subFrame:(CGRect)subFrame
                                  iconName:(NSString *)icon
                                      tips:(NSString *)tips;

/**
 *  无数据显示
 *
 *  @param frame 相对于tableview.backgroundView的位置
 *  @param icon  显示图片
 *  @param tips  提示文字
 *  @param title button文本
 *
 *  @return 当前view
 */
- (UIView *)showNullDataViewWithFrame:(CGRect)frame
                             iconName:(NSString *)icon
                                 tips:(NSString *)tips
                          buttonTitle:(NSString *)title;
/**
 *  无更多数据的时候显示在footView上
 *
 *  @return footView
 */
- (UIView *)showNotMoreDataView;
/**
 *  隐藏异常页面
 */
- (void) hideExceptionView;
/**
 *  重试按钮
 */
- (void) tryAgainAtExceptionView;
/**
 *  无数据点击按钮事件
 */
- (void) noDataAction;

@end

