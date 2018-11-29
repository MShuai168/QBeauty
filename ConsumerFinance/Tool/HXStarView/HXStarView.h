//
//  HXStarView.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/31.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectStar)();
typedef NS_ENUM(NSUInteger, HXStarViewStyle) {
    HXStarViewStyleShow, // 展示用的
    HXStarViewStyleRate // 评价页面用的
};
@interface HXStarView : UIView

//- (instancetype)initWithFrame:(CGRect)frame withStarViewStyle:(HXStarViewStyle)starViewStyle;

@property (nonatomic, assign) double star; // 显示的时候，需要制定值
@property (nonatomic, assign) HXStarViewStyle starViewStyle;
@property (nonatomic,assign)NSInteger selectStar; //选取的数值
@property (nonatomic,strong)selectStar selectBlock;

@end
