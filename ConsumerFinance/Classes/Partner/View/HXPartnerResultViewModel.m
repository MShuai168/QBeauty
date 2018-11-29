//
//  HXPartnerResultViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/1.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerResultViewModel.h"

@implementation HXPartnerResultViewModel
-(void)archiveResultWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    NSDictionary * dic =@{@"id":self.id.length!=0?self.id:@""
                          };
    [[HXNetManager shareManager] get:PartnerResult parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.resultModel = [HXPartnerResultModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"packageOrder"]];
            if ([self.resultModel.orderStatus isEqualToString:@"0"]) {
                self.orderStates = PartnerOrderStatesUnpaid;
            }else if([self.resultModel.orderStatus isEqualToString:@"1"]) {
                self.orderStates = PartnerOrderStatesPaid;
            }else {
                self.orderStates = PartnerOrderStatesCancel;
            }
            
            self.isPartner = [responseNewModel.body objectForKey:@"isPartner"];
            self.informationModel = [HXChangeInformationModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"partnerInfo"]];
            self.nameStr = self.informationModel.name;
            self.iphoneStr = self.informationModel.cellphone;
            self.identyStr = self.informationModel.idCard;
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


-(void)submitCanceltWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    NSDictionary * dic =@{@"id":self.id.length!=0?self.id:@""
                          };
    [[HXNetManager shareManager] post:PartnerOrderCancel parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.resultModel.overTime = [responseNewModel.body objectForKey:@"overTime"];
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
-(void)submitInformationWithReturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    NSString * url  = ChangeInformation;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":self.nameStr.length!=0?self.nameStr:@"",
                                                                                  @"cellPhone":self.iphoneStr.length!=0?self.iphoneStr:@"",
                                                                                  @"idCard":self.identyStr.length!=0?self.identyStr:@""
                                                                                  }];
    [[HXNetManager shareManager] post:url parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
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
-(void)archiveFailWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    NSDictionary * dic =@{@"id":self.id.length!=0?self.id:@""
                          };
    [[HXNetManager shareManager] get:PartnerOrderFail parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.refuseReason  = [[responseNewModel.body objectForKey:@"partnerWithdrawals"] objectForKey:@"refuseReason"];
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
