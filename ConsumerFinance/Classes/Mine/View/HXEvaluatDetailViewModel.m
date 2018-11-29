//
//  HXEvaluatDetailViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXEvaluatDetailViewModel.h"
#import "HXPhotoModel.h"
@implementation HXEvaluatDetailViewModel
-(void)submitDiscusInformationWithPhotoArr:(NSMutableArray *)photoArr totoal:(NSInteger)tototalNumber serverNum:(NSInteger)serverNum quailNum:(NSInteger)quailNum discussText:(NSString *)discussText returnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (HXPhotoModel * model in photoArr) {
        if (model.photoUrl.length==0) {
            continue;
        }
        [arr addObject:model.photoUrl];
    }
    
    
    NSDictionary *head = @{@"tradeCode" : @"0246",
                           @"tradeType" : @"appService"};
    
    NSDictionary *body = @{@"userUuid" : userUuid,
                           @"orderNo":self.model.orderNo?self.model.orderNo:@"",
                           @"serviceScore":serverNum?[NSString stringWithFormat:@"%ld",serverNum]:@"0",
                           @"qualityScore":quailNum?[NSString stringWithFormat:@"%ld",quailNum]:@"0",
                           @"countScore":tototalNumber?[NSString stringWithFormat:@"%ld",tototalNumber]:@"0",
                           @"content":discussText?discussText:@"",
                           @"imgList":arr
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         
                                                         returnBlock();
                                                     }else {
                                                         fail();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     fail();
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
    
    
    
}
@end
