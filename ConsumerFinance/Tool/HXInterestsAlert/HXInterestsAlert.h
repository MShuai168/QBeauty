//
//  HXInterestsAlert.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXInterestsAlert : UIView
@property (strong, nonatomic) void (^sureBlock)();
-(id)initWithSureBlock:(void (^)())block;
@end
