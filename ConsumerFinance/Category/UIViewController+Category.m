//
//  UIViewController+Category.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/28.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "UIViewController+Category.h"
#import "NSMutableAttributedString+Category.h"
#import "UIBarButtonItem+Category.h"


@implementation UIViewController (Category)

- (void)setNavigationBarTransparent:(CGFloat)alpha {
    self.navigationController.navigationBar.translucent = YES;//默认是半透明的
    
    [self setNavigationBarBackgroundColor:[UIColor whiteColor]];
    
    [[self.navigationController.navigationBar.subviews objectAtIndex:0] setAlpha:alpha];
}

- (void) setNavigationBarBackgroundImage{
    self.navigationController.navigationBar.translucent = NO;//默认是半透明的
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:HXRGB(255, 255, 255)
                                                                                 opaque:YES
                                                                                   size:CGSizeMake(SCREEN_WIDTH, STA_NAV_HEIGHT)]
                                                  forBarMetrics:UIBarMetricsDefault];
}

#pragma -mark 隐藏导航栏下面的线
-(void)hiddenNavgationBarLine:(BOOL)hidden {
    //再定义一个imageview来等同于这个黑线
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    if (hidden) {
        navBarHairlineImageView.hidden = YES;
    } else{
        navBarHairlineImageView.hidden = NO;
    }
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)cancelAutomaticallyAdjusts {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setViewBackgroundColor {
    self.view.backgroundColor = COLOR_BACKGROUND_DARK;
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color {
    
    if (!color) color = COLOR_YELLOW_DARK;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color
                                                                                 opaque:YES
                                                                                   size:CGSizeMake(SCREEN_WIDTH, STA_NAV_HEIGHT)]
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)setControllerTitle:(NSString *)title titleColor:(UIColor *)color {
    
    self.title                    = title;
    CGSize maxSize                = CGSizeMake(MAXFLOAT, 44) ;
    CGSize titleSize              = [title sizeWithConstrainedSize:maxSize
                                                              font:NormalFontWithSize(18.0+fontScale)
                                                       lineSpacing:0];
    UILabel *titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                              0,
                                                                              titleSize.width,
                                                                              titleSize.height)];
    titleLabel.font               = NormalFontWithSize(18.0+fontScale);
    titleLabel.textColor          = color ? color : COLOR_DEFAULT_BLACK;
    titleLabel.text               = title;
    titleLabel.textAlignment      = NSTextAlignmentCenter;
    titleLabel.backgroundColor    = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.titleView.alpha = 0;
    [UIView animateWithDuration:0.15 animations:^{
        self.navigationItem.titleView.alpha = 1;
    }];
}

- (void)setLeftBarButtonWithTitle:(NSString *)title action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                         textColor:COLOR_DEFAULT_WHITE
                                                          textFont:NormalFontWithSize(16.0+fontScale)
                                                            target:self
                                                            action:action];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)setLeftBarButtonWithIcon:(NSString *)iconName action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:iconName
                                                  highlightedIcon:nil
                                                           target:self
                                                           action:action];
    self.navigationItem.leftBarButtonItem = item;

}

- (void)setRightBarButtonWithTitle:(NSString *)title action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                         textColor:COLOR_HM_BLACK
                                                          textFont:NormalFontWithSize(16.0+fontScale)
                                                            target:self
                                                            action:action];
    self.navigationItem.rightBarButtonItem = item;

}

- (void)setRightBarButtonWithIcon:(NSString *)iconName action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:iconName
                                                  highlightedIcon:nil
                                                           target:self
                                                           action:action];
    self.navigationItem.rightBarButtonItem = item;
    
}


- (void)setBackItemWithIcon:(NSString *)icon {
    
    
    icon = [NSString isBlankString:icon] ? @"loginBack" : icon;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:icon
                                                  highlightedIcon:nil
                                                           target:self
                                                           action:@selector(onBack)];
    
    //修改导航栏左右按钮的坐标
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 0;//这个数值可以根据情况自由变化
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,item];
    
}

- (void)hiddenLeftItemButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:nil
                                                  highlightedIcon:nil
                                                           target:self
                                                           action:nil];
    //修改导航栏左右按钮的坐标
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;//这个数值可以根据情况自由变化
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,item];
    
}

- (void)onBack {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}



@end




#define TAG_OF_EXCEPTION_VIEW           999001

@implementation UIViewController (Exception)

