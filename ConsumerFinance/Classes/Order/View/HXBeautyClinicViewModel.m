//
//  HXBeautyClinicViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/26.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBeautyClinicViewModel.h"
#import "ScreenModel.h"
#import "TravelModel.h"
#import "DtoListModel.h"
@implementation HXBeautyClinicViewModel
- (instancetype)initWithController:(UIViewController *)controller {
    if (self == [super initWithController:controller]) {
        
        
    }
    return self;
}
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
                                                             if (model) {
                                                                 
                                                                 [arr addObject:model];
                                                             }
                                                         }
                                                         returnBlock(arr);
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                     
                                                 }];
    
}
-(void)archiveProjectWithReturnValueBlock:(ReturnValueBlock)returnBlock {
    NSDictionary *head = @{@"tradeCode" : @"0153",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"typeId":self.hxmallModel.id ?self.hxmallModel.id :@"",
                           @"rank":self.hxmallModel.rank ?self.hxmallModel.rank :@""};
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray * arr = [[NSMutableArray alloc] init];;
                                                         for (NSDictionary * dic in [object.body objectForKey:@"typeList"]) {
                                                             TravelModel * model = [TravelModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [arr addObject:model];
                                                             }
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
                                                                 if (model) {
                                                                     
                                                                     [arr addObject:model];
                                                                 }
                                                             }
                                                             returnBlock(arr);
                                                         }
                                                     }
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                     
                                                 }];
}

-(void)archiveProjectDataWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock{
    NSDictionary *head = @{@"tradeCode" : @"0156",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"cityId":self.letterModel.id ?self.letterModel.id :@"",
                           @"typeIIid":self.hxmallModel.id ?self.hxmallModel.id :@"",
                           @"typeIIIid":self.screen.projectLeftid.length?self.screen.projectLeftid:@"",
                           @"typeIVid":self.screen.projectRightid.length?self.screen.projectRightid:@"",
                           @"areaId":self.screen.areaId.length?self.screen.areaId:@"",
                           @"distId":self.screen.distId.length?self.screen.distId:@"",
                           @"sortFlg":self.screen.sortFlg.length?self.screen.sortFlg:@"",
                           @"page":[NSString stringWithFormat:@"%ld",(long)_projectIndex],
                           @"pageSize":@"10",
                           @"longitude":self.addressModel.longitude?self.addressModel.longitude:@"",
                           @"latitude":self.addressModel.latitude?self.addressModel.latitude:@"",
                           @"distance":self.screen.distance.length?self.screen.distance:@"",
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
                                                                 CGFloat titleHeight = [Helper heightOfString:model.title font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH-130];
                                                                 if (titleHeight > 32) {
                                                                     model.bigBool=YES;
                                                                 }else {
                                                                     model.bigBool=NO;
                                                                 }
                                                                 if (model) {
                                                                     
                                                                     [arr addObject:model];
                                                                 }
                                                             }
                                                             if (_projectIndex==1) {
                                                                 
                                                                 [self.projectArr removeAllObjects];
                                                             }
                                                             if (arr.count !=0) {
                                                                 
                                                                 [self.projectArr addObjectsFromArray:arr];
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
                                                                 if (model) {
                                                                     
                                                                     [arr addObject:model];
                                                                 }
                                                                 
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
    self.projectStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
        self.projectIndex = 1;
        if ([self.controller respondsToSelector:NSSelectorFromString(@"archiveProject")]){
        SEL selector = NSSelectorFromString(@"archiveProject");
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
        self.shopIndex = 1;
        if ([self.controller respondsToSelector:NSSelectorFromString(@"archiveShop")]){
            SEL selector = NSSelectorFromString(@"archiveShop");
            IMP imp = [self.controller methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self.controller, selector);
            [MBProgressHUD showMessage:nil toView:self.controller.view];
            
        }
    }];
}
-(NSMutableArray *)projectArr {
    if (_projectArr == nil) {
        _projectArr = [[NSMutableArray alloc] init];
    }
    return _projectArr;
}
-(NSMutableArray *)shopArr {
    if (_shopArr == nil) {
        _shopArr = [[NSMutableArray alloc] init];
    }
    return _shopArr;
}
@end
