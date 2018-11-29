//
//  HXSelctArrowView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, XTDirectionType) {
    XTTypeOfLeftUp,
    XTTypeOfUpLeft,
    XTTypeOfUpCenter,
    XTTypeOfUpRight,
    XTTypeOfDownLeft,
    XTTypeOfDownCenter,
    XTTypeOfDownRight,
    XTTypeOfLeftCenter,
    XTTypeOfLeftDown,
    XTTypeOfRightCenter,
    XTTypeOfRightDown,
    XTTypeOfRightUp
};
@protocol selectIndexPathDelegate;

@interface HXSelctArrowView : UIView
// backGoundView
@property (nonatomic, strong) UIView * _Nonnull backGoundView;
// titles
@property (nonatomic, strong) NSArray * _Nonnull dataArray;
// images
@property (nonatomic, strong) NSArray * _Nonnull images;
// height
@property (nonatomic, assign) CGFloat row_height;
// font
@property (nonatomic, assign) CGFloat fontSize;
// textColor
@property (nonatomic, assign) UIColor * _Nonnull titleTextColor;
// delegate
@property (nonatomic, assign) id <selectIndexPathDelegate> _Nonnull delegate;
@property (nonatomic,strong)UITableView * _Nullable backTableView;
// 初始化方法
- (instancetype _Nonnull)initWithOrigin:(CGPoint) origin
                                  Width:(CGFloat) width
                                 Height:(CGFloat) height
                                   Type:(XTDirectionType)type
                                  Color:( UIColor * _Nonnull ) color;
- (void)popView;
- (void)dismiss;
@end
@protocol selectIndexPathDelegate <NSObject>
- (void)selectIndexPathRow:(NSInteger )index;
@end