#pragma mark - ExceptionView
- (void) showExceptionView {
    [self showExceptionViewInView:self.view];
}

- (void) showExceptionViewInView:(UIView *)view {
    
    UIView* exceptionView = [self exceptionViewInView:view];
    
    exceptionView.backgroundColor = COLOR_BACKGROUND_DARK;
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 133.0f)/2,
                                                                           (SCREEN_HEIGHT - 133.0f - TABBAR_HEIGHT)/2 - 120.0f,
                                                                           133.0f,
                                                                           133.0f)];
    [exceptionView addSubview:imageView];
    imageView.image     = [self imageOfExceptionView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UILabel* label          = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                        imageView.bottom+10*displayScale,
                                                                        SCREEN_WIDTH,
                                                                        60.0f)];
    [exceptionView addSubview:label];
    label.font              = NormalFontWithSize(16.0f + fontScale);
    label.textColor         = COLOR_HM_GRAY;
    label.textAlignment     = NSTextAlignmentCenter;
    label.numberOfLines     = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor   = [UIColor clearColor];
    
    NSMutableAttributedString* attributedString     = [[NSMutableAttributedString alloc] init];
    [attributedString appendString:@"页面加载失败" withAttributes:ATTR_DICTIONARY(COLOR_HM_BLACK, 18.0f + fontScale)];
    //[attributedString addLine:2];
    //[attributedString appendString:@"请稍后再试" withAttributes:ATTR_DICTIONARY(COLOR_HM_DARK_GRAY, 14.0f + fontScale)];
    label.attributedText    = attributedString;
    
    
    UIButton* button        = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120.0f)/2,
                                                                         label.bottom+10*displayScale,
                                                                         120.0f,
                                                                         40.0f)];
    [exceptionView addSubview:button];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_HM_BLACK forState:UIControlStateNormal];
    button.titleLabel.font  = NormalFontWithSize(14.0f + fontScale);
    [button setBackgroundColor:COLOR_DEFAULT_WHITE];
    [button.layer setBorderWidth:0.5];
    [button.layer setBorderColor:COLOR_GRAY_MEDIUM.CGColor];
    [button.layer setCornerRadius:5.0];
    [button.layer setMasksToBounds:YES];
    [button addTarget:self action:@selector(onTryAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:exceptionView];
    
}


#pragma mark - ErrorView
- (void) showErrorView {
    
}

- (void) showErrorViewInView:(UIView *)view {
    
}


#pragma mark - NetworkView
- (void) showOffNetworkView {
    [self showOffNetworkViewInView:self.view];
}

- (void) showOffNetworkViewInView:(UIView *)view {
    
    UIView* exceptionView = [self exceptionViewInView:view];
    
    exceptionView.backgroundColor = COLOR_BACKGROUND_DARK;
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 107.0f)/2,
                                                                           (SCREEN_HEIGHT - 107.0f - TABBAR_HEIGHT)/2 - 80.0f,
                                                                           107.0f,
                                                                           107.0f)];
    [exceptionView addSubview:imageView];
    imageView.image        = [self imageOffNetworkView];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    
    
    UILabel* label          = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                        imageView.bottom+20*displayScale,
                                                                        SCREEN_WIDTH,
                                                                        60.0f)];
    [exceptionView addSubview:label];
    label.font              = NormalFontWithSize(16.0f + fontScale);
    label.textColor         = COLOR_GRAY_DARK;
    label.textAlignment     = NSTextAlignmentCenter;
    label.numberOfLines     = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor   = [UIColor clearColor];
    
    NSMutableAttributedString* attributedString     = [[NSMutableAttributedString alloc] init];
    [attributedString appendString:@"网络连接失败" withAttributes:ATTR_DICTIONARY(COLOR_BLACK_DARK, 18.0f + fontScale)];
    [attributedString addLine:2];
    [attributedString appendString:@"请检查您的手机是否联网" withAttributes:ATTR_DICTIONARY(COLOR_GRAY_DARK, 14.0f + fontScale)];
    label.attributedText    = attributedString;
    
    
    UIButton* button        = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100.0f)/2,
                                                                         label.bottom+20*displayScale,
                                                                         100.0f,
                                                                         30.0f)];
    [exceptionView addSubview:button];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_BLACK_DARK forState:UIControlStateNormal];
    button.titleLabel.font  = NormalFontWithSize(14.0f + fontScale);
    [button.layer setBorderWidth:0.5];
    [button.layer setBorderColor:COLOR_GRAY_MEDIUM.CGColor];
    [button.layer setCornerRadius:5.0];
    [button.layer setMasksToBounds:YES];
    [button addTarget:self action:@selector(onTryAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:exceptionView];
}


