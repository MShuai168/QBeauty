//
//  Nav.m
//  CustomPopAnimation
//
//  Created by Jazys on 15/3/30.
//  Copyright (c) 2015年 Jazys. All rights reserved.
//

#import "Nav.h"
#import "AppDelegate.h"
#import "NavigationInteractiveTransition.h"

@interface Nav () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;
@end

@implementation Nav

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:ColorWithHex(0x131313),NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    self.navigationBar.titleTextAttributes = dict;
    self.navigationBar.barTintColor = ColorWithHex(0xFFFFFF);
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToController) name:@"transitionWasDone" object:nil];
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
//#if USE_方案一
    //_navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    //[popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    
//#elif USE_方案二
    /**
     *  获取系统手势的target数组
     */
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    /**
     *  通过前面的打印，我们从控制台获取出来它的方法签名。
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
//#endif
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
    /*
    CGPoint translation = [panGesture translationInView:self.view];
    NSLog(@"  * self.frame  = %@", NSStringFromCGRect(self.view.frame));
    NSLog(@"  * translation = %@", NSStringFromCGPoint(translation));
    NSLog(@"  * velocity    = %@", NSStringFromCGPoint([panGesture velocityInView:self.view]));
    NSLog(@"  * location    = %@", NSStringFromCGPoint([panGesture locationInView:self.view]));
    
    NSLog(@"  * superview.frame  = %@", NSStringFromCGRect(self.view.superview.frame));
    NSLog(@"  * supertranslation = %@", NSStringFromCGPoint([panGesture translationInView:self.view.superview]));
    NSLog(@"  * supervelocity    = %@", NSStringFromCGPoint([panGesture velocityInView:self.view.superview]));
    NSLog(@"  * superlocation    = %@", NSStringFromCGPoint([panGesture locationInView:self.view.superview]));
     */
    
    CGPoint location = [panGesture locationInView:self.view];
    if (location.x > 100) {
        return NO;
    }
    CGPoint point = [panGesture velocityInView:self.view];
//    NSLog(@"%f,%f",point.x,point.y);
    if (point.x < 0) {
        return NO;
    }
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (app.notPop){
        return NO;
    }
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
    
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
/*
- (void) popToController{
    if ([self.navDelegate respondsToSelector:@selector(navDelegatePopToViewController)]) {
        [self.navDelegate navDelegatePopToViewController];
    }
}
*/
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
