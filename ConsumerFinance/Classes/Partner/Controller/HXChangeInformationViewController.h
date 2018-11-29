//
//  HXChangeInformationViewController.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXChangeInformationViewModel.h"
@protocol HXChangeInforDelegate;
@interface HXChangeInformationViewController : UIViewController
@property (nonatomic,strong)HXChangeInformationViewModel * viewModel;
@property (nonatomic,weak)id<HXChangeInforDelegate>delegate;
@end
@protocol HXChangeInforDelegate<NSObject>
-(void)updateStates;
@end
