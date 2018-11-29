//
//  HXPartnerBankViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerBankViewModel.h"

@implementation HXPartnerBankViewModel
-(void)archiveBankInformationWithReuturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:PartnerBankInformation parameters:@{} sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
        self.model = [HXPartnerBankModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"partnerInfo"]];
        self.nameStr = self.model.accountName;
        self.cardStr = self.model.cardNo;
        self.bankStr = self.model.bankName;
        self.subbranchStr = self.model.branch;
        if (block) {
            block();
        }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (failBlock) {
            failBlock();
        }
    }];
    
    
}

-(void)submitBankInformationWithReuturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    NSDictionary * dic = @{@"accountName":self.nameStr.length!=0?self.nameStr:@"",
                           @"bankName":self.bankStr.length!=0?self.bankStr:@"",
                           @"branch":self.subbranchStr.length!=0?self.subbranchStr:@"",
                           @"cardNo":self.cardStr.length!=0?self.cardStr:@""
                           };
    [[HXNetManager shareManager] post:PartnerSubmitBankInformation parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            [KeyWindow displayMessage:@"保存成功"];
            if (block) {
                block();
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
