//
//  HXClubHouseViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/3.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXClubHouseViewModel.h"
#import "ScreenModel.h"
#import "DtoListModel.h"
@implementation HXClubHouseViewModel
#pragma mark -- 获取地区列表
-(void)archiveAreaWithReturnValueBlock:(ReturnValueBlock)returnBlock {
    NSDictionary *head = @{@"tradeCode" : @"0152",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"cityId":self.letterModel.id ?self.letterModel.id :@""};
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         //                                                         returnBlock(object.body);
                                                         NSMutableArray * arr = [[NSMutableArray alloc] init];;
                                                         for (NSDictionary * dic in [object.body objectForKey:@"voList"]) {
                                                             ScreenModel * model = [ScreenModel mj_objectWithKeyValues:dic];
                                                             [arr addObject:model];
                                                         }
                                                         returnBlock(arr);
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                     
                                                 }];
    
}

-(void)archiveSoreListWithReturnValueBlock:(ReturnValueBlock)returnBlock {
    
    NSDictionary *head = @{@"tradeCode" : @"0154",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{};
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         if (IsEqualToSuccess(object.head.responseCode)) {
                                                             NSMutableArray * arr = [[NSMutableArray alloc] init];;
                                                             for (NSDictionary * dic in [object.body objectForKey:@"sortList"]) {
                                                                 ScreenModel * model = [ScreenModel mj_objectWithKeyValues:dic];
                                                                 [arr addObject:model];
                                                             }
                                                             returnBlock(arr);
                                                         }
                                                     }
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                     
                                                 }];
}
-(void)archiveTenantDataWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock{
    
    NSDictionary *head = @{@"tradeCode" : @"0155",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"cityId":self.letterModel.id ?self.letterModel.id :@"",
                           @"typeIIid":self.hxmallModel.id ?self.hxmallModel.id :@"",
                           @"typeIIIid":self.dockScreen.projectLeftid.length?self.dockScreen.projectLeftid:@"",
                           @"typeIVid":self.dockScreen.projectRightid.length?self.dockScreen.projectRightid:@"",
                           @"areaId":self.dockScreen.areaId.length?self.dockScreen.areaId:@"",
                           @"distId":self.dockScreen.distId.length?self.dockScreen.distId:@"",
                           @"sortFlg":self.dockScreen.sortFlg.length?self.dockScreen.sortFlg:@"",
                           @"page":[NSString stringWithFormat:@"%ld",_shopIndex],
                           @"pageSize":@"10",
                           @"longitude":self.addressModel.longitude?self.addressModel.longitude:@"",
                           @"latitude":self.addressModel.latitude?self.addressModel.latitude:@"",
                           @"distance":self.dockScreen.distance.length?self.dockScreen.distance:@"",
                           @"userUuid":userUuid
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         if (IsEqualToSuccess(object.head.responseCode)) {
                                                             NSMutableArray * arr = [[NSMutableArray alloc] init];
                                                             for (NSDictionary * dic in [object.body objectForKey:@"dtoList"]) {
                                                                 DtoListModel * model = [DtoListModel mj_objectWithKeyValues:dic];
                                                                 CGFloat titleHeight = [Helper heightOfString:model.title font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH-105];
                                                                 if (titleHeight > 32) {
                                                                     model.bigBool=YES;
                                                                 }else {
                                                                     model.bigBool=NO;
                                                                 }
                                                                 [arr addObject:model];
                                                                 
                                                             }
                                                             if (_shopIndex==1) {
                                                                 
                                                                 [self.shopArr removeAllObjects];
                                                             }
                                                             if (arr.count !=0) {
                                                                 
                                                                 [self.shopArr addObjectsFromArray:arr];
                                                             }
                                                             
                                                             returnBlock();
                                                         }
                                                     }else {
                                                         failBlock();
                                                     }
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     failBlock();
                                                     
                                                 }];
    
    
}
-(void)showProjectView:(UIView *)view type:(NSInteger)type {
    if (self.projectStateView) {
        [self.projectStateView removeFromSuperview];
    }
    self.projectStateView = [self creatStatesView:view showType:type offset:0 showInformation:^{
        if ([self.controller respondsToSelector:NSSelectorFromString(@"archiveShop")]){
            SEL selector = NSSelectorFromString(@"archiveShop");
            IMP imp = [self.controller methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self.controller, selector);
            
        }
        
    }];
}


-(NSMutableArray *)shopArr {
    if (_shopArr == nil) {
        _shopArr = [[NSMutableArray alloc] init];
    }
    return _shopArr;
}
@end