#pragma mark - NullDataView
- (void) showNullDataView {
    [self showNullDataViewInView:self.view];
}

- (void) showNullDataViewInView:(UIView *)view {
    
    UIView* exceptionView = [self exceptionViewInView:view];
    exceptionView.backgroundColor = COLOR_BACKGROUND_DARK;
    
    CGRect frame = view.frame;
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 80.0f * displayScale)/2,
                                                                           frame.size.height/3,
                                                                           80.0f * displayScale,
                                                                           80.0f * displayScale)];
    [exceptionView addSubview:imageView];
    imageView.image     = [self imageOfNullDataView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel* label      = [[UILabel alloc] initWithFrame:CGRectMake(30.0f,
                                                                    imageView.bottom+10*displayScale,
                                                                    frame.size.width - 60.0f,
                                                                    30.0f)];
    [exceptionView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText= [self titleOfNullDataView];
    [view addSubview:exceptionView];
}

- (void)showNullDataViewInView:(UIView *)view withTitle:(NSString *)title {
    UIView* exceptionView = [self exceptionViewInView:view];
    exceptionView.backgroundColor = COLOR_BACKGROUND_DARK;
    
    CGRect frame = view.frame;
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 80.0f * displayScale)/2,
                                                                           frame.size.height/3,
                                                                           80.0f * displayScale,
                                                                           80.0f * displayScale)];
    [exceptionView addSubview:imageView];
    imageView.image     = [self imageOfNullDataView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel* label      = [[UILabel alloc] initWithFrame:CGRectMake(30.0f,
                                                                    imageView.bottom+10*displayScale,
                                                                    frame.size.width - 60.0f,
                                                                    30.0f)];
    [exceptionView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText= [self titleOfNullDataViewWithTitle:title];
    [view addSubview:exceptionView];
}

- (UIView *)showNullDataViewWithFrame:(CGRect)frame iconName:(NSString *)icon tips:(NSString *)tips{
    
    UIView* exceptionView = [[UIView alloc] initWithFrame:frame];

    UIImage *image             = [NSString isBlankString:icon] ? [self imageOfNullDataView] : [UIImage imageNamed:icon];
    NSAttributedString *string = [NSString isBlankString:tips] ? [self titleOfNullDataView] : [[NSAttributedString alloc] initWithString:tips attributes:ATTR_DICTIONARY(COLOR_GRAY_MEDIUM, 16.0f)];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 80.0f * displayScale)/2,
                                                                           frame.size.height/3,
                                                                           80.0f * displayScale,
                                                                           80.0f * displayScale)];
    [exceptionView addSubview:imageView];
    imageView.image        = image;
    imageView.contentMode  = UIViewContentModeScaleAspectFit;

    UILabel* label      = [[UILabel alloc] initWithFrame:CGRectMake(30.0f,
                                                                    imageView.bottom+10*displayScale,
                                                                    frame.size.width - 60.0f,
                                                                    30.0f)];
    [exceptionView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText= string;
    
    
    
    return exceptionView;
}

- (UIView *)showNullDataViewWithSuperFrame:(CGRect)superFrame
                                  subFrame:(CGRect)subFrame
                                  iconName:(NSString *)icon
                                      tips:(NSString *)tips {
    
    UIView *view = [[UIView alloc] initWithFrame:subFrame];
    
    UIView* exceptionView = [[UIView alloc] initWithFrame:subFrame];
    [view addSubview:exceptionView];
    
    UIImage *image             = [NSString isBlankString:icon] ? [self imageOfNullDataView] : [UIImage imageNamed:icon];
    NSAttributedString *string = [NSString isBlankString:tips] ? [self titleOfNullDataView] : [[NSAttributedString alloc] initWithString:tips attributes:ATTR_DICTIONARY(COLOR_GRAY_MEDIUM, 16.0f)];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((subFrame.size.width - 80.0f * displayScale)/2,
                                                                           subFrame.size.height/3,
                                                                           80.0f * displayScale,
                                                                           80.0f * displayScale)];
    [exceptionView addSubview:imageView];
    imageView.image        = image;
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    
    UILabel* label      = [[UILabel alloc] initWithFrame:CGRectMake(30.0f,
                                                                    imageView.bottom+10*displayScale,
                                                                    subFrame.size.width - 60.0f,
                                                                    30.0f)];
    [exceptionView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText= string;
    
    return view;
}

