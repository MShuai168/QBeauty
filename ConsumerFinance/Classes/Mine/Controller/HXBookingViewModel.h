//
//  HXBookingViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/16.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBookInfoModel.h"

typedef NS_ENUM(NSInteger, bookingStatus){
    bookingStatusAll,
    bookingStatusInProgress,
    bookingStatusSucess
};

@interface HXBookingViewModel : NSObject

@property (nonatomic, assign) bookingStatus bookingStatus;
@property (nonatomic, strong, readonly) NSArray *allBookings;
@property (nonatomic, strong, readonly) NSArray *inProgressBookings;
@property (nonatomic, strong, readonly) NSArray *sucessBookings;
@property (nonatomic,weak)UIViewController * controller;

@property (nonatomic, assign) BOOL refreshTable;

- (void)getOrderList;

@end
