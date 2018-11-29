//
//  HXMyTeamViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyTeamViewModel.h"
#import "HXMyteamModel.h"
@implementation HXMyTeamViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        self.pageIndex = 1;
    }
    return self;
}
-(void)archiveInformationWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    NSDictionary * dic =@{@"page":[NSString stringWithFormat:@"%ld",self.pageIndex],
                          @"rows":@"10"
                          };
    [[HXNetManager shareManager] get:PartnerMyteam parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            if (self.pageIndex==1) {
                [self.teamArr removeAllObjects];
            }
            for (NSDictionary * dic in [responseNewModel.body objectForKey:@"voByPage"]) {
              HXMyteamModel *  model = [HXMyteamModel mj_objectWithKeyValues:dic];
                if (model) {
                    
                    [self.teamArr addObject:model];
                }
            }
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
-(NSMutableArray *)teamArr{
    if (_teamArr == nil) {
        _teamArr = [[NSMutableArray alloc] init];
    }
    return _teamArr;
}
@end
