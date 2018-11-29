//
//  HXPartnerBankViewController.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPartnerBankViewModel.h"
@protocol HXPartnerBankDelegate;
@interface HXPartnerBankViewController : UIViewController
@property (nonatomic,weak)id<HXPartnerBankDelegate>delegate;
@property (nonatomic,strong)HXPartnerBankViewModel * viewModel;
@end
@protocol HXPartnerBankDelegate<NSObject>
-(void)update;
@end
