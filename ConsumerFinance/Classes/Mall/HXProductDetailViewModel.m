//
//  HXProductDetailViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXProductDetailViewModel.h"
#import "HXProductDetailsModel.h"

@implementation HXProductDetailViewModel
-(void)paddingData {
    HXCommentModel * model = [[HXCommentModel alloc] init];
    model.name = @"张小碗儿";
    model.date = @"2017-01-12";
    model.star = 3;
    model.content = @"一个多月啦，鼻子和下巴还是那么漂亮，最近去拍了几组照片，给大家养养眼。哈哈！朋友说我越来越有范了，照片都是时尚大片的感觉。一个多月啦，鼻子和下巴还是那么漂亮，最近去拍了几组照片，给大家养养眼。哈哈！朋友说我越来越有范了，照片都是时尚大片我一个多月啦，鼻子和下巴还是那么漂亮，最近去拍了几组照片，给大家养养眼。哈哈！朋友说我越来越有范了，照片都是时尚大片的感觉。一个多月啦，鼻子和下巴还是那么漂亮，最近去拍了几组照片，给大家养养眼。哈哈！朋友说我越来越有范了，照片都是时尚大片我";
    model.titleHeight = [Helper heightOfString:model.content font:[UIFont systemFontOfSize:13] width:SCREEN_WIDTH-85];
    if (model.titleHeight>85) {
        model.contentLength = YES;
    }else {
        model.contentLength = NO;
    }
    model.photoArr = [[NSMutableArray alloc] initWithArray:@[@"timg.jpeg",@"timg-2.jpeg",@"timg-3.jpeg",@"timg-3.jpeg"]];
    if (model.photoArr.count==0) {
        model.photoHeight = 0;
    }else {
        if (model.photoArr.count%3==0) {
            model.photoHeight = model.photoArr.count/3*80 + (model.photoArr.count/3-1)*9;
        }else {
            model.photoHeight = ((int)(model.photoArr.count/3)+1)*80 + (int)(model.photoArr.count/3)*9;
        }
    }
    NSInteger height = model.contentLength?36:0;
    NSInteger heightLength =model.contentLength ?85:model.titleHeight;
    model.cellHeight = 55+heightLength+26+model.photoHeight+ height;
    
    self.hxcModel = model;
}

-(void)archiveDeatilWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock{
    NSDictionary *head = @{@"tradeCode" : @"0202",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"proId" : _proId?_proId:@"",
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
                                                             self.preDtoModel = [HXPreDtoModel mj_objectWithKeyValues:[object.body objectForKey:@"preDto"]];
                                                             self.merDtoModel = [HXMerDtoModel mj_objectWithKeyValues:[object.body objectForKey:@"merDto"]];
                                                             //                                                         self.preDtoModel.name = @"[海薇玻尿酸] 海薇1ml单相0稀释焕代玻尿酸[海薇玻尿酸] 海薇1ml单相0稀释焕代玻尿酸[海薇玻尿酸] 海薇1ml单相0稀释焕代玻尿酸";
                                                             CGFloat titleHeight = [Helper heightOfString:self.merDtoModel.title font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH-130];
                                                             if (titleHeight > 32) {
                                                                 self.merDtoModel.heightBool=YES;
                                                             }else {
                                                                 self.merDtoModel.heightBool=NO;
                                                             }
                                                             NSArray * arr = [object.body objectForKey:@"imgList"];
                                                             if (arr .count !=0) {
                                                                 
                                                                 [self.bannarArr removeAllObjects];
                                                             }
                                                             for (NSDictionary *dic in [object.body objectForKey:@"imgList"]) {
                                                                 [self.bannarArr addObject:[dic objectForKey:@"imgUrl"]];
                                                             }
                                                             if (self.preDtoModel.name) {
                                                                 
                                                                 float height = [Helper heightOfString:self.preDtoModel.name font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH-30];
                                                                 if (height>30) {
                                                                     self.preDtoModel.titleHeight = 120;
                                                                 }else {
                                                                     self.preDtoModel.titleHeight = 90;
                                                                 }
                                                             }else {
                                                                 self.preDtoModel.titleHeight = 90;
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

-(void)archiveCommentWithReturnBlock:(ReturnValueBlock)returnBlock {
    NSDictionary *head = @{@"tradeCode" : @"0248",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"merId" : self.preDtoModel.merId.length!=0?self.preDtoModel.merId:@"",
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

-(void)creatStatesViewWithShowType:(NSInteger)type{
    if (self.statesView) {
        [self.statesView removeFromSuperview];
    }
    self.statesView = [self creatStatesView:self.controller.view showType:type offset:0  showInformation:^{
        if ([self.controller respondsToSelector:NSSelectorFromString(@"request")]){
            SEL selector = NSSelectorFromString(@"request");
            IMP imp = [self.controller methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self.controller, selector);
            
        }
    }];
}
-(NSMutableArray *)bannarArr {
    if (_bannarArr==nil) {
        _bannarArr = [[NSMutableArray alloc] init];
    }
    return _bannarArr;
}
-(NSMutableArray *)commentArr {
    if (_commentArr == nil) {
        _commentArr = [[NSMutableArray alloc] init];
    }
    return _commentArr;
    
}
@end
