//
//  HXSearchViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/2.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXSearchViewModel.h"
#import "DistListModel.h"
#import "HXKeywordModel.h"

@implementation HXSearchViewModel
-(void)archiveHotType:(ReturnValueBlock)returnBlock {
    
    NSDictionary *head = @{@"tradeCode" : @"0103",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{};
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray * dataArr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"hotKeywordList"]) {
                                                             DistListModel * model = [DistListModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [dataArr addObject:model];
                                                             }
                                                         }
                                                         returnBlock(dataArr);
                                                     }
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                     
                                                 }];
    
}

-(NSMutableArray *)archiveKeyWord{
    NSMutableArray * keyWordArr =[[NSMutableArray alloc] init];
    NSArray * arr = [HXKeywordModel findAll];
    for (HXKeywordModel * model in arr) {
        [keyWordArr addObject:model];
    }
    keyWordArr  = (NSMutableArray *)[[keyWordArr reverseObjectEnumerator] allObjects];
   return keyWordArr;
}
-(void)conserveKeyWord:(NSString *)name {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array = [self archiveKeyWord];
        for (HXKeywordModel * model in array) {
            if ([model.name isEqualToString:name]) {
                [model deleteObject];
            }
        }
        if (array.count > 9) {
            [HXKeywordModel deleteObjectsByCriteria:[NSString stringWithFormat:@"where rowid in (select rowid from %@ order by rowid asc limit 0,%lu)",[HXKeywordModel class],array.count - 9]];
        }
        HXKeywordModel * model = [[HXKeywordModel alloc] init];
        model.name = name;
        [model save];
    });
    
}

@end
