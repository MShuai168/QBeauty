//
//  HXAllEvaluationViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXAllEvaluationViewModel.h"


@implementation HXAllEvaluationViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        self.commentIndex = 1;
    }
    return self;
}
-(void)archiveEvaluationDetailWithReturnBlock:(ReturnValueBlock)returnBlock {
    NSDictionary *head = @{@"tradeCode" : @"0247",
                           @"tradeType" : @"appService"};
    
    NSDictionary *body = @{@"userUuid" : userUuid,
                           @"orderNo":self.model.orderNo?self.model.orderNo:@"",
                           @"commentId":self.model.commentId?self.model.commentId:@""
                           };
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSDictionary * dic = [object.body objectForKey:@"comment"];
                                                         self.hxcModel =  [HXCommentModel mj_objectWithKeyValues:dic];
                                                         [self.hxcModel adjustModel:dic];
                                                         returnBlock();
                                                     }
                                                 } fail:^(ErrorModel *error) {
                                                 
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
}

-(void)archiveCommentWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock{
    NSDictionary *head = @{@"tradeCode" : @"0248",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"merId" : self.merId.length!=0?self.merId:@"",
                           @"page":[NSString stringWithFormat:@"%ld",(long)_commentIndex],
                           @"pageSize":@"10"
                           };
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         self.commentNumber = [object.body objectForKey:@"count"]?[[object.body objectForKey:@"count"] intValue]:0;
                                                         if (self.commentIndex==1) {
                                                             [self.allCommentArr removeAllObjects];
                                                         }
                                                         for (NSDictionary * dic in [object.body objectForKey:@"voList"]) {
                                                             HXCommentModel * model = [HXCommentModel mj_objectWithKeyValues:dic];
                                                             
                                                             [model adjustModel:dic];
                                                             if (model) {
                                                                 
                                                                 [self.allCommentArr addObject:model];
                                                             }
                                                         }
                                                         returnBlock();
                                                     }else {
                                                         failBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     failBlock();
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                 }];
    
    
    
    
    
    
}


-(void)setCommentArr:(NSMutableArray *)commentArr {
    for (HXCommentModel * model in commentArr) {
        [self.allCommentArr addObject:model];
    }
}

-(NSMutableArray *)allCommentArr {
    
    if (_allCommentArr == nil) {
        _allCommentArr = [[NSMutableArray alloc] init];
    }
    return _allCommentArr;
    
}
@end
