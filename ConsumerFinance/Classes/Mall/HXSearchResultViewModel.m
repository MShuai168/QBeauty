//
//  HXSearchResultViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/29.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXSearchResultViewModel.h"
#import "DtoListModel.h"
#import "VoListModel.h"
#import "HXKeywordModel.h"
@implementation HXSearchResultViewModel
-(void)archiveMerchantdetails:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock{
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    LetterListModel * letterModel;
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    if (city) {
        letterModel = [VoListModel inquiryLetterModelWithName:city];
    }
    NSDictionary *head = @{@"tradeCode" : @"0157",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"cityId" : letterModel.id?letterModel.id:@"",
                           @"keyWord" : _searchContent,
                           @"page" : [NSString stringWithFormat:@"%ld",self.index],
                           @"pageSize" : @"10",
                           @"longitude":self.addressModel.longitude?self.addressModel.longitude:@"",
                           @"latitude":self.addressModel.latitude?self.addressModel.latitude:@"",
                           @"userUuid":userUuid
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray *arr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"dtoList"]) {
                                                             
                                                             DtoListModel * model = [DtoListModel mj_objectWithKeyValues:dic];
                                                             [BeautyClinicModel dealTitleHeightStateWithModl:model];
                                                             if (model) {
                                                                 
                                                                 [arr addObject:model];
                                                             }
                                                             
                                                         }
                                                         if (self.index == 1) {
                                                             [self.dataArr removeAllObjects];
                                                         }
                                                         [self.dataArr addObjectsFromArray:arr];
                                                
                                                         returnBlock(self.dataArr);
                                                     }else {
                                                         failBlock();
                                                     }
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     failBlock();
                                                 }];
    
}
-(void)archiveItemdetails:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock{
    LetterListModel * letterModel;
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    if (city) {
        letterModel = [VoListModel inquiryLetterModelWithName:city];
    }
    NSDictionary *head = @{@"tradeCode" : @"0158",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"cityId" : letterModel.id?letterModel.id:@"",
                           @"keyWord" : _searchContent,
                           @"page" : [NSString stringWithFormat:@"%ld",self.proindex],
                           @"pageSize" : @"10",
                           @"longitude":self.addressModel.longitude?self.addressModel.longitude:@"",
                           @"latitude":self.addressModel.latitude?self.addressModel.latitude:@"",
                           @"userUuid":userUuid
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray *arr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"dtoList"]) {
                                                             
                                                             DtoListModel * model = [DtoListModel mj_objectWithKeyValues:dic];
                                                             [BeautyClinicModel dealTitleHeightStateWithModl:model];
                                                             if (model) {
                                                                 
                                                                 [arr addObject:model];
                                                             }
                                                             
                                                         }
                                                         if (self.proindex == 1) {
                                                             [self.itemArr removeAllObjects];
                                                         }
                                                         [self.itemArr addObjectsFromArray:arr];
                                                         returnBlock(self.itemArr);
                                                     }else {
                                                         failBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     failBlock();
                                                     
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

#pragma mark -- setter
-(NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
-(NSMutableArray *)itemArr {
    if (_itemArr == nil) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}
@end
