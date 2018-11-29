//
//  HXMyPointsViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyPointsViewModel.h"
#import "HXMyPointsModel.h"

@implementation HXMyPointsViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        self.archiveType = 2;
        self.pageIndex = 1;
    }
    return self;
}
-(void)archiveMyPointsWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail{

    NSDictionary *body = @{
                           @"modifyType":[NSString stringWithFormat:@"%ld",self.archiveType],
                           @"page":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"rows":@"10"
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:MyMemberInfo parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.score = [responseNewModel.body objectForKey:@"currentScore"]? [[responseNewModel.body objectForKey:@"currentScore"] stringValue]:@"";
            if (self.pageIndex==1) {
                [self.dataArr removeAllObjects];
            }
            for (NSDictionary * dic in [responseNewModel.body objectForKey:@"mallScoreRecords"]) {
                
                HXMyPointsModel * model = [HXMyPointsModel mj_objectWithKeyValues:dic];
                NSLog(@"%@",model);
                if (model) {
                    
                    [self.dataArr addObject:model];
                }
            }
            returnBlock();
        }else {
            fail();
        }
    } failure:^(NSError *error) {
        fail();
        [MBProgressHUD hideHUDForView:self.controller.view];
        
    }];

}
-(NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
    
}
@end
