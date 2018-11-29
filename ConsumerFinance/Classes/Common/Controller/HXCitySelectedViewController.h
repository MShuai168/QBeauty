//
//  HXCitySelectedViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXCitySelectedViewModel.h"

typedef void(^changeCity)(NSString *city);

@interface HXCitySelectedViewController : UIViewController

@property (nonatomic, strong) changeCity changeCity;
@property (nonatomic, strong) HXCitySelectedViewModel *viewModel;

@end
