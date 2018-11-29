//
//  ReservationDetailVC.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/23.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationDetailVC : UIViewController

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *reserveStatusName;
@property (nonatomic, copy) NSString *reserveDate;

@end
