//
//  HXEvaluateViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXEvaluateViewModel.h"
#import "HXEvaluateModel.h"

@implementation HXEvaluateViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        
        _haveEvaluaIndex = 1;
        _evaluaIndex = 1;
    }
    return self;
    
}
-(void)archivePendingEvaluationWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail {
    
    NSDictionary *head = @{@"tradeCode" : @"0245",
                           @"tradeType" : @"appService"};
    
    NSDictionary *body = @{@"userUuid" : userUuid,
                           @"type":@"1",
                           @"page":[NSString stringWithFormat:@"%ld",self.evaluaIndex],
                           @"pageSize":@"10"
                           };
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         if (_evaluaIndex==1) {
                                                             [self.evaluationArr removeAllObjects];
                                                         }
                                                         for (NSDictionary * dic in [object.body objectForKey:@"voList"]) {
                                                             HXEvaluateModel * model = [HXEvaluateModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [self.evaluationArr addObject:model];
                                                             }
                                                         }
                                                         self.contNumber = [object.body objectForKey:@"count"]?[[object.body objectForKey:@"count"] integerValue]:0;
                                                         returnBlock();
                                                     }else {
                                                         fail();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     fail();
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
    
}
-(void)archiveHaveEvaluationWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail {
    
    NSDictionary *head = @{@"tradeCode" : @"0245",
                           @"tradeType" : @"appService"};
    
    NSDictionary *body = @{@"userUuid" : userUuid,
                           @"type":@"2",
                           @"page":[NSString stringWithFormat:@"%ld",self.haveEvaluaIndex],
                           @"pageSize":@"10"
                           };
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         if (_haveEvaluaIndex==1) {
                                                             [self.haveEvaluationArr removeAllObjects];
                                                         }
                                                         for (NSDictionary * dic in [object.body objectForKey:@"voList"]) {
                                                             HXEvaluateModel * model = [HXEvaluateModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [self.haveEvaluationArr addObject:model];
                                                             }
                                                         }
                                                         
                                                         returnBlock();
                                                     }else {
                                                         fail();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     fail();
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
    
}

-(void)showProjectView:(UIView *)view type:(NSInteger)type {
    if (self.projectStateView) {
        [self.projectStateView removeFromSuperview];
    }
    self.projectStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
        self.evaluaIndex = 1;
        if ([self.controller respondsToSelector:NSSelectorFromString(@"request")]){
            SEL selector = NSSelectorFromString(@"request");
            IMP imp = [self.controller methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self.controller, selector);
            [MBProgressHUD showMessage:nil toView:self.controller.view];
            
        }
    }];
}
-(void)showItemView:(UIView *)view  type:(NSInteger)type{
    if (self.itemStateView) {
        [self.itemStateView removeFromSuperview];
    }
    self.itemStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
        self.haveEvaluaIndex = 1;
        if ([self.controller respondsToSelector:NSSelectorFromString(@"archiveHaveEvaluation")]){
            SEL selector = NSSelectorFromString(@"archiveHaveEvaluation");
            IMP imp = [self.controller methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self.controller, selector);
            [MBProgressHUD showMessage:nil toView:self.controller.view];
            
        }
    }];
    
}

-(NSMutableArray *)evaluationArr {
    if (_evaluationArr == nil) {
        _evaluationArr = [[NSMutableArray alloc] init];
    }
    return _evaluationArr;
    
    
}
-(NSMutableArray *)haveEvaluationArr {
    if (_haveEvaluationArr==nil) {
        _haveEvaluationArr = [[NSMutableArray alloc] init];
    }
    return _haveEvaluationArr;
    
    
}
@end
