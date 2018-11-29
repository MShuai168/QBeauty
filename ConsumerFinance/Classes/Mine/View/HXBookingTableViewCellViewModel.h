//
//  HXBookingTableViewCellViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/16.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, bookingDetailStatus){
    bookingDetailCancel,
    bookingDetailInProgress,
    bookingDetailSucess
};

@interface HXBookingTableViewCellViewModel : NSObject

@property (nonatomic, strong) NSString *bookingNumber;
@property (nonatomic, assign) bookingDetailStatus status;

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *bookingPerson; //预约人
@property (nonatomic, strong) NSString *bookingIphone; //预约手机
@property (nonatomic, strong) NSString *comment; //备注

@property (nonatomic, strong) NSString *recommendCompany;// 推荐商户
@property (nonatomic, strong) NSString *accountManager; // 客户经理
@property (nonatomic, strong) NSString *accountManagerTel;// 联系手机

@property (nonatomic, strong) NSString *commintTime;
@property (nonatomic, strong) NSString *successTime;
@property (nonatomic, strong) NSString *cancelTime;

@end
