//
//  HXRecordDetaiViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/21.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRecordDetaiViewModel.h"
#import "HXLogisticsModel.h"

@implementation HXRecordDetaiViewModel
-(void)archiveOrderInformation {
    NSString * orderStr = [NSString stringWithFormat:@"订单编号：%@",self.detailModel.orderNo.length!=0?self.detailModel.orderNo:@""];
    NSString * orderTime = [NSString stringWithFormat:@"下单时间：%@",self.detailModel.createTime.length!=0?self.detailModel.createTime:@""];
    NSString * jylsStr = [NSString stringWithFormat:@"交易流水：%@",self.detailModel.payOrderId.length!=0?self.detailModel.payOrderId:@""];
    NSMutableArray * inforArr = [[NSMutableArray alloc] init];
    self.shopInforArr = [[NSMutableArray alloc] init];
    self.shopHeightArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.detailModel.logistics.count; i++) {
        
        HXLogisticsModel * model = [HXLogisticsModel mj_objectWithKeyValues:[self.detailModel.logistics objectAtIndex:i]];
        NSString * wldhStr = [NSString stringWithFormat:@"物流单号：%@",model.shippingNumber.length!=0?model.shippingNumber:@""];
        NSString * kdName;
        if ([model.shippingCompanyStatus intValue]==11) {
            
            kdName = [NSString stringWithFormat:@"承运物流：%@",model.shippingCompany.length!=0?model.shippingCompany:@""];
        }else {
            kdName = [NSString stringWithFormat:@"承运物流：%@",[ProfileManager  getExpressNameWithString:model.shippingCompanyStatus]];
        }
        NSString * kdState;
        if ([model.shippingExtraStatus intValue]==3) {
            kdState = [NSString stringWithFormat:@"物流状态：%@",model.shippingStatus.length!=0?model.shippingStatus:@""];
        }else {
            kdState = [NSString stringWithFormat:@"物流状态：%@",[ProfileManager  getExpressStateWithString:model.shippingExtraStatus]];
            
        }
        if (self.detailModel.logistics.count==1) {
            NSArray * arr = @[wldhStr,kdName,kdState];
            [inforArr addObject:arr];
        }else {
        NSString * shopInforStr = [NSString stringWithFormat:@"商品信息："];
        NSString * str = model.proName;
        
        [self.shopInforArr addObject:str];
        CGFloat height = [Helper heightOfString:str font:[UIFont systemFontOfSize:12] width:(SCREEN_WIDTH-82)];
        if (height<20) {
            [self.shopHeightArr addObject:@"17"];
        }else {
            [self.shopHeightArr addObject:[NSString stringWithFormat:@"%f",height]];
        }
        NSArray * arr = @[wldhStr,kdName,kdState,shopInforStr];
        [inforArr addObject:arr];
        }
    }
    self.inforArr = [[NSMutableArray alloc] init];
    switch (self.states) {
        case ShopStatuesCancel: {
            [self.inforArr addObjectsFromArray:@[@[orderStr,orderTime]]];
            self.headTitle = @"已取消";
        }
            break;
        case ShopStatuesSuccess: {
          [self.inforArr addObjectsFromArray:@[@[orderStr,jylsStr,orderTime]]];
            for (NSArray * arr in inforArr) {
                [self.inforArr addObject:arr];
            }
            self.headTitle = @"已完成";
        }
            break;
        case ShopStatuesArchive: {
            
           [self.inforArr addObjectsFromArray:@[@[orderStr,jylsStr,orderTime]]];
            for (NSArray * arr in inforArr) {
                [self.inforArr addObject:arr];
            }
            self.headTitle = @"已发货";
        }
            break;
        case ShopStatuesWait: {
            
            [self.inforArr addObjectsFromArray:@[@[orderStr,jylsStr,orderTime]]];
            self.headTitle = @"待发货";
        }
            break;
        case ShopStatuesGoing: {
            
            [self.inforArr addObjectsFromArray:@[@[orderStr,orderTime]]];
            self.headTitle = @"处理中";
        }
            break;
        case ShopStatesStock: {
            
            [self.inforArr addObjectsFromArray:@[@[orderStr,orderTime]]];
            self.headTitle = @"待支付";
        }
            break;
        case ShopStatuesWaitMoney: {
            
            [self.inforArr addObjectsFromArray:@[@[orderStr,orderTime]]];
            self.headTitle = @"待支付";
        }
            break;
        default:
            break;
    }
    
    
}

-(void)archiveRecordStatesWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *body = @{
                           @"orderId":self.model.id.length!=0?self.model.id:@"",
                           };
    [[HXNetManager shareManager] get:GetExchangeDetail parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.detailModel = [HXRecordDetailModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"orderInfo"]];
            if ([self.detailModel.orderStatus intValue]==1) {
                self.states = ShopStatuesWaitMoney;
            }else if ([self.detailModel.orderStatus intValue]==2){
                self.states = ShopStatuesGoing;
            }else if ([self.detailModel.orderStatus intValue]==3){
                self.states = ShopStatuesWait;
            }else if ([self.detailModel.orderStatus intValue]==4){
                self.states = ShopStatuesArchive;
            }else if ([self.detailModel.orderStatus intValue]==5){
                self.states = ShopStatuesSuccess;
            }else if ([self.detailModel.orderStatus intValue]==6){
                self.states = ShopStatuesCancel;
            }else {
                self.states = ShopStatuesCommen;
            }
            NSString * canrepay = [[responseNewModel.body objectForKey:@"orderInfo"] objectForKey:@"isEnable"];
            self.undercarriage = [canrepay boolValue];
            
            [self archiveOrderInformation];
            returnBlock();
            
        }else {
            failBlock();
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        failBlock();
    }];
}

-(void)changeRecordStateWithType:(NSString *)type returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    
    NSDictionary *body = @{
                           @"orderStatus":type,
                           @"orderId":_model.id.length!=0?_model.id:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:UpdateExchangeStatusUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            if([type intValue]== 5) {
                self.detailModel.shippingExtraStatus = @"2";
                self.states = ShopStatuesSuccess;
            }else if ([type intValue]==6) {
                [MBProgressHUD hideHUDForView:self.controller.view];
                self.states = ShopStatuesCancel;
                [self archiveOrderInformation];
            }
            returnBlock();
        }else {
            [MBProgressHUD hideHUDForView:self.controller.view];
            failBlock();
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        failBlock();
    }];
}
-(void)querypaymentWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    
    NSDictionary *body = @{
                           @"orderNo":self.model.orderNo.length!=0?self.model.orderNo:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:QueryPayResultUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            returnBlock(responseNewModel);
        }else {
            
            failBlock(responseNewModel);
        }
        
    } failure:^(NSError *error) {
        failBlock(nil);
    }];
    
    
    
    
}

-(void)changeShopClearWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *body = @{
                           @"orderNo":self.model.orderNo.length!=0?self.model.orderNo:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:ProductIsOnshelfUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            returnBlock();
        }else {
            [MBProgressHUD hideHUDForView:self.controller.view];
            if ([responseNewModel.status isEqualToString:@"0513"]) {
                failBlock(@"1");
            }else {
                failBlock(@"0");
            }
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        failBlock(@"0");
    }];
}


-(NSMutableArray *)shopArr {
    if (_shopArr == nil) {
        _shopArr = [[NSMutableArray alloc] init];
        [_shopArr addObject:@""];
        [_shopArr addObject:@""];
        [_shopArr addObject:@""];
        [_shopArr addObject:@""];
        [_shopArr addObject:@""];
        [_shopArr addObject:@""];
        [_shopArr addObject:@""];
    }
    return _shopArr;
}
@end
