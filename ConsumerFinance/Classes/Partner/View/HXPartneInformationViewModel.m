//
//  HXPartneInformationViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartneInformationViewModel.h"

@implementation HXPartneInformationViewModel
-(instancetype)initWithController:(UIViewController *)controller{
    self = [super initWithController:controller];
    if (self) {
        
    }
    return self;
}
-(void)archiceInformationWithReturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock {
   
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:PersonInformation parameters:@{} sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.model = [HXPartneInformationModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"partnerInfo"]];
            self.inviterCodeStr = self.model.inviterCode;
            self.nameStr = self.model.name;
            self.gradeNameStr = self.model.gradeName;
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
