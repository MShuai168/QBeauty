//
//  BookingViewController.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/9/5.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnBlock)(NSString *str);

@interface BookingViewController : UIViewController
@property (nonatomic, copy) NSString *tenantId; //门店ID
@property (nonatomic, copy) NSString *nameStr; //门店名称
@property (nonatomic, copy) NSString *address; //门店详细地址
@property (nonatomic, copy) returnBlock block;
@end
