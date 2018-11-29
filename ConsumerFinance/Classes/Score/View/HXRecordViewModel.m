//
//  HXRecordViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/25.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRecordViewModel.h"

@implementation HXRecordViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        self.allDataArr = [[NSMutableArray alloc] init];
        self.dfKDataArr = [[NSMutableArray alloc] init];
        self.dshDataArr = [[NSMutableArray alloc] init];
        self.haveSuccessDataArr = [[NSMutableArray alloc] init];
        self.haveCancelDataArr = [[NSMutableArray alloc] init];
        self.allPage = 1;
        self.dfkPage = 1;
        self.dshPage =1;
        self.suceessPage = 1;
        self.canPage = 1;
    }
    return self;
}
-(void)changeRecordStateWithOrderId:(NSString *)orderId returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
  
    NSDictionary *body = @{
                           @"orderStatus":@"5",
                           @"orderId":orderId.length!=0?orderId:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:UpdateExchangeStatusUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
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

-(void)cancelRecordStateWithOrderId:(NSString *)orderId returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    
    NSDictionary *body = @{
                           @"orderStatus":@"6",
                           @"orderId":orderId.length!=0?orderId:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:UpdateExchangeStatusUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
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
-(void)changeShopClear:(HXRecordModel *)model returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
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

-(void)archiveRecodDataType:(NSString *)type returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSInteger page;
    if (type.length==0) {
        page = self.allPage;
    }else if ([type intValue]==1) {
        page =  self.dfkPage;
    }else if ([type intValue]==2) {
        page = self.dshPage;
    }else if ([type intValue]==5) {
        page = self.suceessPage;
    }else {
        page = self.canPage;
        
    }

    NSDictionary *body = @{
                           @"orderStatus":type.length!=0?type:@"",
                           @"page":[NSString stringWithFormat:@"%ld",page],
                           @"pageSize":@"10"
                           };
    [[HXNetManager shareManager] get:GetExchangeListUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            [self cleanData:type];
            for (NSDictionary * dic in [responseNewModel.body objectForKey:@"orderList"]) {
                HXRecordModel * model;
                model = [HXRecordModel mj_objectWithKeyValues:[dic objectForKey:@"product"]];
                if (!model) {
                    model = [[HXRecordModel alloc] init];
                }
                model.orderNo = [dic objectForKey:@"orderNo"]?[dic objectForKey:@"orderNo"]:@"";
                model.id = [dic objectForKey:@"id"]?[[dic objectForKey:@"id"] stringValue]:@"";
                model.orderStatus = [dic objectForKey:@"orderStatus"]?[[dic objectForKey:@"orderStatus"] stringValue]:@"";
                model.totalAmount = [dic objectForKey:@"totalAmount"]?[[dic objectForKey:@"totalAmount"] stringValue]:@"";
                model.totalScore = [dic objectForKey:@"totalScore"]?[[dic objectForKey:@"totalScore"] stringValue]:@"";
                model.isEnable = [dic objectForKey:@"isEnable"]?[[dic objectForKey:@"isEnable"] stringValue]:@"";
                if (type.length==0) {
                    [self.allDataArr addObject:model];
                }else if([type isEqualToString:@"1"]) {
                    [self.dfKDataArr addObject:model];
                }else if([type isEqualToString:@"2"]) {
                    [self.dshDataArr addObject:model];
                }else if([type isEqualToString:@"5"]) {
                    [self.haveSuccessDataArr addObject:model];
                }else  {
                    [self.haveCancelDataArr addObject:model];
                }
            }
            returnBlock(type);
        }else {
            failBlock(type);
        }
        
    } failure:^(NSError *error) {
        failBlock(type);
    }];
    
    
    
}
-(void)querypaymentWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *body = @{
                           @"orderNo":self.model.orderNo.length!=0?self.model.orderNo:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:QueryPayResultUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            returnBlock(responseNewModel);
        }else {
            
            failBlock(responseNewModel);
        }
        
    } failure:^(NSError *error) {
        failBlock(nil);
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
}
-(void)cleanData:(NSString *)type {
    if (type.length==0) {
        if (self.allPage==1) {
            [self.allDataArr removeAllObjects];
        }
    }else if([type isEqualToString:@"1"]) {
        if (self.dfkPage==1) {
            [self.dfKDataArr removeAllObjects];
        }
    }else if([type isEqualToString:@"2"]) {
        if (self.dshPage==1) {
            [self.dshDataArr removeAllObjects];
        }
    }else if([type isEqualToString:@"5"]) {
        if (self.suceessPage==1) {
            [self.haveSuccessDataArr removeAllObjects];
        }
    }else  {
        if (self.canPage==1) {
            [self.haveCancelDataArr removeAllObjects];
        }
    }
    
}

-(void)showItemView:(UIView *)view  type:(NSInteger)type kindType:(NSString *)kindType{
    if (kindType.length==0) {
        if (self.comStateView) {
            [self.comStateView removeFromSuperview];
        }
        self.comStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
            self.allPage = 1;
            [self click:kindType];
        }];
    }else if ([kindType intValue]==1) {
        if (self.dfkStateView) {
            [self.dfkStateView removeFromSuperview];
        }
        self.dfkStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
            self.dfkPage = 1;
            [self click:kindType];
        }];
        
        
    }else if ([kindType intValue]==2) {
        if (self.dshStateView) {
            [self.dshStateView removeFromSuperview];
        }
        self.dshStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
            self.dshPage = 1;
            [self click:kindType];
        }];
        
        
    }else if ([kindType intValue]==5) {
        if (self.havSuccessStateView) {
            [self.havSuccessStateView removeFromSuperview];
        }
        self.havSuccessStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
            self.suceessPage = 1;
            [self click:kindType];
        }];
        
        
    }else {
        
        if (self.cancelStateView) {
            [self.cancelStateView removeFromSuperview];
        }
        self.cancelStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
            self.canPage = 1;
            [self click:kindType];
        }];
        
        
    }
}
-(void)click:(NSString *)type {
    if ([self.controller respondsToSelector:NSSelectorFromString(@"request:")]){
        SEL selector = NSSelectorFromString(@"request:");
        IMP imp = [self.controller methodForSelector:selector];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self.controller, selector,type);
        self.openHdBool = YES;
        [MBProgressHUD showMessage:nil toView:self.controller.view];
    }
}

@end
