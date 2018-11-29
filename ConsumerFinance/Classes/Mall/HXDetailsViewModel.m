//
//  HXDetailsViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/31.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXDetailsViewModel.h"
#import "HXDetailsModel.h"
#import "HXImgListModel.h"
#import "DtoListModel.h"
@implementation HXDetailsViewModel
-(void)archiveDetailDataWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock{
    NSDictionary *head = @{@"tradeCode" : @"0201",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"merId" : _merId?_merId:@"",
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    if ([self.controller respondsToSelector:NSSelectorFromString(@"bringtoFront")]){
        SEL selector = NSSelectorFromString(@"bringtoFront");
        IMP imp = [self.controller methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self.controller, selector);
        
    }
    [MobClick endEvent:Event_order_detail];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         if (!object.body) {
                                                             [self creatStatesViewWithShowType:2];
                                                             failBlock();
                                                         }else {
                                                             if (self.statesView) {
                                                                 
                                                                 [self.statesView removeFromSuperview];
                                                             }
                                                             self.tenantModel = [HXTenantsModel mj_objectWithKeyValues:[object.body objectForKey:@"dto"]];
                                                             for (NSDictionary * dic in [object.body objectForKey:@"imgDocList"]) {
                                                                 [self.imgDocArr addObject:[dic objectForKey:@"imgUrl"]];
                                                             }
                                                             NSArray * arr = [object.body objectForKey:@"imgList"];
                                                             if (arr .count !=0) {
                                                                 
                                                                 [self.imgListArr removeAllObjects];
                                                                 
                                                             }
                                                             for (NSDictionary * dic in [object.body objectForKey:@"imgList"]) {
                                                                 [self.imgListArr addObject:[dic objectForKey:@"imgUrl"]];
                                                             }
                                                             [self cellHeight];
                                                             
                                                             if (self.tenantModel.name) {
                                                                 
                                                                 float height = [Helper heightOfString:self.tenantModel.name font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH-130];
                                                                 if (height>30) {
                                                                     self.tenantModel.titleHeight = 20;
                                                                 }else {
                                                                     self.tenantModel.titleHeight = 0;
                                                                 }
                                                             }else {
                                                                 self.tenantModel.titleHeight = 0;
                                                             }
                                                             
                                                             returnBlock();
                                                         }
                                                     }else {
                                                         [self creatStatesViewWithShowType:0];
                                                         failBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     [self creatStatesViewWithShowType:0];
                                                     failBlock();
                                                     
                                                 }];
    
}

-(void)archiveRecommendShopReturnBlock:(ReturnValueBlock)returnBlock {
    NSDictionary *head = @{@"tradeCode" : @"0159",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"merId" : _merId.length!=0?_merId:@""
                           };
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         self.recomNumber = [[object.body objectForKey:@"count"] intValue];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"dtoList"]) {
                                                             DtoListModel * model = [DtoListModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [self.dtoListArr addObject:model];
                                                             }
                                                         }
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                 }];
    
    
    
}
-(void)archiveCommentWithReturnBlock:(ReturnValueBlock)returnBlock {
    NSDictionary *head = @{@"tradeCode" : @"0248",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"merId" : _merId.length!=0?_merId:@"",
                           @"page":@"1",
                           @"pageSize":@"10"
                           };
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         self.commentNumber = [[object.body objectForKey:@"count"] intValue];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"voList"]) {
                                                             HXCommentModel * model = [HXCommentModel mj_objectWithKeyValues:dic];
                                                             [model adjustModel:dic];
                                                             if (model) {
                                                                 [self.commentArr addObject:model];
                                                             }
                                                         }
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                 }];
    
    
    
    
    
    
}


#pragma mark -- 计算简介高度
-(void)cellHeight {
    [self changeShopIntroduceHeight];
    if (self.imgDocArr.count ==0) {
        if (self.tenantModel.introduceHeight==0) {
            self.tenantModel.cellHeight = 0;
        }else {
            self.tenantModel.cellHeight = self.tenantModel.introduceHeight+20;
        }
        
    }else {
        if (self.tenantModel.introduceHeight==0) {
            self.tenantModel.cellHeight = 103;
        }else {
            self.tenantModel.cellHeight = self.tenantModel.introduceHeight+113;
        }
        
    }
    
}
-(void)changeShopIntroduceHeight {
    if (self.tenantModel.introduction.length>0) {
        CGFloat titleHeight = [Helper heightOfString:self.tenantModel.introduction font:[UIFont systemFontOfSize:13] width:SCREEN_WIDTH-30];
        self.tenantModel.introduceHeight = titleHeight+2;
    }else {
        self.tenantModel.introduceHeight = 0;
    }
    
}


-(void)paddingData {
    HXCommentModel * model = [[HXCommentModel alloc] init];
    model.name = @"张小碗儿";
    model.date = @"2017-01-12";
    model.star = 3;
    model.content = @"一个多月啦，鼻子和下巴还是那么漂亮，最近去拍了几组照片，给大家养养眼。哈哈！朋友说我越来越有范了，照片都是时尚大片的感觉。";
    model.titleHeight = [Helper heightOfString:model.content font:[UIFont systemFontOfSize:13] width:SCREEN_WIDTH-30];
    model.photoArr = @[@"timg.jpeg",@"timg-2.jpeg",@"timg-3.jpeg",@"timg-3.jpeg"];
    if (model.photoArr.count==0) {
        model.photoHeight = 0;
    }else {
        if (model.photoArr.count%3==0) {
            model.photoHeight = model.photoArr.count/3*80 + (model.photoArr.count/3-1)*9;
        }else {
            model.photoHeight = ((int)(model.photoArr.count/3)+1)*80 + (int)(model.photoArr.count/3)*9;
        }
    }
    model.cellHeight = 55+model.titleHeight+26+model.photoHeight;
    
    self.hxcModel = model;
}

-(void)creatStatesViewWithShowType:(NSInteger)type{
    if (self.statesView) {
        [self.statesView removeFromSuperview];
    }
    self.statesView = [self creatStatesView:self.controller.view showType:type offset:64  showInformation:^{
        if ([self.controller respondsToSelector:NSSelectorFromString(@"getDetaile")]){
            SEL selector = NSSelectorFromString(@"getDetaile");
            IMP imp = [self.controller methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self.controller, selector);
            
        }
    }];
}

#pragma mark -- setter
-(NSMutableArray *)imgListArr {
    if (_imgListArr == nil) {
        _imgListArr = [[NSMutableArray alloc] init];
    }
    return _imgListArr;
}
#pragma mark -- setter
-(NSMutableArray *)imgDocArr {
    if (_imgDocArr == nil) {
        _imgDocArr = [[NSMutableArray alloc] init];
    }
    return _imgDocArr;
}
-(NSMutableArray *)dtoListArr {
    if (_dtoListArr == nil) {
        _dtoListArr = [[NSMutableArray alloc] init];
    }
    return _dtoListArr;
}
-(NSMutableArray *)commentArr {
    if (_commentArr == nil) {
        _commentArr = [[NSMutableArray alloc] init];
    }
    return _commentArr;
    
}
@end
