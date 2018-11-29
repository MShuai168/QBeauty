//
//  HXConfirmOrderViewControllerViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/21.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXConfirmOrderViewControllerViewModel.h"

@interface HXConfirmOrderViewControllerViewModel()

@property (nonatomic, strong, readwrite) NSMutableArray *customers;
@property (nonatomic, strong, readwrite) NSMutableArray *projects;
@property (nonatomic, strong, readwrite) NSMutableArray *hireInfos;

@end

@implementation HXConfirmOrderViewControllerViewModel

- (instancetype)init {
    if (self == [super init]) {
        _customers = [[NSMutableArray alloc] init];
        _projects = [[NSMutableArray alloc] init];
        _hireInfos = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)paddingData:(NSDictionary *)dic {
    // customers
    
    [_customers addObject:@{@"姓名":self.orderInfo.name}];
    [_customers addObject:@{@"手机号":self.orderInfo.phone}];
    [_customers addObject:@{@"身份证":self.orderInfo.idCard}];
    
    switch (self.orderType) {
        case orderTypeCommon:
            [_projects addObject:@{@"商户名称":self.orderInfo.merchantName}];
            [_projects addObject:@{@"项目名称":self.orderInfo.productName}];
            [_projects addObject:@{@"备注":self.orderInfo.remark}];
            
            [_hireInfos addObject:@{@"商品金额":self.orderInfo.productPrice}];
            [_hireInfos addObject:@{@"首付金额":self.orderInfo.firstPayment}];
            [_hireInfos addObject:@{@"申请金额":self.orderInfo.stagesMoney}];
            break;
        case orderTypeTenancy:
            [_projects addObject:@{@"商户名称":self.orderInfo.merchantName}];
            [_projects addObject:@{@"小区名称":self.orderInfo.communityName}];
            [_projects addObject:@{@"详细地址":self.orderInfo.detailAddress}];
            [_projects addObject:@{@"月租金":self.orderInfo.rent}];
            [_projects addObject:@{@"备注":self.orderInfo.remark}];
            
            [_hireInfos addObject:@{@"商品金额":self.orderInfo.productPrice}];
            [_hireInfos addObject:@{@"首付金额":self.orderInfo.firstPayment}];
            [_hireInfos addObject:@{@"申请金额":self.orderInfo.stagesMoney}];
            break;
        case orderTypeHoneymoon:
            [_projects addObject:@{@"旅游形式":[self.orderInfo paddingTourismType:self.orderInfo.tourismType]}];
            [_projects addObject:@{@"出发时间":self.orderInfo.estimatedTime}];
            [_projects addObject:@{@"出发地":self.orderInfo.departure}];
            [_projects addObject:@{@"目的地":self.orderInfo.destination}];
            [_projects addObject:@{@"备注":self.orderInfo.remark}];
            
            [_hireInfos addObject:@{@"商品金额":self.orderInfo.productPrice}];
            [_hireInfos addObject:@{@"首付金额":self.orderInfo.firstPayment}];
            [_hireInfos addObject:@{@"申请金额":self.orderInfo.stagesMoney}];
            break;
        case orderTypeCarBuy:
            [_projects addObject:@{@"4S店":self.orderInfo.merchantName}];
            [_projects addObject:@{@"汽车型号":self.orderInfo.productName}];
            [_projects addObject:@{@"购车形式":[self.orderInfo paddingBuyType:self.orderInfo.buyType]}];
            [_projects addObject:@{@"备注":self.orderInfo.remark}];
            
            [_hireInfos addObject:@{@"净车价":self.orderInfo.productPrice}];
            [_hireInfos addObject:@{@"上牌费":self.orderInfo.licenseFee}];
            [_hireInfos addObject:@{@"保险费":self.orderInfo.insurance}];
            [_hireInfos addObject:@{@"购置税":self.orderInfo.purchaseTax}];
            [_hireInfos addObject:@{@"首付金额":self.orderInfo.firstPayment}];
            [_hireInfos addObject:@{@"申请额度":self.orderInfo.stagesMoney}];
            break;
        case orderTypeCarRent:
            [_projects addObject:@{@"4S店":self.orderInfo.merchantName}];
            [_projects addObject:@{@"汽车型号":self.orderInfo.productName}];
            [_projects addObject:@{@"购车形式":[self.orderInfo paddingBuyType:self.orderInfo.buyType]}];
            [_projects addObject:@{@"备注":self.orderInfo.remark}];
            
            [_hireInfos addObject:@{@"商品金额":self.orderInfo.productPrice}];
            [_hireInfos addObject:@{@"首付金额":self.orderInfo.firstPayment}];
            [_hireInfos addObject:@{@"申请金额":self.orderInfo.stagesMoney}];
            break;
            
        default:
            break;
    }
    
    
}

//- (void)setOrderType:(orderType)orderType {
//    _orderType = orderType;
//    
//    [self paddingData:nil];
//}

@end
