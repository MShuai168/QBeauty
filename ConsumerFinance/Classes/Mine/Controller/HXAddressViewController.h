//
//  HXAddressViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXWKWebViewViewController.h"
#import "AddressModel.h"
#import "HXShopAddressModel.h"

typedef void(^block)(HXShopAddressModel *addressModel);

@interface HXAddressViewController : HXWKWebViewViewController

@property (nonatomic, copy) block returnAddress;

@end
