//
//  HXApplyWithdrawViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXApplyWithdrawViewModel.h"

@implementation HXApplyWithdrawViewModel

-(void)archiveApplyBankInformationWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:PartnerApplyMoney parameters:@{} sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.model = [HXApplyWithdrawModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"info"]];
            self.model.minMoney = [responseNewModel.body objectForKey:@"minMoney"];
            self.model.minMoney = self.model.minMoney.length!=0?self.model.minMoney:@"0.00";
            self.careful = [responseNewModel.body objectForKey:@"careful"];
            if (returnBlock) {
                returnBlock();
            }
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (failBlock) {
            failBlock();
        }
    }];

}

-(void)submitApplyWithdrawWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    NSDictionary * dic =@{@"withdrawalsMoney":self.applyMoeny.length!=0?self.applyMoeny:@"0",
                          @"accountName":self.model.accountName.length!=0?self.model.accountName:@"",
                          @"bankName":self.model.bankName.length!=0?self.model.bankName:@"",
                          @"branch":self.model.branch.length!=0?self.model.branch:@"",
                          @"cardNo":self.model.cardNo.length!=0?self.model.cardNo:@""
                          };
    [[HXNetManager shareManager] post:PartnerWithdrawMoney parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            if (returnBlock) {
                returnBlock();
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (failBlock) {
            failBlock();
        }
        
    }];

}


@end
