//
//  HXPartnerResultViewController.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPartnerResultViewModel.h"
@protocol partnerResultDlegate;
@interface HXPartnerResultViewController : UIViewController
@property (nonatomic,strong)HXPartnerResultViewModel * viewModel;
@property (nonatomic,weak)id<partnerResultDlegate>delegate;
@end
@protocol partnerResultDlegate<NSObject>
-(void)update;
@end