- (UIView *)showNullDataViewWithFrame:(CGRect)frame
                             iconName:(NSString *)icon
                                 tips:(NSString *)tips
                          buttonTitle:(NSString *)title {
    
    UIView* exceptionView = [[UIView alloc] initWithFrame:frame];
    
    UIImage *image             = [NSString isBlankString:icon] ? [self imageOfNullDataView] : [UIImage imageNamed:icon];
    NSAttributedString *string = [NSString isBlankString:tips] ? [self titleOfNullDataView] : [[NSAttributedString alloc] initWithString:tips attributes:ATTR_DICTIONARY(COLOR_GRAY_MEDIUM, 18.0f)];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 133.0f * displayScale)/2,
                                                                           frame.size.height/6,
                                                                           133.0f * displayScale,
                                                                           133.0f * displayScale)];
    [exceptionView addSubview:imageView];
    imageView.image        = image;
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    
    UILabel* label      = [[UILabel alloc] initWithFrame:CGRectMake(30.0f,
                                                                    imageView.bottom+10*displayScale,
                                                                    frame.size.width - 60.0f,
                                                                    30.0f)];
    [exceptionView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText= string;
    
    
    UIButton* button        = [[UIButton alloc] initWithFrame:CGRectMake(15.f,
                                                                         label.bottom+35*displayScale,
                                                                         SCREEN_WIDTH - 30.f,
                                                                         45.f)];
    [exceptionView addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:COLOR_DEFAULT_WHITE forState:UIControlStateNormal];
    [button setBackgroundColor:COLOR_BLUE_DARK];
    [button.layer setCornerRadius:4];
    button.layer.masksToBounds = YES;
    button.titleLabel.font  = NormalFontWithSize(16.0f + fontScale);
    [button addTarget:self action:@selector(noDataAction) forControlEvents:UIControlEventTouchUpInside];
    
    return exceptionView;
}

#pragma mark - NotMoreDataView
- (UIView *)showNotMoreDataView {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            SCREEN_WIDTH,
                                                            50*displayScale)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*displayScale,
                                                               5*displayScale,
                                                               SCREEN_WIDTH-20*displayScale,
                                                               20*displayScale)];
    label.text     = @"已经全部加载完毕";
    label.font     = NormalFontWithSize(14.0+fontScale);
    label.textColor = COLOR_BLACK_LIGHT;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}

- (void) hideExceptionView {
    UIView* exceptionView = [self.view viewWithTag:TAG_OF_EXCEPTION_VIEW];
    if (exceptionView != nil) {
        [exceptionView removeFromSuperview];
    }
}


- (void) tryAgainAtExceptionView {
    
}

- (void) noDataAction {

}

- (UIImage*) imageOfExceptionView {
    return [UIImage imageNamed:@"noorder"];
}

- (UIImage*) imageOfErrorView {
    return [UIImage imageNamed:@"img_null.png"];
}

- (UIImage*) imageOffNetworkView {
    return [UIImage imageNamed:@"icon_exception_network.png"];
}

- (UIImage*) imageOfNullDataView{
    return [UIImage imageNamed:@"nonePackage.png"];
}


- (NSAttributedString*) titleOfNullDataView {
    return [self titleOfNullDataViewWithTitle:@"空࿐空࿐如࿐也࿐"];
}

- (NSAttributedString*) titleOfNullDataViewWithTitle:(NSString *)title {
    NSAttributedString* attributedString    = [[NSAttributedString alloc] initWithString:title
                                                                              attributes:ATTR_DICTIONARY(COLOR_GRAY_MEDIUM, 16.0f)];
    return attributedString;
}


#pragma mark - private
- (UIView*) exceptionViewInView:(UIView *)view {
    UIView* exceptionView = [view viewWithTag:TAG_OF_EXCEPTION_VIEW];
    if (exceptionView == nil) {
        
        exceptionView       = [[UIView alloc] initWithFrame:view.bounds];
        exceptionView.tag   = TAG_OF_EXCEPTION_VIEW;
        
    }
    
    [exceptionView removeFromSuperview];
    
    NSArray* subViews = exceptionView.subviews;
    for (UIView* view in subViews) {
        [view removeFromSuperview];
    }
    
    return exceptionView;
}

- (void) onTryAgain:(id)sender {
    [self tryAgainAtExceptionView];
}

@end



