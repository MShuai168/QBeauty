//
//  HXMyMemberViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/20.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyMemberViewModel.h"
#import "HXShopCarModel.h"
@implementation HXMyMemberViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        self.page = 1;
    }
    return self;
}
-(void)archiveMemberWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:GetMemberUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.model = [HXMyMemberModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"myMember"]];
            returnBlock();
        }else {
            fail();
        }
    } failure:^(NSError *error) {
        fail();
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
    
    
    
}
-(void)archivewRecommendProduceWithSuccessBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *body = @{
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                           @"pageSize":@"10",
                           @"strRecommendOnly":@"false"
                           };
    [[HXNetManager shareManager] get:RecommendProductUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            if (self.page==1) {
                [self.recomendArr removeAllObjects];
            }
            for (NSDictionary * dic in [responseNewModel.body objectForKey:@"recommendProductList"]) {
                HXShopCarModel * model = [HXShopCarModel mj_objectWithKeyValues:dic];
                if (model) {
                    
                    [self.recomendArr addObject:model];
                }
            }
            returnBlock();
        }else {
            failBlock();
        }
        
    } failure:^(NSError *error) {
        failBlock();
    }];
    
    
    
}
-(NSMutableArray *)recomendArr {
    if (_recomendArr==nil) {
        _recomendArr = [[NSMutableArray alloc] init];
    }
    return _recomendArr;
}


@end
