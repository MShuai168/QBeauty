//
//  HXChangeInformationViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXChangeInformationViewModel.h"

@implementation HXChangeInformationViewModel
-(instancetype)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        
    }
    return self;
    
}

-(void)archiveInformationWithReturnBlock:(ReturnValueBlock)block failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:AchiveInformation parameters:@{} sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            
            self.model = [HXChangeInformationModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"partnerInfo"]];
            self.nameStr = self.model.name;
            self.iphoneStr = self.model.cellphone;
            self.identyStr = self.model.idCard;
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
@end
