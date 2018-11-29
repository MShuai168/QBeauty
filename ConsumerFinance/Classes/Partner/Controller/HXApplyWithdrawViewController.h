//
//  HXApplyWithdrawViewController.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXApplyWithdrawViewModel.h"
@protocol applyWithdrawDelegate;
@interface HXApplyWithdrawViewController : UIViewController
@property (nonatomic,strong)HXApplyWithdrawViewModel * viewModel;
@property (nonatomic,weak)id<applyWithdrawDelegate>delegate;
@end
@protocol applyWithdrawDelegate<NSObject>
-(void)update;
@end
