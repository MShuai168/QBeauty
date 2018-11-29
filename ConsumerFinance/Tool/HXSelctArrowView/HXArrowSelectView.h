//
//  HXArrowSelectView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectBlock)();
@interface HXArrowSelectView : UIView
@property (nonatomic,strong)selectBlock selectBlock;
- (instancetype)initWithOrigin:(CGPoint)origin selectBlock:(selectBlock)selectBlock;
- (void)popView;
@end
