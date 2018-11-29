//
//  HXBookingViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/16.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBookingViewModel.h"

#import "HXBookingTableViewCellViewModel.h"

@interface HXBookingViewModel()

@property (nonatomic, strong, readwrite) NSMutableArray *allBookings;
@property (nonatomic, strong, readwrite) NSMutableArray *inProgressBookings;
@property (nonatomic, strong, readwrite) NSMutableArray *sucessBookings;

@end

@implementation HXBookingViewModel

- (instancetype)init {
    if (self == [super init]) {
        _allBookings = [[NSMutableArray alloc] init];
        _inProgressBookings = [[NSMutableArray alloc] init];
        _sucessBookings = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)getOrderList {
    NSDictionary *head = @{@"tradeCode" : @"0133",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{};
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPhone];
    switch (self.bookingStatus) {
        case bookingStatusAll:
            body = @{@"status" : @"",
                     @"userPhone" : phone.length!=0?phone:@"",
                     @"pages":@"1",
                     @"rows":@"10"
                     };
            break;
        case bookingStatusInProgress:
            body = @{@"status" : @"33",
                     @"userPhone" : phone.length!=0?phone:@"",
                     @"pages":@"1",
                     @"rows":@"10"
                     };
            break;
        case bookingStatusSucess:
            body = @{@"status" : @"40",
                     @"userPhone" : phone.length!=0?phone:@"",
                     @"pages":@"1",
                     @"rows":@"10"
                     };
            break;
            
        default:
            break;
    }
    
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSArray *bookings = [object.body objectForKey:@"orderReservations"];
                                                         [self paddingOrder:bookings];
                                                         self.refreshTable = YES;
                                                     }
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                 }];
    
}

- (void)paddingOrder:(NSArray *)orders {
    [_allBookings removeAllObjects];
    [_inProgressBookings removeAllObjects];
    [_sucessBookings removeAllObjects];
    
    [orders enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXBookInfoModel *bookInfo = [HXBookInfoModel mj_objectWithKeyValues:obj];
        
        HXBookingTableViewCellViewModel *viewModel = [[HXBookingTableViewCellViewModel alloc] init];
        viewModel.bookingNumber = bookInfo.reservationNo;
        viewModel.comment = bookInfo.remarks;
        viewModel.status = bookingDetailSucess;
        
        if ([bookInfo.status isEqualToString:@"40"]) {
            viewModel.status = bookingDetailSucess;
        } else if ([bookInfo.status isEqualToString:@"30"]){
            viewModel.status = bookingDetailCancel;
        } else {
            viewModel.status = bookingDetailInProgress;
        }
        
        switch (viewModel.status) {
            case bookingDetailSucess:
                viewModel.recommendCompany = bookInfo.merchantName;
                viewModel.accountManager = bookInfo.saleName;
                viewModel.accountManagerTel = bookInfo.cellphone;
                viewModel.successTime = bookInfo.upTime;
                break;
            case bookingDetailCancel:
                viewModel.cancelTime = bookInfo.upTime;
                break;
            case bookingDetailInProgress:
                viewModel.commintTime = bookInfo.createdTime;
                break;
                
            default:
                break;
        }
        
        
        viewModel.companyName = bookInfo.productName;
        viewModel.address = bookInfo.companyAddress;
        viewModel.logo = bookInfo.icon;
        
        viewModel.bookingPerson = bookInfo.name;
        viewModel.bookingIphone = bookInfo.phone;
        
        viewModel.commintTime = bookInfo.createdTime;
        
        switch (self.bookingStatus) {
            case bookingStatusAll:
                [_allBookings addObject:viewModel];
                break;
            case bookingStatusInProgress:
                [_inProgressBookings addObject:viewModel];
                break;
            case bookingStatusSucess:
                [_sucessBookings addObject:viewModel];
                break;
                
            default:
                break;
        }
        
    }];
}


@end
